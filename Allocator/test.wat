;; Test program for runner.py - reads two numbers, adds them and prints the result
(module
    (import "P0lib" "write" (func $write (param i32)))
    (import "P0lib" "writeln" (func $writeln))
    (import "P0lib" "read" (func $read (result i32)))

    (func $program 
        (local $x i32)
        (local $y i32)
        
        ;; Read 
        call $read
        call $read

        i32.add

        call $write
        call $writeln
    )

    (start $program)
)