(* list 创建*)
let lst1 = [1;2;3;4;5]
let lst2 = 1::2::3::4::5::[]

(* list 原语 *)
let empty lst = lst = []

let head lst =
  match lst with 
  | [] -> failwith "empty list"
  | h :: _ -> h


(* list 访问 *)
(* #1 match pattern *)
let rec sum lst =
  match lst with
  | [] -> 0
  | h :: t -> h + sum t

(* Immediate Matches 对函数最后一个参数进行匹配, 可以简写。和sum 等价 *)
let rec sum2 = function 
 | [] -> 0
 | h :: t -> h + sum2 t

let rec length lst =
  match lst with 
  | [] -> 0
  | _ :: t -> 1 + length t  (* header is not used *)

(** append [1;2] [3;4] ==> [1;2;3;4] *)
let rec append lst1 lst2  = 
  match lst1 with
  | [] -> lst2
  | h :: t -> h :: append t lst2
(*
utop # append [1;2] [3;4];;
- : int/2 list/2 = [1; 2; 3; 4]
*)

(* 尾递归优化 *)
let rec sum_plus_acc (acc: int) (l : int list) : int = 
  match l with 
  | [] -> acc
  | x :: xs -> sum_plus_acc (acc+x) xs


let rec from i j lst =
  if i > j then lst else from i (j-1) (j::lst)  (*只包含对自身的调用，没有其他动作*)