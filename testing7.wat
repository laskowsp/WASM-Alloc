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
(global $y (mut i32) i32.const -1)
(global $z (mut i32) i32.const -1)
(global $a1 (mut i32) i32.const -1)
(global $a2 (mut i32) i32.const -1)
(global $a3 (mut i32) i32.const -1)
(global $a4 (mut i32) i32.const -1)
(global $a5 (mut i32) i32.const -1)
(func $program
i32.const 24
call $malloc
global.set $a1
global.get $a1
i32.const 0
i32.const 1
call $writeAsIntArray
global.get $a1
i32.const 4
i32.const 5
call $writeAsIntArray
i32.const 4
call $malloc
global.set $x
i32.const 4
call $malloc
global.set $y
i32.const 80
call $malloc
global.set $a5
i32.const 1
global.get $x
i32.const 0
call $writeAsInt
i32.const 5
global.get $y
i32.const 0
call $writeAsInt
i32.const 28
call $malloc
global.set $a2
global.get $a2
i32.const 0
i32.const 1
call $writeAsIntArray
global.get $a2
i32.const 6
i32.const 5
call $writeAsIntArray
i32.const 60
call $malloc
global.set $a3
global.get $a3
i32.const 0
i32.const 2
call $writeAsIntArray
global.get $a3
i32.const 14
i32.const 5
call $writeAsIntArray
global.get $a1
call $free
i32.const 4
call $malloc
global.set $z
global.get $a5
call $free
i32.const 8
call $malloc
global.set $a4
loop
global.get $y
i32.const 0
call $readAsInt
i32.const 1000
i32.lt_s
if
global.get $y
i32.const 0
call $readAsInt
i32.const 1
i32.add
global.get $y
i32.const 0
call $writeAsInt
i32.const 8
call $malloc
global.set $a4
br 1
end
end
)
(start $program)
)