(* type 'a tree = 
| Leaf 
| Node of 'a * 'a tree * 'a tree
 *)

(* the code below constructs this tree:
         4
       /   \
      2     5
     / \   / \
    1   3 6   7
*)
(* let t =
  Node(4,
    Node(2,
      Node(1, Leaf, Leaf),
      Node(3, Leaf, Leaf)
    ),
    Node(5,
      Node(6, Leaf, Leaf),
      Node(7, Leaf, Leaf)
    )
  ) *)


type 'a tree =
| Leaf 
| Node of 'a node 
and 
'a node = {
  value: 'a;
  left: 'a tree;
  right: 'a tree;
}

(* represents
      2
     / \
    1   3  *)
let t =
  Node {
    value = 2;
    left = Node {value = 1; left = Leaf; right = Leaf};
    right = Node {value = 3; left = Leaf; right = Leaf}
  }

let rec mem x = function
| Leaf -> false
| Node {value; left; right} -> 
  x = value || mem x left || mem x right

let rec preorder = function
| Leaf -> []
| Node{value; left; right} -> 
  value :: (preorder left) @ (preorder right)
  (* @ 将两个list 拼接起来 *)

  let preorder_lin t =
    let rec pre_acc acc = function
      | Leaf -> acc
      | Node {value; left; right} -> value :: (pre_acc (pre_acc acc right) left)
    in pre_acc [] t
(* 先序遍历是左节点在右节点之前， 所以 value ::left :: right *)

let preorder_lin_v2 t =
  let rec pre_acc t acc =
    match t with
    | Leaf -> acc
    | Node {value; left; right} -> value :: (pre_acc left (pre_acc right acc))
  in pre_acc t [] 
(* 这个写法可能更加突出先 append left 子树 *)