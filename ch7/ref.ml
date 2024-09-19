let x = ref 0;;

(*
取出引用的值
!x
*)

(* 类似二重指针 *)
let y = ref x;;

(* 更新引用地址的值 *)
x := 1

let x = ref 42
let y = ref 42

let z = x  (* z 是 x 的别名 *)

let _ = x := 43
let w = !z + !y

let next_val =
  let counter = ref 0 in
  fun () ->
    incr counter;
    !counter