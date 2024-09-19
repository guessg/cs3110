(* ocaml 模式匹配的常见形式 

## 1. OR 模式
p1 | ... | pn: an “or” pattern; matching against it succeeds if a match succeeds against any of the individual patterns pi, which are tried in order from left to right. All the patterns must bind the same variables.

## 2. 带类型标注 
(p : t): a pattern with an explicit type annotation.

## 3. 匹配常量
c: here, c means any constant, such as integer literals, string literals, and booleans.

'ch1'..'ch2': here, ch means a character literal. For example, 'A'..'Z' matches any uppercase letter.

## 4. 满足条件
p when e: matches p but only if e evaluates to true.   

*)

(* Pokemon types *)
type ptype = TNormal | TFire | TWater

(* A record to represent Pokemon *)
type mon = { name : string; hp : int; ptype : ptype }

(* OK *)
let get_hp m = match m with { name = n; hp = h; ptype = t } -> h

(* better *)
let get_hp m = match m with { name = _; hp = h; ptype = _ } -> h

(* better *)
let get_hp m = match m with { name; hp; ptype } -> hp

(* better *)
let get_hp m = match m with { hp } -> hp

(* best *)
let get_hp m = m.hp

let fst (x, _) = x
let snd (_, y) = y

let thrd t = match t with x, y, z -> z

(* let 模式匹配 *)
let thrd t = let x, y, z = t in z

let thrd t = let _, _, z = t in z

(* 直接对入参进模式匹配 *)
let thrd (_, _, z) = z