(* exception 语法 *)
(* 
exception A  (* 类似 variant enum *)
exception B  (* 类似 variant enum *)
exception Code of int  类似 variant carry data 
*)

(* 创造一个 exception 
Failure "error"  
- : exn = Failure "something went wrong" 
*)

(* 抛出一个 exception *)
(* raise (Failure "something went wrong") *)

(* 捕获一个 exception
    raise (Failure "something went wrong")

    简写形式
    failwith "something went wrong"
*)

(* 
捕获一个 exception 
try e with
| p1 -> e1
| ...
| pn -> en   
*)
(* 
try
    raise (Failure "something went wrong")
with
    Failure x -> print_string x
*)

(* evaluation order *)
(* 
let _ = raise A in raise B
Exception: A.
Called from Topeval.load_lambda in file "toplevel/byte/topeval.ml", line 93, characters 4-14
*)

(*
   
let x = e1 in e2

等价于 
(fun x -> e2) e1

*)

(* 
pair 组件的执行顺序没有定义
   (raise A, raise B) 

   如果想要保证顺序，可以使用 let
   let a = raise A in 
   let b = raise B in 
   (a, b)
*)

(* 异常模式匹配 *)
match List.hd [] with
| [] -> "empty"
| _ :: _ -> "non-empty"
| exception Failure s -> "function failed"

try 
  match e with
    | p1 -> e1
    | p3 -> e3
with
  | p2 -> e2
  | p4 -> e4