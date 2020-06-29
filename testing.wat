(module
(import "P0lib" "write" (func $write (param i32)))
(import "P0lib" "writeln" (func $writeln))
(import "P0lib" "read" (func $read (result i32)))
(import "P0lib" "malloc" (func $malloc (param i32) (result i32)))
(import "P0lib" "free" (func $free (param i32)))
(import "P0lib" "writeAsInt" (func $writeAsInt (param i32) (param i32) (param i32)))
(import "P0lib" "readAsInt" (func $readAsInt (param i32) (param i32) (result i32)))
(import "P0lib" "writeAsIntArray" (func $writeAsIntArray (param i32) (param i32) (param i32)))
(global $x (mut i32) i32.const -1)
(func $program
i32.const 400
call $malloc
global.set $x
global.get $x
i32.const 0
i32.const 2
call $writeAsIntArray
global.get $x
i32.const 1
i32.const 3
call $writeAsIntArray
global.get $x
i32.const 2
global.get $x
i32.const 0
call $readAsInt
global.get $x
i32.const 1
call $readAsInt
i32.add
call $writeAsIntArray
global.get $x
i32.const 2
call $readAsInt
call $write
call $writeln
global.get $x
call $free
)
(start $program)
)