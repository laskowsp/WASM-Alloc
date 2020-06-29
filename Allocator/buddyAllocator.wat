(module
 (type $FUNCSIG$vii (func (param i32 i32)))
 (import "env" "logdata" (func $logdata (param i32 i32)))
 (table 0 anyfunc)
 (memory $0 2)
 (data (i32.const 12) " \00\00\00")
 (data (i32.const 16) "\ff\ff\ff\ff")
 (data (i32.const 32) "\00")
 (data (i32.const 36) "\00\00\00\00")
 (data (i32.const 40) "\00\00\00\00")
 (data (i32.const 44) "\00\00\00\00")
 (data (i32.const 48) "\00\00\00\00")
 (data (i32.const 114752) "\00\00\00\00")
 (export "memory" (memory $0))
 (export "newNode" (func $newNode))
 (export "killNode" (func $killNode))
 (export "expandTree" (func $expandTree))
 (export "allocTree" (func $allocTree))
 (export "freeTree" (func $freeTree))
 (export "getSize" (func $getSize))
 (export "getNext" (func $getNext))
 (export "setNext" (func $setNext))
 (export "readAsInt" (func $readAsInt))
 (export "readAsBool" (func $readAsBool))
 (export "writeAsInt" (func $writeAsInt))
 (export "writeAsBool" (func $writeAsBool))
 (export "calculateUsedBytes" (func $calculateUsedBytes))
 (export "malloc" (func $malloc))
 (export "free" (func $free))
 (func $newNode (; 1 ;) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.lt_s
      (tee_local $2
       (i32.load offset=48
        (i32.const 0)
       )
      )
      (i32.const 1)
     )
    )
    (i32.store offset=48
     (i32.const 0)
     (tee_local $2
      (i32.add
       (get_local $2)
       (i32.const -1)
      )
     )
    )
    (set_local $2
     (i32.load
      (i32.add
       (i32.shl
        (get_local $2)
        (i32.const 2)
       )
       (i32.const 64)
      )
     )
    )
    (br $label$0)
   )
   (i32.store offset=44
    (i32.const 0)
    (i32.add
     (tee_local $2
      (i32.load offset=44
       (i32.const 0)
      )
     )
     (i32.const 1)
    )
   )
   (set_local $2
    (i32.add
     (i32.mul
      (get_local $2)
      (i32.const 20)
     )
     (i32.const 8256)
    )
   )
  )
  (i32.store16 offset=2
   (get_local $2)
   (get_local $1)
  )
  (i32.store16
   (get_local $2)
   (get_local $0)
  )
  (i32.store8 offset=4
   (get_local $2)
   (i32.const 0)
  )
  (i64.store offset=8 align=4
   (get_local $2)
   (i64.const 0)
  )
  (get_local $2)
 )
 (func $killNode (; 2 ;) (param $0 i32)
  (local $1 i32)
  (i32.store offset=48
   (i32.const 0)
   (i32.add
    (tee_local $1
     (i32.load offset=48
      (i32.const 0)
     )
    )
    (i32.const 1)
   )
  )
  (i32.store
   (i32.add
    (i32.shl
     (get_local $1)
     (i32.const 2)
    )
    (i32.const 64)
   )
   (get_local $0)
  )
 )
 (func $expandTree (; 3 ;) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (set_local $1
   (i32.load offset=12
    (i32.const 0)
   )
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.lt_s
      (tee_local $3
       (i32.load offset=48
        (i32.const 0)
       )
      )
      (i32.const 1)
     )
    )
    (i32.store offset=48
     (i32.const 0)
     (tee_local $3
      (i32.add
       (get_local $3)
       (i32.const -1)
      )
     )
    )
    (set_local $2
     (i32.load
      (i32.add
       (i32.shl
        (get_local $3)
        (i32.const 2)
       )
       (i32.const 64)
      )
     )
    )
    (br $label$0)
   )
   (i32.store offset=44
    (i32.const 0)
    (i32.add
     (tee_local $2
      (i32.load offset=44
       (i32.const 0)
      )
     )
     (i32.const 1)
    )
   )
   (set_local $2
    (i32.add
     (i32.mul
      (get_local $2)
      (i32.const 20)
     )
     (i32.const 8256)
    )
   )
  )
  (i32.store16 offset=2
   (get_local $2)
   (get_local $1)
  )
  (i32.store16
   (get_local $2)
   (i32.const 0)
  )
  (i32.store8 offset=4
   (get_local $2)
   (i32.const 0)
  )
  (i64.store offset=8 align=4
   (get_local $2)
   (i64.const 0)
  )
  (set_local $1
   (i32.div_s
    (get_local $1)
    (i32.const 2)
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.lt_s
      (get_local $3)
      (i32.const 1)
     )
    )
    (i32.store offset=48
     (i32.const 0)
     (tee_local $3
      (i32.add
       (get_local $3)
       (i32.const -1)
      )
     )
    )
    (set_local $3
     (i32.load
      (i32.add
       (i32.shl
        (get_local $3)
        (i32.const 2)
       )
       (i32.const 64)
      )
     )
    )
    (br $label$2)
   )
   (i32.store offset=44
    (i32.const 0)
    (i32.add
     (tee_local $3
      (i32.load offset=44
       (i32.const 0)
      )
     )
     (i32.const 1)
    )
   )
   (set_local $3
    (i32.add
     (i32.mul
      (get_local $3)
      (i32.const 20)
     )
     (i32.const 8256)
    )
   )
  )
  (i64.store offset=8 align=4
   (get_local $3)
   (i64.const 0)
  )
  (i32.store16 offset=2
   (get_local $3)
   (get_local $1)
  )
  (i32.store16
   (get_local $3)
   (get_local $1)
  )
  (i32.store8 offset=4
   (get_local $3)
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (get_local $2)
    (i32.const 8)
   )
   (get_local $0)
  )
  (i32.store
   (i32.add
    (get_local $2)
    (i32.const 12)
   )
   (get_local $3)
  )
  (get_local $2)
 )
 (func $allocTree (; 4 ;) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (set_local $3
   (i32.const -1)
  )
  (block $label$0
   (br_if $label$0
    (i32.load8_u offset=4
     (get_local $2)
    )
   )
   (set_local $7
    (i32.add
     (get_local $2)
     (i32.const 4)
    )
   )
   (block $label$1
    (block $label$2
     (loop $label$3
      (br_if $label$2
       (i32.lt_s
        (tee_local $3
         (i32.load16_u offset=2
          (get_local $2)
         )
        )
        (get_local $0)
       )
      )
      (block $label$4
       (br_if $label$4
        (i32.eq
         (get_local $3)
         (get_local $0)
        )
       )
       (br_if $label$2
        (i32.eq
         (get_local $3)
         (i32.const 1)
        )
       )
       (block $label$5
        (br_if $label$5
         (tee_local $7
          (i32.load offset=8
           (get_local $2)
          )
         )
        )
        (set_local $7
         (i32.const 0)
        )
        (br_if $label$5
         (i32.load offset=12
          (get_local $2)
         )
        )
        (set_local $5
         (i32.shr_u
          (get_local $3)
          (i32.const 1)
         )
        )
        (set_local $4
         (i32.load16_u
          (get_local $2)
         )
        )
        (block $label$6
         (block $label$7
          (br_if $label$7
           (i32.lt_s
            (tee_local $7
             (i32.load offset=48
              (i32.const 0)
             )
            )
            (i32.const 1)
           )
          )
          (i32.store offset=48
           (i32.const 0)
           (tee_local $7
            (i32.add
             (get_local $7)
             (i32.const -1)
            )
           )
          )
          (set_local $3
           (i32.load
            (i32.add
             (i32.shl
              (get_local $7)
              (i32.const 2)
             )
             (i32.const 64)
            )
           )
          )
          (br $label$6)
         )
         (i32.store offset=44
          (i32.const 0)
          (i32.add
           (tee_local $3
            (i32.load offset=44
             (i32.const 0)
            )
           )
           (i32.const 1)
          )
         )
         (set_local $3
          (i32.add
           (i32.mul
            (get_local $3)
            (i32.const 20)
           )
           (i32.const 8256)
          )
         )
        )
        (i64.store offset=8 align=4
         (get_local $3)
         (i64.const 0)
        )
        (i32.store16 offset=2
         (get_local $3)
         (get_local $5)
        )
        (i32.store16
         (get_local $3)
         (get_local $4)
        )
        (i32.store8 offset=4
         (get_local $3)
         (i32.const 0)
        )
        (i32.store
         (tee_local $5
          (i32.add
           (get_local $2)
           (i32.const 8)
          )
         )
         (get_local $3)
        )
        (set_local $6
         (i32.add
          (tee_local $4
           (i32.shr_u
            (i32.load16_u
             (i32.add
              (get_local $2)
              (i32.const 2)
             )
            )
            (i32.const 1)
           )
          )
          (i32.load16_u
           (get_local $2)
          )
         )
        )
        (block $label$8
         (block $label$9
          (br_if $label$9
           (i32.lt_s
            (get_local $7)
            (i32.const 1)
           )
          )
          (i32.store offset=48
           (i32.const 0)
           (tee_local $3
            (i32.add
             (get_local $7)
             (i32.const -1)
            )
           )
          )
          (set_local $3
           (i32.load
            (i32.add
             (i32.shl
              (get_local $3)
              (i32.const 2)
             )
             (i32.const 64)
            )
           )
          )
          (br $label$8)
         )
         (i32.store offset=44
          (i32.const 0)
          (i32.add
           (tee_local $3
            (i32.load offset=44
             (i32.const 0)
            )
           )
           (i32.const 1)
          )
         )
         (set_local $3
          (i32.add
           (i32.mul
            (get_local $3)
            (i32.const 20)
           )
           (i32.const 8256)
          )
         )
        )
        (i64.store offset=8 align=4
         (get_local $3)
         (i64.const 0)
        )
        (i32.store16 offset=2
         (get_local $3)
         (get_local $4)
        )
        (i32.store16
         (get_local $3)
         (get_local $6)
        )
        (i32.store8 offset=4
         (get_local $3)
         (i32.const 0)
        )
        (i32.store
         (i32.add
          (get_local $2)
          (i32.const 12)
         )
         (get_local $3)
        )
        (set_local $7
         (i32.load
          (get_local $5)
         )
        )
       )
       (br_if $label$0
        (i32.ne
         (tee_local $3
          (call $allocTree
           (get_local $0)
           (get_local $1)
           (get_local $7)
          )
         )
         (i32.const -1)
        )
       )
       (set_local $7
        (i32.add
         (tee_local $2
          (i32.load offset=12
           (get_local $2)
          )
         )
         (i32.const 4)
        )
       )
       (br_if $label$3
        (i32.eqz
         (i32.load8_u offset=4
          (get_local $2)
         )
        )
       )
       (br $label$2)
      )
     )
     (br_if $label$1
      (i32.eqz
       (i32.load offset=8
        (get_local $2)
       )
      )
     )
    )
    (set_local $3
     (i32.const -1)
    )
    (br $label$0)
   )
   (set_local $3
    (i32.const -1)
   )
   (br_if $label$0
    (i32.load offset=12
     (get_local $2)
    )
   )
   (i32.store offset=16
    (get_local $2)
    (get_local $1)
   )
   (i32.store8
    (get_local $7)
    (i32.const 1)
   )
   (return
    (i32.load16_u
     (get_local $2)
    )
   )
  )
  (get_local $3)
 )
 (func $freeTree (; 5 ;) (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (block $label$0
   (block $label$1
    (loop $label$2
     (set_local $3
      (i32.load offset=8
       (get_local $1)
      )
     )
     (block $label$3
      (block $label$4
       (br_if $label$4
        (i32.ne
         (i32.load16_u
          (get_local $1)
         )
         (get_local $0)
        )
       )
       (br_if $label$3
        (get_local $3)
       )
       (br $label$1)
      )
      (br_if $label$0
       (i32.eqz
        (get_local $3)
       )
      )
     )
     (br_if $label$0
      (i32.eqz
       (tee_local $3
        (i32.load offset=12
         (get_local $1)
        )
       )
      )
     )
     (br_if $label$2
      (i32.eqz
       (i32.load8_u offset=4
        (tee_local $1
         (i32.load
          (select
           (tee_local $4
            (i32.add
             (get_local $1)
             (i32.const 12)
            )
           )
           (tee_local $2
            (i32.add
             (get_local $1)
             (i32.const 8)
            )
           )
           (tee_local $3
            (i32.le_u
             (i32.load16_u
              (get_local $3)
             )
             (get_local $0)
            )
           )
          )
         )
        )
       )
      )
     )
    )
    (set_local $3
     (i32.load
      (select
       (get_local $2)
       (get_local $4)
       (get_local $3)
      )
     )
    )
    (block $label$5
     (br_if $label$5
      (i32.eq
       (i32.load16_u
        (get_local $1)
       )
       (get_local $0)
      )
     )
     (call $logdata
      (i32.const 42)
      (i32.const 777)
     )
    )
    (i32.store8
     (i32.add
      (get_local $1)
      (i32.const 4)
     )
     (i32.const 0)
    )
    (block $label$6
     (br_if $label$6
      (i32.load8_u offset=4
       (get_local $3)
      )
     )
     (br_if $label$6
      (i32.load offset=8
       (get_local $3)
      )
     )
     (br_if $label$6
      (i32.load offset=12
       (get_local $3)
      )
     )
     (i32.store
      (i32.add
       (tee_local $0
        (i32.shl
         (tee_local $1
          (i32.load offset=48
           (i32.const 0)
          )
         )
         (i32.const 2)
        )
       )
       (i32.const 64)
      )
      (i32.load
       (get_local $2)
      )
     )
     (i32.store
      (i32.add
       (get_local $0)
       (i32.const 68)
      )
      (i32.load
       (get_local $4)
      )
     )
     (i32.store offset=48
      (i32.const 0)
      (i32.add
       (get_local $1)
       (i32.const 2)
      )
     )
     (i32.store
      (get_local $4)
      (i32.const 0)
     )
     (i32.store
      (get_local $2)
      (i32.const 0)
     )
    )
    (return)
   )
   (br_if $label$0
    (i32.load offset=12
     (get_local $1)
    )
   )
   (br_if $label$0
    (i32.eqz
     (i32.load8_u offset=4
      (get_local $1)
     )
    )
   )
   (i32.store8
    (i32.add
     (get_local $1)
     (i32.const 4)
    )
    (i32.const 0)
   )
   (return)
  )
  (call $logdata
   (i32.const 42)
   (i32.const 4242)
  )
 )
 (func $getSize (; 6 ;) (param $0 i32) (result i32)
  (i32.load16_u align=1
   (i32.add
    (get_local $0)
    (i32.const 49216)
   )
  )
 )
 (func $getNext (; 7 ;) (param $0 i32) (result i32)
  (i32.load16_u align=1
   (i32.add
    (get_local $0)
    (i32.const 49218)
   )
  )
 )
 (func $setNext (; 8 ;) (param $0 i32) (param $1 i32)
  (i32.store16 align=1
   (i32.add
    (get_local $0)
    (i32.const 49218)
   )
   (get_local $1)
  )
 )
 (func $readAsInt (; 9 ;) (param $0 i32) (param $1 i32) (result i32)
  (i32.load align=1
   (i32.add
    (i32.add
     (get_local $0)
     (i32.shl
      (get_local $1)
      (i32.const 2)
     )
    )
    (i32.const 49216)
   )
  )
 )
 (func $readAsBool (; 10 ;) (param $0 i32) (param $1 i32) (result i32)
  (i32.load8_s
   (i32.add
    (i32.add
     (get_local $0)
     (get_local $1)
    )
    (i32.const 49216)
   )
  )
 )
 (func $writeAsInt (; 11 ;) (param $0 i32) (param $1 i32) (param $2 i32)
  (i32.store align=1
   (i32.add
    (i32.add
     (get_local $0)
     (i32.shl
      (get_local $1)
      (i32.const 2)
     )
    )
    (i32.const 49216)
   )
   (get_local $2)
  )
 )
 (func $writeAsBool (; 12 ;) (param $0 i32) (param $1 i32) (param $2 i32)
  (i32.store8
   (i32.add
    (i32.add
     (get_local $0)
     (get_local $1)
    )
    (i32.const 49216)
   )
   (get_local $2)
  )
 )
 (func $calculateUsedBytes (; 13 ;) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (i32.load8_u offset=4
       (get_local $0)
      )
     )
    )
    (set_local $2
     (i32.load offset=16
      (get_local $0)
     )
    )
    (br $label$0)
   )
   (set_local $2
    (i32.const 0)
   )
   (br_if $label$0
    (i32.eqz
     (tee_local $1
      (i32.load offset=8
       (get_local $0)
      )
     )
    )
   )
   (br_if $label$0
    (i32.eqz
     (tee_local $0
      (i32.load offset=12
       (get_local $0)
      )
     )
    )
   )
   (return
    (i32.add
     (call $calculateUsedBytes
      (get_local $1)
     )
     (call $calculateUsedBytes
      (get_local $0)
     )
    )
   )
  )
  (get_local $2)
 )
 (func $malloc (; 14 ;) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (block $label$0
   (br_if $label$0
    (tee_local $5
     (i32.load offset=36
      (i32.const 0)
     )
    )
   )
   (set_local $4
    (i32.load offset=12
     (i32.const 0)
    )
   )
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.lt_s
       (tee_local $1
        (i32.load offset=48
         (i32.const 0)
        )
       )
       (i32.const 1)
      )
     )
     (i32.store offset=48
      (i32.const 0)
      (tee_local $1
       (i32.add
        (get_local $1)
        (i32.const -1)
       )
      )
     )
     (set_local $5
      (i32.load
       (i32.add
        (i32.shl
         (get_local $1)
         (i32.const 2)
        )
        (i32.const 64)
       )
      )
     )
     (br $label$1)
    )
    (i32.store offset=44
     (i32.const 0)
     (i32.add
      (tee_local $1
       (i32.load offset=44
        (i32.const 0)
       )
      )
      (i32.const 1)
     )
    )
    (set_local $5
     (i32.add
      (i32.mul
       (get_local $1)
       (i32.const 20)
      )
      (i32.const 8256)
     )
    )
   )
   (i32.store16 offset=2
    (get_local $5)
    (get_local $4)
   )
   (i32.store16
    (get_local $5)
    (i32.const 0)
   )
   (i32.store8 offset=4
    (get_local $5)
    (i32.const 0)
   )
   (i64.store offset=8 align=4
    (get_local $5)
    (i64.const 0)
   )
   (i32.store offset=36
    (i32.const 0)
    (get_local $5)
   )
  )
  (set_local $4
   (i32.const 1)
  )
  (loop $label$3
   (set_local $4
    (i32.shl
     (tee_local $1
      (get_local $4)
     )
     (i32.const 1)
    )
   )
   (br_if $label$3
    (i32.lt_s
     (get_local $1)
     (get_local $0)
    )
   )
  )
  (block $label$4
   (br_if $label$4
    (i32.ne
     (tee_local $4
      (call $allocTree
       (get_local $1)
       (get_local $0)
       (get_local $5)
      )
     )
     (i32.const -1)
    )
   )
   (loop $label$5
    (set_local $4
     (i32.load offset=12
      (i32.const 0)
     )
    )
    (block $label$6
     (block $label$7
      (br_if $label$7
       (i32.eqz
        (i32.load8_u offset=32
         (i32.const 0)
        )
       )
      )
      (set_local $5
       (call $calculateUsedBytes
        (i32.load offset=36
         (i32.const 0)
        )
       )
      )
      (i32.store offset=12
       (i32.const 0)
       (i32.shl
        (get_local $4)
        (i32.const 1)
       )
      )
      (i32.store offset=114752
       (i32.const 0)
       (i32.add
        (i32.sub
         (get_local $4)
         (get_local $5)
        )
        (i32.load offset=114752
         (i32.const 0)
        )
       )
      )
      (i32.store offset=40
       (i32.const 0)
       (tee_local $4
        (i32.add
         (i32.load offset=40
          (i32.const 0)
         )
         (i32.const 1)
        )
       )
      )
      (call $logdata
       (i32.const 1)
       (get_local $4)
      )
      (call $logdata
       (i32.const 2)
       (i32.load offset=12
        (i32.const 0)
       )
      )
      (call $logdata
       (i32.const 3)
       (i32.div_s
        (i32.load offset=114752
         (i32.const 0)
        )
        (i32.load offset=40
         (i32.const 0)
        )
       )
      )
      (set_local $3
       (i32.load offset=12
        (i32.const 0)
       )
      )
      (br $label$6)
     )
     (i32.store offset=12
      (i32.const 0)
      (tee_local $3
       (i32.shl
        (get_local $4)
        (i32.const 1)
       )
      )
     )
    )
    (set_local $2
     (i32.load offset=36
      (i32.const 0)
     )
    )
    (block $label$8
     (block $label$9
      (br_if $label$9
       (i32.lt_s
        (tee_local $5
         (i32.load offset=48
          (i32.const 0)
         )
        )
        (i32.const 1)
       )
      )
      (i32.store offset=48
       (i32.const 0)
       (tee_local $5
        (i32.add
         (get_local $5)
         (i32.const -1)
        )
       )
      )
      (set_local $4
       (i32.load
        (i32.add
         (i32.shl
          (get_local $5)
          (i32.const 2)
         )
         (i32.const 64)
        )
       )
      )
      (br $label$8)
     )
     (i32.store offset=44
      (i32.const 0)
      (i32.add
       (tee_local $4
        (i32.load offset=44
         (i32.const 0)
        )
       )
       (i32.const 1)
      )
     )
     (set_local $4
      (i32.add
       (i32.mul
        (get_local $4)
        (i32.const 20)
       )
       (i32.const 8256)
      )
     )
    )
    (i32.store16 offset=2
     (get_local $4)
     (get_local $3)
    )
    (i32.store16
     (get_local $4)
     (i32.const 0)
    )
    (i32.store8 offset=4
     (get_local $4)
     (i32.const 0)
    )
    (i64.store offset=8 align=4
     (get_local $4)
     (i64.const 0)
    )
    (set_local $3
     (i32.div_s
      (get_local $3)
      (i32.const 2)
     )
    )
    (block $label$10
     (block $label$11
      (br_if $label$11
       (i32.lt_s
        (get_local $5)
        (i32.const 1)
       )
      )
      (i32.store offset=48
       (i32.const 0)
       (tee_local $5
        (i32.add
         (get_local $5)
         (i32.const -1)
        )
       )
      )
      (set_local $5
       (i32.load
        (i32.add
         (i32.shl
          (get_local $5)
          (i32.const 2)
         )
         (i32.const 64)
        )
       )
      )
      (br $label$10)
     )
     (i32.store offset=44
      (i32.const 0)
      (i32.add
       (tee_local $5
        (i32.load offset=44
         (i32.const 0)
        )
       )
       (i32.const 1)
      )
     )
     (set_local $5
      (i32.add
       (i32.mul
        (get_local $5)
        (i32.const 20)
       )
       (i32.const 8256)
      )
     )
    )
    (i64.store offset=8 align=4
     (get_local $5)
     (i64.const 0)
    )
    (i32.store
     (i32.add
      (get_local $4)
      (i32.const 12)
     )
     (get_local $5)
    )
    (i32.store
     (i32.add
      (get_local $4)
      (i32.const 8)
     )
     (get_local $2)
    )
    (i32.store16 offset=2
     (get_local $5)
     (get_local $3)
    )
    (i32.store16
     (get_local $5)
     (get_local $3)
    )
    (i32.store8 offset=4
     (get_local $5)
     (i32.const 0)
    )
    (i32.store offset=36
     (i32.const 0)
     (get_local $4)
    )
    (br_if $label$5
     (i32.eq
      (tee_local $4
       (call $allocTree
        (get_local $1)
        (get_local $0)
        (get_local $4)
       )
      )
      (i32.const -1)
     )
    )
   )
  )
  (get_local $4)
 )
 (func $free (; 15 ;) (param $0 i32)
  (call $freeTree
   (i32.and
    (get_local $0)
    (i32.const 65535)
   )
   (i32.load offset=36
    (i32.const 0)
   )
  )
 )
)
