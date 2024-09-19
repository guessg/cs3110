type ptype = TNormal | TFire | TWater 
type mon = {name: string; hp: int; ptype: ptype}

let c = {name="Charmander"; hp=39; ptype=TFire};;

(* match pattern on record *)
match c with {name = n; hp = h; ptype = t} -> h;;

(* match pattern on record with wildcard *)
match c with {hp = h; _} -> h;;

