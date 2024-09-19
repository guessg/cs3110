let f ~name1:arg1 ~name2:arg2 = arg1 + arg2;;
f ~name1:1 ~name2:2;; (* 1+2=3 *)

(* 简写形式 *)
let f ~name1 ~name2 = name1 + name2;;
f ~name1:1 ~name2:2;; (* 1+2=3 *)


(* 默认值 *)
let f ?name:(arg1=8) arg2 = arg1 + arg2;;

(* let f2 ?name(arg1=8) ~name2 = arg1 + name2;; *)

let f2 ?(name=8) ~name2 = name + name2;;