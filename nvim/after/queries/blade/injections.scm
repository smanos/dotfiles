; ((php) @injection.content
;     (#set! injection.language "php")
;     (#set! injection.combined))
; ((parameter) @injection.content
;     (#set! injection.language "php")) ; TODO: php_only
; ((php_only) @injection.content
;     (#set! injection.language "php")) ; TODO: php_only


((text) @injection.content
    (#not-has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language php))

; could be bash or zsh
; or whatever tree-sitter grammar you have.
((text) @injection.content
    (#has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language bash))

; 🚧  Available for experimental split_parser see issue #5 
((php_only) @injection.content
    (#set! injection.language php_only))
((parameter) @injection.content

 ; Example Query used in Nova to implement folding

(   (directive_start) @start
    (directive_end) @end.after
    (#set! role block))


(   (bracket_start) @start
    (bracket_end) @end
    (#set! role block))   (#set! injection.language php_only))
