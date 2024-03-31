(literal) @leaf

; append_space
[
  "function"
  (parameters_declaration)
  "="
] @append_space

";" @prepend_antispace @append_empty_softline
