# Menhir 语法

## header 
将这个部分代码复制到 menhir yacc 生成的 parse.ml 文件中
```bash
{%
 some code
%}
```

## declarations 
生命部分说明 lexical token 是什么。其中 <type> 说明 token 携带的数据类型。比如 INT token 将携带一个 ocaml int。
```bash
%token <int> INT
%token <string> ID
%token TRUE
%token FALSE
%token LEQ
%token TIMES
%token PLUS
%token LPAREN
%token RPAREN
%token LET
%token EQUALS
%token IN
%token IF
%token THEN
%token ELSE
%token EOF
```


在 token 定义完毕之后，需要说明结合性和优先级。注意，优先级定义依赖出现的位置。位置靠后，优先级高。

通常正确地描述清楚结合性和优先级并不容易。 可以逐步开发，逐步测试，来保证正确性。
```bash
%nonassoc IN
%nonassoc ELSE
%left LEQ
%left PLUS
%left TIMES # 乘法的优先级比加法高
```

声明结合性和优先级之后，需要说明 parsing 的起点。下面声明表示从名为 prog 的规则开始，解析 prog 返回 Ast.expr 类型的 ocaml 值。
```bash
%start <Ast.expr> prog
```

结束标志
```bash
%%
```

## Rule 规则
Rules 部分包含类似于 BNF 的生产规则，尽管在 BNF 中我们会写 `：：=`, 这些规则只是写 `：`。规则的格式
> The production is the sequence of symbols that the rule matches. A symbol is either a token or the name of another rule. The action is the OCaml value to return if a match occurs. Each production can bind the value carried by a symbol and use that value in its action.
```bash
name:
  | production1 { action1 }
  | production2 { action2 }
  | ...
  ;
```

比如
```bash
prog:
	| e = expr; EOF { e }
	;
	
expr:
	| i = INT { Int i }
	| x = ID { Var x }
	| TRUE { Bool true }
	| FALSE { Bool false }
	| e1 = expr; LEQ; e2 = expr { Binop (Leq, e1, e2) }
	| e1 = expr; TIMES; e2 = expr { Binop (Mult, e1, e2) } 
	| e1 = expr; PLUS; e2 = expr { Binop (Add, e1, e2) }
	| LET; x = ID; EQUALS; e1 = expr; IN; e2 = expr { Let (x, e1, e2) }
	| IF; e1 = expr; THEN; e2 = expr; ELSE; e3 = expr { If (e1, e2, e3) }
	| LPAREN; e=expr; RPAREN {e} 
	;

```

