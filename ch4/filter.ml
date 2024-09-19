let even n = n mod 2 = 0

let rec evens = function 
| [] -> []
| h::t -> if even h then h :: evens t else evens t


let odd n = n mod 2 = 1

let rec odds = function
| [] -> []
| h::t -> if odd h then h :: odds t else odds t


let rec filter p = function
| [] -> []
| h::t -> if p h then h :: filter p t else filter p t

let evens = filter even
let odds = filter odd

(* 尾递归优化 *)
let rec filter_tr_aux p acc = function
| [] -> acc
| h::t -> if p h then filter_tr_aux p (h :: acc) t else filter_tr_aux p acc t

let filter_tr p = filter_tr_aux p []
let lst = filter_tr even [1;2;3;4;5]
(* output
val lst : int list = [4; 2]
*)


let rec filter_aux p acc = function
  | [] -> List.rev acc (* note the built-in reversal *)
  | h :: t -> if p h then filter_aux p (h :: acc) t else filter_aux p acc t

let filter p = filter_aux p []