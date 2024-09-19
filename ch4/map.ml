let rec map f = function
| [] -> []
| h::t -> f h :: map f t

let add1 = map (fun x -> x + 1)
let concat_bang = map (fun x -> x ^ "!")

(*
对比学习标准库版本

标准库版本保证先处理第一个元素，再处理第二个元素，而不是先处理第二个元素，再处理第一个元素
*)

let rec map f = function
| [] -> []
| h::t -> let h' = f h in h' :: map f t

(* 尾递归优化版本 *)
let rec map_tr_aux f acc = function
| [] -> acc
| h::t -> map_tr_aux f (f h :: acc) t

(* cons 操作 :: 是线性时间的 *)

let map_tr f  = map_tr_aux f [] 


let lst = map_tr (fun x -> x + 1) [1;2;3;4;5]
(* output
val lst : int list = [4; 3; 2]  // 注意顺序， 反过来了
*)

(*
尾递归版本会反转列表，所以需要一个反转函数
*)


(*List.rev_map 实现如上， 基于尾递归版本map*)
let lst = List.rev (List.rev_map (fun x -> x + 1) [1;2;3;4;5])
(* output

val lst : int list = [2; 3; 4; 5; 6]
*)
