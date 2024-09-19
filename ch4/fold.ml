(*
fold right

fold from right to left

fold_right f [a1; a2; ...; an] b = f a1 (f a2 ( ... (f an b) ...))

fold_right ( + ) [a; b; c] 0 ==> a + (b + (c + 0))
*)
let rec fold_right_v1 f acc lst = match lst with
  | [] -> acc
  | h :: t -> f h (fold_right_v1 f acc t)


let rec fold_right f lst acc = match lst with
| [] -> acc
| h :: t -> f h (fold_right f t acc)



let rec fold_left f acc = function 
| [] -> acc
| h :: t -> fold_left f (f acc h) t


(*
尾递归
*)

let rec combine f succ = function
  | [] -> succ 
  | x :: xs -> f x (combine f succ xs)


let rec combine_tr f acc = function
  | [] -> acc
  | x :: xs -> combine_tr f (f x acc) xs

  let rec combine f acc = function
  | [] -> acc
  | h :: t ->
    let acc' = combine f acc t in
    f h acc'

let rec combine_tr f acc = function
  | [] -> acc
  | h :: t ->
    let acc' = f acc h in
    combine_tr f acc' t


(*
注意 combine 和 combine_tr 的参数顺序不同

以 sub 为例，
combine 是先递归到最后一个元素，再从后往前计算 (类似 fold right, 不是尾递归)
combine_tr 是先递归到最后一个元素，再从前往后计算 (类似 fold left, 是尾递归)
*)

let sub = combine ( - ) 0
let s = sub [3; 2; 1]

(* 3 - (2 - (1 - 0)) = 2*)

let sub_tr = combine_tr ( - ) 0
let s' = sub_tr [3; 2; 1]
(* (0 - 3) - 2 - 1 = -6 *)


let sum = combine (+) 0
let product = combine ( * ) 1
let concat = combine (^) ""


let length lst =
  List.fold_left (fun acc _ -> acc + 1) 0 lst

let rev lst =
  List.fold_left (fun acc x -> x :: acc) [] lst

let map f lst =
  List.fold_right (fun x acc -> f x :: acc) lst []

let filter f lst =
  List.fold_right (fun x acc -> if f x then x :: acc else acc) lst []