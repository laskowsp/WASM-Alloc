#include <string.h>

int heapSize = 32;
int firstAllocated = -1;
char doMetrics = 1; // If this is 1, we will store the maximum heap size and average free space remaining at heap expansion
// This represents our linear memory in WASM
unsigned char data[65535];

// This is our variable logging function
extern void logdata(int, int);

int heapExpansions = 0;
int bytesFree; // Total bytes free - final average is truncated int form of bytesFree/heapExpanisons

// Defines an allocation block - should always be 4 bytes
typedef struct{
    unsigned short size;
    unsigned short next;
} AllocBlock;

// Getting and setting of allocation block properties

unsigned short getSize(int address){
    AllocBlock block;
    memcpy(&block, data + address, sizeof(AllocBlock));
    return block.size;
}

unsigned short getNext(int address){
    AllocBlock block;   
    memcpy(&block, data + address, sizeof(AllocBlock));
    return block.next;
}

void setNext(int address, unsigned short value){
    AllocBlock block;
    memcpy(&block, data + address, sizeof(AllocBlock));
    block.next = value;
    memcpy(data + address, &block, sizeof(AllocBlock));
}

// Data access functions - this is generatd by P0 so we won't double check array boundaries
// Ints are hardcoded to be 4 bytes because that is how P0 stores them
int readAsInt(int address, int offset){
    int returnVal;
    memcpy(&returnVal, data + address + (4 * offset) + sizeof(AllocBlock), 4);
    return returnVal;
}

void writeAsInt(int address, int offset, int value) {
    memcpy(data + address + (4 * offset) + sizeof(AllocBlock), &value, 4);
}

int calculateFreeBytes(){
    if (firstAllocated == -1){
        // There is nothing allocated, all bytes free
        return heapSize;
    }
    // Anything between 0 and firstAllocated is wasted
    int sum = firstAllocated;
    int position = firstAllocated;
    while (1) {
        unsigned short next = getNext(position);
        if (next != 0) {
            // Add the gaps between blocks to this array
            sum += (next - (position + getSize(position)));
        } else {
            break;
        }
        position = next;
    }
    // Add the gap between the heap size and the final block to this array
    sum += (heapSize - (position + getSize(position)));
    return sum;
}

// Actually allocates to a memory region
// TODO: Grow our heap size when it gets too big

int allocate(int address, unsigned short size, unsigned short next){
    // If the heap size must grow, grow it
    if (address + size + sizeof(AllocBlock) >= heapSize) {
        if (doMetrics){
            bytesFree += calculateFreeBytes();
            while (address + size + sizeof(AllocBlock )>= heapSize){
                heapSize *= 2;
                logdata(1, ++heapExpansions);
            }
            logdata(2, heapSize);
            logdata(3, bytesFree / heapExpansions);
        } else {
            while (address + size + sizeof(AllocBlock)>= heapSize){
                heapSize *= 2;
            }
        }
    }
    AllocBlock block;
    block.size = size + sizeof(AllocBlock);
    block.next = next;
    memcpy(data + address, &block, sizeof(AllocBlock));


    return address;
}

// Our allocation function
int malloc(int size){
    // Can we fit it into the very start of the array? If so, allocate to 0
    if (firstAllocated == -1 || firstAllocated - size >= (int)sizeof(AllocBlock)){
        int ret = allocate(0, size, firstAllocated == -1 ? 0 : firstAllocated);
        firstAllocated = 0;
        return ret;
    }
    // Otherwise we'll have to find a place to put this block
    int position = firstAllocated;

    while (1){
        if(getNext(position) == 0){
            // There's nothing after this one, we can allocate at position + size at position
            int newAddr = position + getSize(position);
            // 0 because we don't have anything after this one
            allocate(newAddr, size, 0);
            // Update the next of the current block
            setNext(position, newAddr);
            return newAddr;
        } else {
            // There is a block after this - see if we can squeeze between it
            unsigned short nextPos = getNext(position);
            if (nextPos - size - (position + getSize(position)) >= (int)sizeof(AllocBlock)){
                // We can fit, first things first we allocate at this position + its size, it's next block is this block's current next block
                unsigned short ret = allocate(position + getSize(position), size, nextPos);
                // Then we have to fix this block's next address to point to the freshly allocated block instead
                setNext(position, ret);
                // Return the allocated address
                return ret;
            }
        }
        // Couldn't allocate after this block, advance to the next one
        position = getNext(position);
    }
}

// Our free function
void free(int address){
    // Get the next address
    unsigned short next = getNext(address);
    if (firstAllocated == address) {
        // This is the first allocated block - if there's a next one, then we make that firstAllocated. If there isn't, we set it to -1.
        firstAllocated = next == 0 ? -1 : next;
        return; 
    } else {
        // Crawl up the allocation blocks until we find what points to this one
        int position = firstAllocated;
        while (1) {
            if (getNext(position) == address){
                // We've found the block pointing to this address, set it's next to this block's next 
                setNext(position, getNext(address));
                // We are now deallocated
                return;
            }
            position = getNext(position); 
        }
    }
}