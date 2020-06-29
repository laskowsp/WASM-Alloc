;; Test program for runner.py - reads two numbers, adds them and prints the result
(module
    (import "P0lib" "write" (func $write (param i32)))
    (import "P0lib" "writeln" (func $writeln))
    (import "P0lib" "read" (func $read (result i32)))
    (import "P0lib" "logdata" (func $logdata (param i32) (param i32)))

    ;; This is a basic first-fit allocator, we store the address of the first allocated block and every other block stores its size and the address of the next block (4 bytes extra)
    ;; Type checking is done by the P0 compiler - at the raw memory level we assume the caller knows what they're doing (and this should only be called by generated compiled code)
    ;; No byte allocation
    ;; Heap size starts at 32 bytes
    (global $heapSize (mut i32) (i32.const 32))
    (global $firstAllocated (mut i32) (i32.const -1))
    
    ;; Blocks are stored as:
    ;; 2 byte: size in bytes
    ;; 2 byte: next block address or 0 if none
    ;; This should be enough for our purposes, 

    (func $getSize (param $n i32) (result i32)
        ;; this is the first two bytes of n - just read that in and return
        local.get $n
        i32.load16_u
    )

    (func $getNext (param $n i32) (result i32)
        ;; This is the next two bytes of n - advance 2, read 2 bytes, return
        local.get $n
        i32.const 2
        i32.add
        i32.load16_u
    )

    ;; These next functions are for manipulating the values - everything is treated as an array, singletons just get treated as an offset 0

    (func $getAsInt (param $n i32) (param $offset i32) (result i32)
        local.get $n
        local.get $offset
        i32.const 2
        i32.shl ;; Mult by 4
        i32.add
        i32.load
    )

    (func $getAsBool (param $n i32) (param $offset i32) (result i32)
        local.get $n
        local.get $offset
        i32.add
        i32.load8_u
    )

    (func $setInt (param $n i32) (param $offset i32) (param $value i32)
        local.get $n
        local.get $offset
        i32.const 2
        i32.shl ;; Mult by 4
        i32.add
        local.get $value
        i32.store
    )

    (func $setBool (param $n i32) (param $offset i32) (param $value i32)
        local.get $n
        local.get $offset
        i32.add
        local.get $value
        i32.store8
    )


    ;; Actually handles the allocation to a memory region
    (func $allocate (param $n i32) (param $size i32) (param $next i32)
        local.get $n
        ;; Store the size - add 4 for this block
        local.get $size
        i32.const 4
        i32.add
        i32.store16
        
        ;; Store the next address
        local.get $n
        ;; Add 2 to store in second half of allocation block
        i32.const 2
        i32.add

        local.get $next
        i32.store16

    )

    ;; calculateMetrics if set to 1 will log memory expansions and count the free memory before expansion
    (func $malloc (param $size i32) (param $calculateMetrics i32) (result i32)
        ;; First - see if there's enough room to allocate between 0 and the first block - we're checking if firstAllocated == -1 || firstAllocated - size >= 4
        ;; >= 4 because we need 4 bytes for the allocation data block
        global.get $firstAllocated
        i32.const -1
        i32.eq
        (if (result i32) 
        (then
            i32.const 1
        )
        (else 
            global.get $firstAllocated
            local.get $size
            i32.sub
            i32.const 4
            i32.ge_s
        )
        )

        ;; If this is true, allocate to 0 and return the value
        (if (result i32)
        (then 
            i32.const 0 ;; Allocating at 0
            local.get $size ;; With our given size
            ;; If we have a first allocated, this becomes next, otherwise it becomes 0 to indicate we have nothing after it 
            global.get $firstAllocated
            i32.const -1
            i32.eq
            (if (result i32)
            (then i32.const 0)
            (else global.get $firstAllocated)
            )
            call $allocate
            ;; Lastly, return 0 because this is where we allocated
            i32.const 0
            return
        )
        (else i32.const 9999)
        )

        i32.const 9999
        return




    )

    ;; Initializes variables of the allocator
    (func $init
        i32.const 32
        global.set $heapSize
        i32.const -1
        global.set $firstAllocated
    )

    ;; This is for quick testing of the allocator - should not be copied into P0 programs
    (func $testCode 
        
        call $init

        ;; Malloc 20 bytes
        i32.const 20
        i32.const 0
        call $malloc

        ;; Print the result
        call $write
        call $writeln

        ;; Get size and next and print those too
        i32.const 0
        call $getSize
        call $write
        call $writeln
        i32.const 0
        call $getNext
        call $write
        call $writeln
    )

    (memory 1)
    (start $testCode)
)