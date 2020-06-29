(module
 (type $FUNCSIG$vii (func (param i32 i32)))
 (import "env" "logdata" (func $logdata (param i32 i32)))
 (table 0 anyfunc)
 (memory $0 2)
 (data (i32.const 12) " \00\00\00")
 (data (i32.const 16) "\ff\ff\ff\ff")
 (data (i32.const 32) "\01")
 (data (i32.const 36) "\00\00\00\00")
 (data (i32.const 65584) "\00\00\00\00")
 (export "memory" (memory $0))
 (export "getSize" (func $getSize))
 (export "getNext" (func $getNext))
 (export "setNext" (func $setNext))
 (export "readAsInt" (func $readAsInt))
 (export "readAsBool" (func $readAsBool))
 (export "writeAsInt" (func $writeAsInt))
 (export "writeAsBool" (func $writeAsBool))
 (export "calculateFreeBytes" (func $calculateFreeBytes))
 (export "allocate" (func $allocate))
 (export "malloc" (func $malloc))
 (export "free" (func $free))
 (func $getSize (; 1 ;) (param $0 i32) (result i32)
  (i32.load16_u align=1
   (i32.add
    (get_local $0)
    (i32.const 48)
   )
  )
 )
 (func $getNext (; 2 ;) (param $0 i32) (result i32)
  (i32.load16_u align=1
   (i32.add
    (get_local $0)
    (i32.const 50)
   )
  )
 )
 (func $setNext (; 3 ;) (param $0 i32) (param $1 i32)
  (i32.store16 align=1
   (i32.add
    (get_local $0)
    (i32.const 50)
   )
   (get_local $1)
  )
 )
 (func $readAsInt (; 4 ;) (param $0 i32) (param $1 i32) (result i32)
  (i32.load align=1
   (i32.add
    (i32.add
     (get_local $0)
     (i32.shl
      (get_local $1)
      (i32.const 2)
     )
    )
    (i32.const 48)
   )
  )
 )
 (func $readAsBool (; 5 ;) (param $0 i32) (param $1 i32) (result i32)
  (i32.load8_s
   (i32.add
    (i32.add
     (get_local $0)
     (get_local $1)
    )
    (i32.const 48)
   )
  )
 )
 (func $writeAsInt (; 6 ;) (param $0 i32) (param $1 i32) (param $2 i32)
  (i32.store align=1
   (i32.add
    (i32.add
     (get_local $0)
     (i32.shl
      (get_local $1)
      (i32.const 2)
     )
    )
    (i32.const 48)
   )
   (get_local $2)
  )
 )
 (func $writeAsBool (; 7 ;) (param $0 i32) (param $1 i32) (param $2 i32)
  (i32.store8
   (i32.add
    (i32.add
     (get_local $0)
     (get_local $1)
    )
    (i32.const 48)
   )
   (get_local $2)
  )
 )
 (func $calculateFreeBytes (; 8 ;) (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (block $label$0
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.eq
       (tee_local $3
        (i32.load offset=16
         (i32.const 0)
        )
       )
       (i32.const -1)
      )
     )
     (set_local $2
      (i32.sub
       (i32.const 0)
       (get_local $3)
      )
     )
     (br_if $label$1
      (i32.eqz
       (tee_local $0
        (i32.load16_u align=1
         (i32.add
          (get_local $3)
          (i32.const 50)
         )
        )
       )
      )
     )
     (set_local $1
      (i32.add
       (get_local $3)
       (i32.const 48)
      )
     )
     (loop $label$3
      (set_local $3
       (i32.sub
        (i32.add
         (i32.add
          (get_local $2)
          (get_local $3)
         )
         (tee_local $4
          (get_local $0)
         )
        )
        (i32.load16_u align=1
         (get_local $1)
        )
       )
      )
      (set_local $1
       (i32.add
        (get_local $4)
        (i32.const 48)
       )
      )
      (set_local $2
       (tee_local $5
        (i32.sub
         (i32.const 0)
         (get_local $4)
        )
       )
      )
      (br_if $label$3
       (tee_local $0
        (i32.load16_u align=1
         (i32.add
          (get_local $4)
          (i32.const 50)
         )
        )
       )
      )
      (br $label$0)
     )
    )
    (return
     (i32.load offset=12
      (i32.const 0)
     )
    )
   )
   (set_local $4
    (get_local $3)
   )
   (set_local $5
    (get_local $2)
   )
  )
  (i32.sub
   (i32.add
    (i32.add
     (get_local $5)
     (get_local $3)
    )
    (i32.load offset=12
     (i32.const 0)
    )
   )
   (i32.load16_u align=1
    (i32.add
     (get_local $4)
     (i32.const 48)
    )
   )
  )
 )
 (func $allocate (; 9 ;) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.eq
        (tee_local $7
         (i32.load offset=16
          (i32.const 0)
         )
        )
        (i32.const -1)
       )
      )
      (set_local $6
       (i32.sub
        (i32.const 0)
        (get_local $7)
       )
      )
      (br_if $label$2
       (i32.eqz
        (tee_local $4
         (i32.load16_u align=1
          (i32.add
           (get_local $7)
           (i32.const 50)
          )
         )
        )
       )
      )
      (set_local $5
       (i32.add
        (get_local $7)
        (i32.const 48)
       )
      )
      (loop $label$4
       (set_local $7
        (i32.sub
         (i32.add
          (i32.add
           (get_local $6)
           (tee_local $8
            (get_local $4)
           )
          )
          (get_local $7)
         )
         (i32.load16_u align=1
          (get_local $5)
         )
        )
       )
       (set_local $5
        (i32.add
         (get_local $8)
         (i32.const 48)
        )
       )
       (set_local $6
        (tee_local $9
         (i32.sub
          (i32.const 0)
          (get_local $8)
         )
        )
       )
       (br_if $label$4
        (tee_local $4
         (i32.load16_u align=1
          (i32.add
           (get_local $8)
           (i32.const 50)
          )
         )
        )
       )
       (br $label$1)
      )
     )
     (set_local $8
      (i32.load offset=12
       (i32.const 0)
      )
     )
     (br $label$0)
    )
    (set_local $8
     (get_local $7)
    )
    (set_local $9
     (get_local $6)
    )
   )
   (set_local $8
    (i32.sub
     (i32.add
      (i32.add
       (get_local $9)
       (get_local $7)
      )
      (i32.load offset=12
       (i32.const 0)
      )
     )
     (i32.load16_u align=1
      (i32.add
       (get_local $8)
       (i32.const 48)
      )
     )
    )
   )
  )
  (call $logdata
   (i32.const 1)
   (get_local $8)
  )
  (block $label$5
   (br_if $label$5
    (i32.lt_s
     (i32.add
      (get_local $1)
      (get_local $0)
     )
     (tee_local $3
      (i32.load offset=12
       (i32.const 0)
      )
     )
    )
   )
   (block $label$6
    (block $label$7
     (block $label$8
      (block $label$9
       (br_if $label$9
        (i32.eqz
         (i32.load8_u offset=32
          (i32.const 0)
         )
        )
       )
       (set_local $8
        (get_local $3)
       )
       (br_if $label$6
        (i32.eq
         (tee_local $7
          (i32.load offset=16
           (i32.const 0)
          )
         )
         (i32.const -1)
        )
       )
       (set_local $6
        (i32.sub
         (i32.const 0)
         (get_local $7)
        )
       )
       (br_if $label$8
        (i32.eqz
         (tee_local $4
          (i32.load16_u align=1
           (i32.add
            (get_local $7)
            (i32.const 50)
           )
          )
         )
        )
       )
       (set_local $5
        (i32.add
         (get_local $7)
         (i32.const 48)
        )
       )
       (loop $label$10
        (set_local $7
         (i32.sub
          (i32.add
           (i32.add
            (get_local $6)
            (tee_local $8
             (get_local $4)
            )
           )
           (get_local $7)
          )
          (i32.load16_u align=1
           (get_local $5)
          )
         )
        )
        (set_local $5
         (i32.add
          (get_local $8)
          (i32.const 48)
         )
        )
        (set_local $6
         (tee_local $9
          (i32.sub
           (i32.const 0)
           (get_local $8)
          )
         )
        )
        (br_if $label$10
         (tee_local $4
          (i32.load16_u align=1
           (i32.add
            (get_local $8)
            (i32.const 50)
           )
          )
         )
        )
        (br $label$7)
       )
      )
      (i32.store offset=12
       (i32.const 0)
       (i32.shl
        (get_local $3)
        (i32.const 1)
       )
      )
      (br $label$5)
     )
     (set_local $8
      (get_local $7)
     )
     (set_local $9
      (get_local $6)
     )
    )
    (set_local $8
     (i32.sub
      (i32.add
       (i32.add
        (get_local $9)
        (get_local $7)
       )
       (get_local $3)
      )
      (i32.load16_u align=1
       (i32.add
        (get_local $8)
        (i32.const 48)
       )
      )
     )
    )
   )
   (i32.store offset=12
    (i32.const 0)
    (i32.shl
     (get_local $3)
     (i32.const 1)
    )
   )
   (i32.store offset=65584
    (i32.const 0)
    (i32.add
     (i32.load offset=65584
      (i32.const 0)
     )
     (get_local $8)
    )
   )
   (i32.store offset=36
    (i32.const 0)
    (tee_local $8
     (i32.add
      (i32.load offset=36
       (i32.const 0)
      )
      (i32.const 1)
     )
    )
   )
   (call $logdata
    (i32.const 1)
    (get_local $8)
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
     (i32.load offset=65584
      (i32.const 0)
     )
     (i32.load offset=36
      (i32.const 0)
     )
    )
   )
  )
  (i32.store16 align=1
   (i32.add
    (get_local $0)
    (i32.const 50)
   )
   (get_local $2)
  )
  (i32.store16 align=1
   (i32.add
    (get_local $0)
    (i32.const 48)
   )
   (i32.add
    (get_local $1)
    (i32.const 4)
   )
  )
  (get_local $0)
 )
 (func $malloc (; 10 ;) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (tee_local $4
      (i32.eq
       (tee_local $1
        (i32.load offset=16
         (i32.const 0)
        )
       )
       (i32.const -1)
      )
     )
    )
    (br_if $label$1
     (i32.gt_s
      (i32.sub
       (get_local $1)
       (get_local $0)
      )
      (i32.const 3)
     )
    )
    (set_local $4
     (i32.add
      (get_local $1)
      (i32.const 48)
     )
    )
    (block $label$2
     (br_if $label$2
      (i32.eqz
       (tee_local $2
        (i32.load16_u align=1
         (tee_local $3
          (i32.add
           (get_local $1)
           (i32.const 50)
          )
         )
        )
       )
      )
     )
     (loop $label$3
      (set_local $4
       (i32.add
        (get_local $1)
        (i32.load16_u align=1
         (get_local $4)
        )
       )
      )
      (br_if $label$0
       (i32.ge_s
        (i32.sub
         (i32.sub
          (tee_local $1
           (i32.and
            (get_local $2)
            (i32.const 65535)
           )
          )
          (get_local $0)
         )
         (get_local $4)
        )
        (i32.const 4)
       )
      )
      (set_local $4
       (i32.add
        (get_local $1)
        (i32.const 48)
       )
      )
      (br_if $label$3
       (tee_local $2
        (i32.load16_u align=1
         (tee_local $3
          (i32.add
           (get_local $1)
           (i32.const 50)
          )
         )
        )
       )
      )
     )
    )
    (i32.store16 align=1
     (get_local $3)
     (tee_local $1
      (call $allocate
       (i32.add
        (get_local $1)
        (i32.load16_u align=1
         (get_local $4)
        )
       )
       (i32.and
        (get_local $0)
        (i32.const 65535)
       )
       (i32.const 0)
      )
     )
    )
    (return
     (get_local $1)
    )
   )
   (drop
    (call $allocate
     (i32.const 0)
     (i32.and
      (get_local $0)
      (i32.const 65535)
     )
     (i32.and
      (select
       (i32.const 0)
       (get_local $1)
       (get_local $4)
      )
      (i32.const 65535)
     )
    )
   )
   (i32.store offset=16
    (i32.const 0)
    (i32.const 0)
   )
   (return
    (i32.const 0)
   )
  )
  (i32.store16 align=1
   (get_local $3)
   (tee_local $1
    (call $allocate
     (get_local $4)
     (i32.and
      (get_local $0)
      (i32.const 65535)
     )
     (i32.and
      (get_local $2)
      (i32.const 65535)
     )
    )
   )
  )
  (i32.and
   (get_local $1)
   (i32.const 65535)
  )
 )
 (func $free (; 11 ;) (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (set_local $1
   (i32.load16_u align=1
    (i32.add
     (get_local $0)
     (i32.const 50)
    )
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.ne
     (tee_local $3
      (i32.load offset=16
       (i32.const 0)
      )
     )
     (get_local $0)
    )
   )
   (i32.store offset=16
    (i32.const 0)
    (select
     (get_local $1)
     (i32.const -1)
     (get_local $1)
    )
   )
   (return)
  )
  (loop $label$1
   (br_if $label$1
    (i32.ne
     (tee_local $3
      (i32.load16_u align=1
       (i32.add
        (tee_local $2
         (get_local $3)
        )
        (i32.const 50)
       )
      )
     )
     (get_local $0)
    )
   )
  )
  (i32.store16 align=1
   (i32.add
    (get_local $2)
    (i32.const 50)
   )
   (get_local $1)
  )
 )
)
