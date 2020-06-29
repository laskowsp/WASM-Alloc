(module
(import "P0lib" "write" (func $write (param i32)))
(import "P0lib" "writeln" (func $writeln))
(import "P0lib" "read" (func $read (result i32)))
(import "P0lib" "malloc" (func $malloc (param i32) (result i32)))
(import "P0lib" "free" (func $free (param i32)))
(import "P0lib" "writeAsInt" (func $writeAsInt (param i32) (param i32) (param i32)))
(import "P0lib" "readAsInt" (func $readAsInt (param i32) (param i32) (result i32)))
(import "P0lib" "writeAsIntArray" (func $writeAsIntArray (param i32) (param i32) (param i32)))
(global $a (mut i32) i32.const -1)
(global $b (mut i32) i32.const -1)
(global $c (mut i32) i32.const -1)
(global $d (mut i32) i32.const -1)
(global $e (mut i32) i32.const -1)
(global $f (mut i32) i32.const -1)
(global $g (mut i32) i32.const -1)
(global $h (mut i32) i32.const -1)
(global $i (mut i32) i32.const -1)
(global $y (mut i32) i32.const 0)
(global $a1 (mut i32) i32.const -1)
(func $program
i32.const 0
global.set $y
loop
global.get $y
i32.const 100
i32.lt_s
if
global.get $y
i32.const 1
i32.add
global.set $y
i32.const 4
call $malloc
global.set $a
i32.const 4
call $malloc
global.set $b
i32.const 4
call $malloc
global.set $c
i32.const 4
call $malloc
global.set $d
i32.const 4
call $malloc
global.set $e
i32.const 4
call $malloc
global.set $f
i32.const 4
call $malloc
global.set $g
i32.const 4
call $malloc
global.set $h
i32.const 4
call $malloc
global.set $i
global.get $b
call $free
global.get $c
call $free
global.get $d
call $free
global.get $g
call $free
global.get $h
call $free
i32.const 4
call $malloc
global.set $c
i32.const 4
call $malloc
global.set $d
i32.const 16
call $malloc
global.set $a1
br 1
end
end
)
(start $program)
)