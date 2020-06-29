#include <string.h>

int heapSize = 32;
int firstAllocated = -1;
char doMetrics = 1; // If this is 1, we will store the maximum heap size and average free space remaining at heap expansion
// This represents our linear memory in WASM
unsigned char data[65535];



// Defines the structure for a node to track memory usage
// NB: This entire thing assumes the heap size starts as a power of 2 and will continue to be one - don't change that
struct Node {
    // The start address of this segment
    unsigned short baseAddr;
    // How big this segment is
    unsigned short sizeOfBlock;
    // Is an object allocated inside this segment? (i.e. NO SPLITTING)
    unsigned char allocated;
    // The left and right branch for this tree
    struct Node* leftChild;
    struct Node* rightChild;
    // The real size of what we're allocating into this block - only useful for metrics
    int realSize;
};

typedef struct Node Node;

// This is the tree in which allocation data is stored.
Node *root = NULL;
// This is where nodes get stored in memory - this does mean we can only ever allocate 2048 nodes at a time in a single program. But it's enough for testing without adding any bloat from emscripten.
Node nodes[2048];
// Freed nodes get put here, we recycle them first before adding more to nodes
Node* deadNodes[2048];



// This is our variable logging function
extern void logdata(int, int);

int heapExpansions = 0;
int nodeNum = 0;
int deadNodeNum = 0;
int bytesFree; // Total bytes free - final average is truncated int form of bytesFree/heapExpanisons

// Defines an allocation block - should always be 4 bytes
typedef struct{
    unsigned short size;
    unsigned short next;
} AllocBlock;



// Helper functions for interacting with a tree

// Creates and sets default values for a new node
Node* newNode(unsigned short base, unsigned short size){
    Node *node;
    if (deadNodeNum > 0){
        // We have a dead node we can recycle
        node = deadNodes[--deadNodeNum];
    } else {
        // We have to assign a new one
        node = &(nodes[nodeNum++]);
    }
    node->baseAddr = base;
    node->sizeOfBlock = size;
    node->allocated = 0;
    node->leftChild = NULL;
    node->rightChild = NULL;
    return node;
}

// Adds a node to the dead pool
void killNode(Node *node){
    deadNodes[deadNodeNum++] = node;
}

// This "rebases" the tree after expanding the heap - new tree has the old tree as left branch, right branch is new memory region of heapSize/2
Node* expandTree(Node* oldRoot){
    Node *newRoot = newNode(0, heapSize);
    Node *sideTree = newNode(heapSize/2, heapSize/2);
    newRoot->leftChild = oldRoot;
    newRoot->rightChild = sideTree;
    return newRoot;
}

// This will find the right place to allocate to. We don't have an allocblock here, so size can be taken literally. The smallest unit is therefore equal to 1 byte but is otherwise a power of 2.
int allocTree(int size, int realSize, Node* tree){
    // Basic sanity checks - if we have something already alloc'd here, return -1 because we can't write over it. Same if this node is too small for the alloc size.
    if (tree->allocated || tree->sizeOfBlock < size){
        return -1;
    }

    // Simplest case: Our size matches this node.
    if (tree->sizeOfBlock == size){
        // Does this node have children?
        if (tree->leftChild == NULL && tree->rightChild == NULL){
            // No children! Allocate to this block and return it's base.
            tree->allocated = 1;
            tree->realSize = realSize;
            return tree->baseAddr;
        } else {
            // This block does have children and going lower won't help - it's already our size. 
            return -1;
        }
    }

    // Final case: This block is bigger. Split it and rerun the algorithm on its children.
    
    // If our size is 1, we can't split, return -1
    if (tree->sizeOfBlock == 1){
        return -1;
    }

    // If we don't have children, make them
    if (tree -> leftChild == NULL && tree->rightChild == NULL){
        tree->leftChild = newNode(tree->baseAddr, tree->sizeOfBlock / 2);
        tree->rightChild = newNode(tree->baseAddr + tree->sizeOfBlock / 2, tree->sizeOfBlock / 2);
    }

    // First we try the right side
    int allocated = allocTree(size, realSize, tree->leftChild);
    // If that fails, return the right side
    return allocated != -1 ? allocated : allocTree(size, realSize,tree->rightChild);
}

void freeTree(unsigned short address, Node *tree){
    if (address == tree->baseAddr && tree->leftChild == NULL && tree->rightChild == NULL && tree->allocated){
        // This should only happen if we are freeing a root allocation - just unalloc it and return
        tree->allocated = 0;
        return;
    } 

    if (tree->leftChild == NULL || tree->rightChild == NULL) {
        logdata(42, 4242); // For debugging - tells us something has gone wrong
        return; // How did we even get here? 
    }

    // Decide which of the children we should investigate
    unsigned char chooseRight = address >= tree->rightChild->baseAddr;
    Node *child = chooseRight ? tree->rightChild : tree->leftChild;
    Node *otherChild = chooseRight ? tree->leftChild : tree->rightChild;

    // If the child isn't allocated, continue this process using that child
    if (child->allocated == 0) {
        return freeTree(address, child);
    }

    // If the child IS allocated and matches our address, free it and check if the other child can be combined
    if (child->baseAddr != address) {
        logdata(42, 777); // We shouldn't be here if the addresses don't match
    }

    // Deallocate this child
    child->allocated = 0;

    // Check if the other child can be deallocated
    if (otherChild->allocated == 0 && otherChild->leftChild == NULL && otherChild->rightChild == NULL){
        // Both children can be deallocated - combine the memory segment
        killNode(tree->leftChild);
        killNode(tree->rightChild);
        tree->leftChild = NULL;
        tree->rightChild = NULL;
    }

}



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
    memcpy(&returnVal, data + address + (4 * offset), 4);
    return returnVal;
}

char readAsBool(int address, int offset){
    char returnVal;
    memcpy(&returnVal, data + address + offset, 1);
    return returnVal;
}

void writeAsInt(int address, int offset, int value) {
    memcpy(data + address + (4 * offset), &value, 4);
}

void writeAsBool(int address, int offset, char value) {
    memcpy(data + address + offset, &value, 1);
}

int calculateUsedBytes(Node *tree){
    // Sum up all usefully used bytes - free bytes is heapSize - used
    int sum = firstAllocated;
    if (tree->allocated){
        return tree->realSize;
    }
    if (tree->leftChild != NULL && tree->rightChild != NULL){
        return calculateUsedBytes(tree->leftChild) + calculateUsedBytes(tree->rightChild);
    }

    return 0;
}

// Our allocation function
int malloc(int size){
    // If we don't have a tree, now's a great time to make one
    if (root == NULL){
        root = newNode(0, heapSize);
    }

    // We need to scale this up to a power of 2
    int roundedSize = 1;
    while (roundedSize < size){
        roundedSize <<= 1;
    }
    // Allocate this to the tree and return the value
    while (1){
        int allocated = allocTree(roundedSize, size, root);
        // If we allocated successfully we won't get -1 - if we did, grow the tree and try again
        if (allocated == -1){
            if (doMetrics){
                bytesFree += (heapSize - calculateUsedBytes(root));
                heapSize *= 2;
                logdata(1, ++heapExpansions);
                logdata(2, heapSize);
                logdata(3, bytesFree / heapExpansions);
            } else {
                heapSize *= 2;
            }
            root = expandTree(root);
        } else {
            return allocated;
        }
    }
    
}

// Our free function
void free(int address){
    freeTree(address, root);
}