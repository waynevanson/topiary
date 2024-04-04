;; Allow blank line before
[
  (function_declaration)
  (module_declaration)
  (function)
  (comment)
  (transform_chain)
  (assignment)
  (for_block)
  (if_block)
  (let_block)
  (union_block)
  (intersection_for_block)
  (assign_block)
] @allow_blank_line_before

;; semicolon means end of line
";" @prepend_antispace @append_hardline

;; Space before.
[
  (include_path)
] @prepend_space

;; Space around.
[ 
  "="
  "+"
  "-"
  "/"
  "*"
  "^"
  "%"
] @prepend_space @append_space

;; Space after.
[
 "module"
 ","
 "if"
 "else"
] @append_space

(
  function_declaration
  "function" @append_space
)

;; Hardline after.
[
  (union_block)
  (comment)
] @append_hardline

;; Hardline before.
[
  (use_statement)
  (include_statement)
] @prepend_hardline

;; Function literals
(
  (
    function
    body: (_)
      @prepend_input_softline
      @prepend_indent_start
      @append_indent_end
  ) 
)

;; Union block with no children should be on one line
;;
;; module name() {}
(
  union_block
  "{" @prepend_space @append_space
  .
  "}" @append_hardline
)

;; Union block with children should span it's content over
;; multiple lines
;;
;; module name() {
;;   child();
;; }
(
  union_block
  "{" @prepend_space @append_hardline @append_indent_start
  (_)
  "}" @prepend_indent_end @prepend_hardline
)

;; Lists

;; Delete the comma if it's single line context
(
  list
  (expression)
  "," @delete
  .
  "]" @prepend_antispace
  (#single_line_only!)
) 

;; Add comma if multi line context
(
  list
  (expression) @append_delimiter
  .
  "]" @prepend_antispace
  (#delimiter! ",")
  (#multi_line_only!)
) 

;; format on multiple lines if 1 is multiline
(
  list
  "[" @append_indent_start @append_hardline
  ((_) "," @append_spaced_softline)*
  "]" @prepend_hardline @prepend_indent_end
  (#multi_line_only!)
)

;; Ternary operators

;; Space around
(
  ternary_expression
  (_) @append_space @prepend_space
)

;; Indents
(
  ternary_expression
  condition: (_) @append_indent_start @append_spaced_softline
  consequence: (_) @append_spaced_softline
  alternative: (_) @append_indent_end
  (#multi_line_only!)
)

;; List comprehension

;; Module calls

(
  transform_chain
  (module_call) @append_spaced_softline
  (transform_chain)
)

;; IF block
(
  if_block
  condition: (_) @append_space
  consequence: (_)
)