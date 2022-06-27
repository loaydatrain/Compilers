#lang racket
(require racket/set racket/stream)
(require racket/fixnum)
(require graph)
(require data/queue)	

(require "interp.rkt")
(require "interp-Lint.rkt")
(require "interp-Lvar.rkt")
(require "interp-Cvar.rkt")
(require "interp-Cif.rkt")
(require "interp-Cwhile.rkt")
(require "interp-Cvec.rkt")
(require "interp-Cfun.rkt")
(require "interp-Lif.rkt")
(require "interp-Lwhile.rkt")
(require "interp-Lvec.rkt")
(require "interp-Lfun.rkt")
(require "type-check-Lvar.rkt")
(require "type-check-Lif.rkt")
(require "type-check-Lwhile.rkt")
(require "type-check-Lvec.rkt")
(require "type-check-Lfun.rkt")
(require "type-check-Cvar.rkt")
(require "type-check-Cif.rkt")
(require "type-check-Cwhile.rkt")
(require "type-check-Cvec.rkt")
(require "type-check-Cfun.rkt")
(require "utilities.rkt")
(require "multigraph.rkt")
(require "graph-printing.rkt")
(require "./priority_queue.rkt")

(provide (all-defined-out))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lint examples
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The following compiler pass is just a silly one that doesn't change
;; anything important, but is nevertheless an example of a pass. It
;; flips the arguments of +. -Jeremy

;; Next we have the partial evaluation pass described in the book.
(define (pe-neg r)
  (match r
    [(Int n) (Int (fx- 0 n))]
    [else (Prim '- (list r))]))

(define (pe-add r1 r2)
  (match* (r1 r2)
    [((Int n1) (Int n2)) (Int (fx+ n1 n2))]
    [(_ _) (Prim '+ (list r1 r2))]))

(define (pe-exp-helper e)
    (match e
    [(Prim '- (list e1)) (pe-neg (pe-exp e1))]
    [(Prim '+ (list e1 e2)) (pe-add (pe-exp e1) (pe-exp e2))]
    [(Let var e1 e2) (Let var (pe-exp e1) (pe-exp e2))]
    )
)
(define (pe-exp e)
  (match e
    [(Int n) (Int n)]
    [(Var v) (Var v)]
    [(Prim 'read '()) (Prim 'read '())]
    [_ (pe-exp-helper e)]
))


(define (pe-Lint p)
  (match p
    [(Program info e) (Program info (pe-exp e))]))

(define (register-color regOrCol)
  (match regOrCol
    [8 (Reg 'r12)]
    [3 (Reg 'rdi)]
    [(Reg 'r12) 8]
    [7 (Reg 'rbx)]
    [(Reg 'rcx) 0]
    [(Reg 'rdx) 1]
    [10 (Reg 'r14)]
    [(Reg 'rsi) 2]
    [(Reg 'r10) 6]
    [(Reg 'r15) -5]
      [1 (Reg 'rdx)]
    [2 (Reg 'rsi)]
     [5 (Reg 'r9)]
    [9 (Reg 'r13)]
    [6 (Reg 'r10)]
    [(Reg 'rdi) 3]
    [(Reg 'r8) 4]
    [(Reg 'r9) 5]
    [(Reg 'rbx) 7]
    [(Reg 'r13) 9]
    [0 (Reg 'rcx)]
    [(Reg 'r14) 10]
    [(Reg 'rax) -1]
    [(Reg 'rsp) -2]
    [4 (Reg 'r8)]
    [(Reg 'rbp) -3]
    [(Reg 'r10) 6]
    [(Reg 'r11) -4]
  )
)
 (define (get-registers type)
  (cond 
    [(equal? type "caller") (set (Reg 'r8)(Reg 'r9)(Reg 'r10) (Reg 'r11)(Reg 'rax) (Reg 'rsi)(Reg 'rcx)(Reg 'rdi)(Reg 'rdx))]
    [(equal? type "callee") (list (Reg 'r12) (Reg 'r13) (Reg 'r14)(Reg 'r15)(Reg 'rbp)(Reg 'rbx)(Reg 'rsp))]
    [(equal? type "argument") (set (Reg 'rdi) (Reg 'rsi) (Reg 'rdx) (Reg 'rcx) (Reg 'r8) (Reg 'r9))]
    [(equal? type "all") (list
        (Reg 'rcx)
        (Reg 'rdx)
        (Reg 'rsi)
        (Reg 'rdi)
        (Reg 'r8)
        (Reg 'r9)
        (Reg 'r10)
        (Reg 'rbx)
        (Reg 'r12)
        (Reg 'r13)
        (Reg 'r14)
        (Reg 'rax)
        (Reg 'rsp)
        (Reg 'rbp)
        (Reg 'r15)
        (Reg 'r11)
    )]
  )
)   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HW1 Passes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (shrinker-help e)
    (match e 
    [(SetBang v exp) (SetBang v (shrinker exp))]
    [(Prim 'or (list e1 e2))
        (If (shrinker e1) (Bool #t) (shrinker e2) )]
     [(Prim 'and (list e1 e2))
        (If (shrinker e1) (shrinker e2) (Bool #f))]
    [(WhileLoop exp1 exp2) (WhileLoop (shrinker exp1) (shrinker exp2))]
    [(Begin es exp) 
    (define es2 es)
        ;(display es2)
        (Begin (for/list ([e es]) (shrinker e)) (shrinker exp))]
    [(HasType exp type) 
    (define shrinked (shrinker exp) )
    (HasType shrinked type)
    ]
    [
        (Apply fn es)
        ;;; (display "insided help") 
        (Apply (shrinker-help fn) (for/list ([exp es]) (shrinker-help exp)))
    ]
    [(Prim op es)
        ;;; (display "insided prim shirnk") 
     (Prim op (for/list ([e1 es]) (shrinker e1)))
    ]
    [_ e]
    )
)
(define (shrinker e)
  (match e
    [(If cond e1 e2)
     (If (shrinker cond) (shrinker e1) (shrinker e2))]
    
    [(Prim '- (list e1 e2))
     (Prim '+ (list (shrinker e1) (Prim '- (list (shrinker e2)))))]
     [(Let x e1 body)
     (Let (shrinker x) (shrinker e1) (shrinker body))] 
    [_ (shrinker-help e)]
    )
  )

(define (shrink p)
    (match p
        [(ProgramDefsExp info dfList e)
            (define varf (append dfList (list (Def 'main '() 'Integer '() e))))
            (set! dfList varf) 
            (ProgramDefs info (for/list ([df dfList]) (Def (Def-name df) (Def-param* df) (Def-rty df) (Def-info df) (shrinker-help (Def-body df)))))]))

;; uniquify : R1 -> R1
(define (uniquify p)
  ;(display "entered uniquify")
  (match p
    [(ProgramDefs info dfList) 
        (define fnE '())
        (for/list ([df dfList])
            (define newFnName (gensym (Def-name df)))
            (cond
                [(eq? (Def-name df) 'main) (set! newFnName 'main)]
                [else (set! newFnName newFnName)]
            )
            (define varnf (dict-set fnE (Def-name df) newFnName))
            (set! fnE varnf ))
        (ProgramDefs info
            (for/list ([df dfList]) 
                ((uniquify-exp fnE) df)
            )
        )
    ]
    )
  )

(define (uniquify-exp env)
  (lambda (e)
    (match e
        [(Int n) e]
        [(Var x)
            (Var (dict-ref env x))]
        [(Bool b) (Bool b)]
        [(Void) (Void)]
        [(Let x e body)
            (define x1 (gensym x))
            (define e1 ((uniquify-exp env) e))
            (define env1 (dict-set env x x1))
            (define body1 ((uniquify-exp env1) body))
            (Let x1 e1 body1)]
        [(If cond e1 e2)
            (define c ((uniquify-exp env) cond))
            (define then ((uniquify-exp env) e1))
            (define else ((uniquify-exp env) e2))
            (If c then else)]
        [(SetBang v exp) (define ecl '())(SetBang (dict-ref env v) ((uniquify-exp env) exp))]
        [(WhileLoop exp1 exp2) (define e1 ((uniquify-exp env) exp1)) (define e2 ((uniquify-exp env) exp2)) (WhileLoop  e1 e2)]
        [(Begin es exp) (Begin (for/list ([e es]) (define bloced '()) ((uniquify-exp env) e)) ((uniquify-exp env) exp))]
        [(HasType exp type) (define e1 ((uniquify-exp env) exp)) (HasType e1 type)]
        [(Apply fn es) (Apply ((uniquify-exp env) fn) (for/list ([exp es]) ((uniquify-exp env) exp)))]
        [(Def name params rty info body) 
            (define new_params
                ;;; (display "insided def uni")
                (for/list ([prm params]) 
                    (match prm
                        [(cons var type)
                        ;;; (display "insided def uni2")

                            (define newVar (gensym var))(define newf (dict-set env var newVar))
                            (set! env newf)(cons newVar type)])))
            (define new_name (dict-ref env name))
            (Def new_name new_params rty info ((uniquify-exp env) body))
        ]
        [(Prim op es) (Prim op (for/list ([e es]) ((uniquify-exp env) e)))]
        )
    )
)
(define (rfh e fnm)
    (match e
        [(Var v) 
        (if (eq? (dict-ref fnm v #f) #f) (Var v) (FunRef v (dict-ref fnm v)))
        ]
        [(Let x e1 body) 
        (define a (rfh x fnm))
        (define b (rfh e1 fnm))
        (define c (rfh body fnm))
        (Let a b c)]
        [(If cond e1 e2) 
        (define c1 (rfh cond fnm))
        (define e1help (rfh e1 fnm))
        (define e2help (rfh e2 fnm))
        (If c1 e1help e2help)]
        [(SetBang v exp) 
            (define setvar (rfh exp fnm))
            (SetBang v setvar)]
        [(Begin es exp)
            (define exphelper (rfh exp fnm)) 
            (Begin (for/list ([e es]) (rfh e fnm)) exphelper)]
        [(HasType exp type)
            (define exphelper (rfh exp fnm)) 
            (HasType exphelper type)]
        [(WhileLoop exp1 exp2)
            (define exp1helper (rfh exp1 fnm))
            (define exp2helper (rfh exp2 fnm)) 
            (WhileLoop (exp1helper) (exp2helper))]
        [(Apply fn es)
            (define applyvar (rfh fn fnm) ) 
            (Apply applyvar (for/list ([exp es]) (rfh exp fnm)))
        ]
        [(Prim op es) (
            Prim op (for/list ([e1 es])  
            (define helpvar (rfh e1 fnm))
            helpvar))]
        [_ e]
    )
)

(define (reveal-functions p)
    (match p
        [(ProgramDefs info Listd) 
            (define fN (make-hash))
            (for/list ([iter Listd])
                (define len (length (Def-param* iter))) 
                (dict-set! fN (Def-name iter) len )
            )
            ;(display "loop done")
            (ProgramDefs info
                (for/list ([iter Listd])
                    (define body (rfh (Def-body iter) fN))
                    (Def (Def-name iter) (Def-param* iter) (Def-rty iter) (Def-info iter) body)
                )
            )
        ]
    )
)


(define (limit-functions-map params vecName paramMap  ind )
    (cond 
        [(empty?  params) paramMap]
        [else
            (   match (car params)
                [(cons var type)
                    (cond
                        [(< ind 5)  (limit-functions-map  (cdr params) vecName (dict-set paramMap var (Var var)) (+ ind 1))]
                        [else  (limit-functions-map  (cdr params) vecName (dict-set paramMap var (Int (- ind 5)) ) (+ ind 1))]
                    )
                ]
        
            )

        ]
    )
)

(define (limit-functions-params-helper vecName params)
    (define vc '(Vector))
    (for/list ([prm params])
        (match prm
            [`(,x : ,t)
                ;(display "matched???")
                (set! vc (append vc (list t)))]
        )
    )
    (list `(,vecName : ,vc))
)
(define (limit-functions-params params vecName ind )
    (if (empty? params)
        '()
        (if (< ind 5)
            (cons (car params) (limit-functions-params (cdr params) vecName (+ ind 1)))
            (limit-functions-params-helper vecName params)
        )
        
    )
)

(define (limit-functions-prepVec params paramMap vecName ind)
    (cond
    [(empty? params) '()]
    [else  (append (list (limit-functions-body (car params) paramMap vecName)) 
                (limit-functions-prepVec (cdr params) paramMap vecName (+ ind 1)))]
    )
)
(define (limit-functions-fnCall params paramMap vecName [ind 0])
    (cond 
        [(empty? params) '()]
        [else (if (< ind 5) (cons (car params) (limit-functions-fnCall (cdr params) paramMap vecName (+ ind 1))) (list (Prim 'vector (limit-functions-prepVec params paramMap vecName 0))))]
    )
)
(define (limit-functions-body body paramMap vecName)
    (match body
        [(Var x)
            (cond
                [(dict-ref paramMap x #f) (cond 
                [(Var? (dict-ref paramMap x)) (dict-ref paramMap x) ]
                [else (Prim 'vector-ref (list (Var vecName) (dict-ref paramMap x))) ]
                ) ]
                [else (Var x)]
            )
        ]
        [(If cond e1 e2) 
            (define cond1 (limit-functions-body cond paramMap vecName)) 
            (define e11 (limit-functions-body e1 paramMap vecName)) 
            (define e21 (limit-functions-body e2 paramMap vecName))
            (If cond1 e11 e21)]
        [(HasType exp type) 
            (define a (limit-functions-body exp paramMap vecName)) 
            (HasType a type)]
        [(FunRef id n) (FunRef id n)]
        [(SetBang v exp) (define a (limit-functions-body exp paramMap vecName)) (SetBang v a)]
        [(WhileLoop exp1 exp2) 
            (define a (limit-functions-body exp1 paramMap vecName)) 
            (define b (limit-functions-body exp2))
            (WhileLoop a b paramMap vecName)]
        [(Begin es exp) 
            
        (Begin 
            (
                ;;; (disply "inbeign lfb")
                for/list ([body es]) 
                (limit-functions-body body paramMap vecName)
            ) 
            (limit-functions-body exp paramMap vecName)
        )
        ]
        [(Let x e1 body) (define x1 (limit-functions-body x paramMap vecName))(define e2 (limit-functions-body e1 paramMap vecName)) (define body1  (limit-functions-body body paramMap vecName)) (Let x1 e2 body1)]
        [(Apply fn es) (define fn1 (limit-functions-body fn paramMap vecName)) (define es1 (limit-functions-fnCall es paramMap vecName) )(Apply fn1 es1 )]
        [(Prim op es) (Prim op (for/list ([e1 es]) (limit-functions-body e1 paramMap vecName)))]
        [_ body]
    )
)
(define (limit-functions-helper df)
    (define vecName (gensym 'tup))
    (define newBody (limit-functions-body (Def-body df) (limit-functions-map (Def-param* df)  vecName '() 0) vecName))
    (Def (Def-name df) (limit-functions-params (Def-param* df) vecName 0) (Def-rty df) (Def-info df) newBody)
)

(define (limit-functions p)
    (match p 
        [(ProgramDefs info dfList)
            ;(display "matched limit funcs") 
            (ProgramDefs info 
                (for/list ([df dfList]) (limit-functions-helper df)))]))

(define (vectorSet_helper varList vectorName [ind 0])
    (match varList
        [(cons a c) 
        ;(display a)
        (define new-a a)
        (Let (gensym '_) 
        (Prim 'vector-set! (list (Var vectorName) (Int ind) (Var a))) 
        ;(display c)
        (vectorSet_helper c vectorName (+ ind 1)))]
        ['() 
        ;(display "sdf")
        (define vecTemp '())
        (Var vectorName)]
    )
)

(define (get-let-struc varList vectorName len type) 
    (Let (gensym '_) 
    (If (Prim '< (list (Prim '+ (list (GlobalValue 'free_ptr) (Int (* 8 (+ len 1))))) 
    (GlobalValue 'fromspace_end))) (Void) (Collect (* 8 (+ len 1)))) 
        (Let vectorName (Allocate len type) (vectorSet_helper varList  vectorName))
    )
)

(define (has-type-helper es type [varList '()])
    (match es
        ['() 
            (get-let-struc varList (gensym) (length varList) type)
            ; (define (* 8 (+ len 1)) )
        ]
        [else  
            (define curVarName (gensym))
            ;(display curVarName)
            (define curValue1 (car es))
            (Let curVarName 
            (expose_allocation_helper (car es)) 
            ;(display "curVarName")
            (has-type-helper (cdr es) type (append varList (list curVarName))))
        ]
    )
)

(define (expose_allocation_helper2 e)
    (match e 
          [(Begin es exp) 
            ; (displayln "begin")
            (Begin (for/list ([e es]) (expose_allocation_helper e))
             (expose_allocation_helper exp))
            ; (displayln "begin")

        ]
        [(WhileLoop exp1 exp2) 
            (define e1 (expose_allocation_helper exp1))
            (define e2 (expose_allocation_helper exp2))
            ; (displayln "while")
            (WhileLoop e1 e2 )
            ; (displayln "while")

        ]
           [(SetBang v exp) 
            ; (displayln "set")
            (define e (expose_allocation_helper exp))
            (SetBang v  e)
            ; (displayln "set")
        ]
        [(Apply fn es) (Apply (expose_allocation_helper fn) (for/list ([exp es]) (expose_allocation_helper exp)))]
        [(HasType exp type)
            (match exp
                ; (display exp)
                [(Prim 'vector es)(define v (vector)) (has-type-helper es type)]
            )
                ; (display exp)
        ]
        [(Def name params rty info body) (Def name params rty info (expose_allocation_helper body))]
        [_ e]
    )
)

(define (expose_allocation p) 
    (match p 
         [(ProgramDefs info dfList) 
            (ProgramDefs info 
                (for/list ([df dfList]) (expose_allocation_helper df))
            )
        ]
    )
)

(define (expose_allocation_helper e)
    (match e
        [(If cond exp1 exp2)
                ; (display "cond")
            (define a (expose_allocation_helper cond) )
            (define b (expose_allocation_helper exp1) )
                ; (display "cond")
            (define c (expose_allocation_helper exp2) ) 
                ; (display "cond")
         (If a b c)]
        [(Let x e body) 
                ; (display "let')
            (define a (expose_allocation_helper e)) (define b (expose_allocation_helper body))
            (Let x a b)
                ; (display "let")
        ]
        [(Prim op es) 
            (Prim op (for/list ([e es]) (expose_allocation_helper e)))
        ]
        [_ (expose_allocation_helper2 e)]
    )
)


(define (collect-set! e) 
    (match e
        [(Bool b) (set)]
        [(Void) (set)]
        [(Var x) (set)]
        [(Int n) (set)]
        [(WhileLoop exp1 exp2) 
        (define exp-set (collect-set! exp1))
        (define exp2-set (collect-set! exp2))
        (set-union  exp-set exp2-set)]
        [(Begin es exp) 
        ;(display es)
        (set-union (set-union* (for/list ([e es]) (collect-set! e))) 
                                   (collect-set! exp))
        ;(display "begin end")
        ]
        [(Let x rhs body)
         (set-union (collect-set! rhs) (collect-set! body))
         ]
        [(SetBang var rhs) 
            (define a '())
            (set-union (set var) (collect-set! rhs))
            ;(display "var")
            ]
        [(If cond exp1 exp2) 
            (define b '())
            (define cond-set (collect-set! cond))
            (define exp1-set (collect-set! exp1))
            (define exp2-set (collect-set! exp2))
            ;;; (display cond-set)
            (set-union cond-set exp1-set exp2-set)
        ]
        [(Prim op es) (set-union* (for/list ([e es]) (collect-set! e)))]
        [_ (set)]
))

(define ((uncover-get!-exp set!-vars) e)
    (match e
        [(Bool b) (Bool b)]
        [(Void) (Void)]
        [(Begin es exp) 
        ;(display "asdf")
        (Begin (for/list ([e es]) 
        (define newe e)
        ((uncover-get!-exp set!-vars) e)) 
        ;(display e)
        ((uncover-get!-exp set!-vars) exp))]
        [(Int n) (Int n)]
        [(Var x) (Var x)
            (if (set-member? set!-vars x) 
                (GetBang x) 
                (Var x))]
        [(If cond exp1 exp2) 
            ;(display "ifcond")
            (define cond-set ((uncover-get!-exp set!-vars) cond))
            (define exp1-set ((uncover-get!-exp set!-vars) exp1))
            (If cond-set
            exp1-set ((uncover-get!-exp set!-vars) exp2))]
        [(SetBang v exp) (SetBang v ((uncover-get!-exp set!-vars) exp))]
        [(Let x e body) 
        (define body-new body)
            ;(display body)
            (Let x ((uncover-get!-exp set!-vars) e) ((uncover-get!-exp set!-vars) body))]
        [(WhileLoop exp1 exp2) 
        ;(display exp1)
        (define exp1-set ((uncover-get!-exp set!-vars) exp1))
        (WhileLoop exp1-set ((uncover-get!-exp set!-vars) exp2))
        ;(display exp2)
        ]
        [(Def name params rty info body) (Def name params rty info (uncover-get!-exp body))]
        [(Prim op es) 
            ;(display op)
            (Prim op (for/list ([e es]) ((uncover-get!-exp set!-vars) e)))]
        [_ e]
    )
)

(define (uncover-get! p) 
    (match p 
     [(ProgramDefs info dfList) 
            (ProgramDefs info 
                (for/list ([df dfList]) (expose_allocation_helper df))
            )
        ]
    )
)

(define (rco_atm e)
    (match e
        [(Var n) #t]
        [(Int n) #t]
        [(Bool n) #t]
        [(Void) #t]
        [_ #f]
    )
)

(define (rco_atm_applyHelper args fnName [newArgs '()])
    (match args
        ['() (Apply fnName newArgs)]
        [(cons a c) (define tmp (gensym))
                (cond
                    [(rco_atm a) (rco_atm_applyHelper c fnName (append newArgs (list a))) ]
                    [else (Let tmp (remove-complex-operands  a) (rco_atm_applyHelper c fnName (append newArgs (list (Var tmp)))))])
        ]
    )
)
(define (rco-helper e)
    (match e 
     [(Prim op (list e1 e2))
     (define new_e1 (gensym "tmp1"))
     (define new_e2 (gensym "tmp2"))
     (cond
       [(and (atom e1) (atom e2)) (Prim op (list e1 e2))]
       [(and (not (atom e1)) (not (atom e2)))
        (Let new_e1 (remove-complex-operands e1)
             ;(display "new_e1")
             (Let new_e2 (remove-complex-operands e2)
                  (Prim op (list (Var new_e1) (Var new_e2)))))]
       [(and (not (atom e1)) (atom e2))
        (Let new_e1 (remove-complex-operands e1)
             (Prim op (list (Var new_e1) e2)))]
       [(and (atom e1) (not (atom e2)))
        (Let new_e2 (remove-complex-operands e2)
             (Prim op (list e1 (Var new_e2))))]
       )]
    [(Prim op (list e1 e2 e3))
     (define tmp-var (gensym))
     (cond
       [(not (atom e1))
        (Let tmp-var (remove-complex-operands e1) (remove-complex-operands (Prim op (list (Var tmp-var) e2 e3))))
        ]
       [(not (atom e2))
        (Let tmp-var (remove-complex-operands e2) (remove-complex-operands (Prim op (list e1 (Var tmp-var) e3))))
        ]
       [(not (atom e3))
        (Let tmp-var (remove-complex-operands e3) (remove-complex-operands (Prim op (list e1 e2 (Var tmp-var)))))
        ]
       [else (Prim op (list e1 e2 e3))]
       )
     ]
    [(Prim op (list e1))
     (define tmp-var (gensym))
     (cond
       [(atom e1) (Prim op (list e1))]
       [else
        (Let tmp-var (remove-complex-operands e1) (Prim op (list (Var tmp-var))))
        ]
     )
    ]
    [(SetBang v exp) (SetBang v (remove-complex-operands exp))]
    [(WhileLoop exp1 exp2) (WhileLoop (remove-complex-operands exp1) (remove-complex-operands exp2))]
    [(GetBang v) (GetBang v)]
    [(Begin es exp) (Begin (for/list ([e es]) (remove-complex-operands e)) (remove-complex-operands exp))]
     [(FunRef id n) (FunRef id n)]
        [(Apply fn es) (define fnName (gensym 'fName))
            (if (rco_atm fn) (rco_atm_applyHelper es fn) 
                (Let fnName (remove-complex-operands  fn) (remove-complex-operands  (Apply (Var fnName) es)))
            )
        ]
        [(Def name params rty info body) (Def name params rty info (remove-complex-operands  body))]
    [_ e] 
    )
)
(define (remove-complex-operands e)
  (match e
    [(Int n) e]
    [(Var x) e]
    [(Bool b) (Bool b)]
    [(Prim 'read '()) (Prim 'read '())]
    [(Let var x y)
     (define x1 (remove-complex-operands x))
     (define y1 (remove-complex-operands y))
     (Let var x1 y1)]
    [(If cond e1 e2)
     (define x1 (remove-complex-operands cond))
     (define x2 (remove-complex-operands e1))
     (define x3 (remove-complex-operands e2))
     (If x1 x2 x3)]
    [(Prim '- (list e1)) 
     (cond
       [(atom e1) e]
       [else 
        (define var1 (gensym))
        (Let var1 (remove-complex-operands e1) (Prim '- (list (Var var1))))
        ]
       )
     ]
    [(Prim 'not (list e1)) 
     (cond
       [(atom e1) e]
       [else 
        (define var1 (gensym))
        (Let var1 (remove-complex-operands e1) (Prim 'not (list (Var var1))))
        ]
       )
     ]
    [(Prim 'read '()) (Prim 'read '())]
   [_ (rco-helper e)]
      ))



(define (atom e)
    (match e
        [(Void) #t
        ;(display "void atom")
        ]
        [(Bool n) #t]
        [(Var n) #t]
        [(Int n) #t]
        [_ #f]
    )
)

;; remove-complex-opera* : R1 -> R1
(define (remove-complex-opera* p)
  (match p
   [(ProgramDefs info dfList) 
        (ProgramDefs info 
            (for/list ([df dfList]) (remove-complex-operands df))
        )
    ]))


(define basic-blocks '())

(define (create-block tl)
    (match tl
        [(Goto label)
         ;(display label)
         (Goto label)]
        [else (define label (gensym 'block))
            ;(display "in else")
            (set! basic-blocks (cons (cons label tl) basic-blocks))
            (Goto label)]
    )
)

(define (check-cmp sym)
    (match sym
        ['eq? #t]
        ['< #t]
        ['<= #t]
        ['> #t]
        ['>= #t]
        [_ #f]
    ))

(define (explicate_effect e cont) 
    (match e
        [(Prim 'read '()) 
            (define edict '())
            (Seq e cont)
        ]
        [(Prim 'vector-set! es)
         (define pvec '())
         (Seq (Prim 'vector-set! es) cont)
        ]
        [(WhileLoop cnd bdy) 
            (let ([loop (gensym 'loop)])
            (define bomdy '())
            (define body (explicate_pred cnd (explicate_effect bdy (Goto loop)) cont)) 
            (set! basic-blocks (cons (cons loop body) basic-blocks))
            (Goto loop)
            )
        ]
        [(SetBang v exp) (explicate-assign exp v cont)]
        [(If cond exp1 exp2)
            ;(display exp1)
         (explicate_pred cond  (explicate_effect exp1 cont) (explicate_effect exp2 cont) )
         ]
        [(Let x rhs body)
            (define abr (explicate_effect body cont) )
         (explicate-assign rhs x abr)
         ]
        [(Allocate len T) cont]
        [(GlobalValue var) cont]
        [(Collect bytes)
            (define nbytes  (Collect bytes) ) 
            (Seq  nbytes cont)
        ]
        [(Begin es body)
            (match es
            [(list) 
            ;(display "sadf")
            (define stmt '())
            (explicate_effect body cont)]
            [(cons e rest) (explicate_effect e (explicate_effect (Begin rest body) cont))])]
        [_ cont]
    ) 
)

(define (explicate-tail e)
  (match e
    
    [(Bool b) (Return e)]
     [(Var x) (Return e)]
    [(Int n) (Return e)]
    [(GetBang var) (Return (Var var))]
    [(If cond e1 e2)
     (explicate_pred cond (explicate-tail e1) (explicate-tail e2))]
    [(Prim op es) (Return e)]
        [(WhileLoop cnd bdy) (explicate_effect e '())]
        [(Allocate len type) (Return (Allocate len type))]
 [(Let x rhs body)
     (explicate-assign rhs x (explicate-tail body))]
    [(SetBang v exp) (explicate_effect e (Return (Void)))]
        [(GlobalValue var) (Return (GlobalValue var))]
    
        [(Begin es exp) (foldr explicate_effect (explicate-tail exp) es)]
         [(FunRef id n) (Return e)]
        [(Apply fn es) (TailCall fn es)]
    [else (error "explicate-tail unhandled case" e)]))

(define (explicate-assign e x cont)
(match e
    [(Var y)
        (Seq (Assign (Var x) e) cont)]
    [(Int n)
        ;(displayln "idhar error kaise bhai") 
        (Seq (Assign (Var x) e) cont)]

    [(GetBang var)
        ;(displayln "hari") 
        (Seq (Assign (Var x) (Var var)) cont)]
    [(Let y rhs body)
        (explicate-assign rhs y (explicate-assign body x cont))]
    [(If cond e1 e2)
        (define p1 (explicate-assign e1 x cont))
        ;(display p1)
        (define p2 (explicate-assign e2 x cont))
        ;(display p2)
        (explicate_pred cond p1 p2)]
    [(SetBang v exp) (explicate_effect e (Seq (Assign (Var x) (Void)) cont))]
    [(Bool b)
        (define var (gensym))
        ;(display var)
        (Seq (Assign (Var x) (Bool b)) cont)]
    [(Void) (Seq (Assign (Var x) (Void)) cont)]
    [(WhileLoop cnd body)
        (explicate_effect e (Seq (Assign (Var x) (Void)) cont))]
    [(Begin es exp) (foldr explicate_effect (explicate-assign exp x cont) es)]
    [(Allocate len type) (Seq (Assign (Var x) e) cont)]
    [(GlobalValue var) 
        (define newc  '())
        (Seq (Assign (Var x) e) cont)
    ]
    [(Collect bytes) (Seq (Collect bytes) cont)]
    [(Prim op es) (Seq (Assign (Var x) (Prim op es)) cont)]
    [(FunRef id n) (Seq (Assign (Var x) e) cont)]
        [(Apply fn es) (Seq (Assign (Var x) (Call fn es)) cont)]
    [else (error "explicate-assign unhandled case" e)]
    )
)

(define (explicate_control_def df)
    ;(display "in expl control")
    (set! basic-blocks '())
    (define instrBlocks (make-hash))
    (dict-set! instrBlocks (symbol-append (Def-name df) 'start) (explicate-tail (Def-body df)))
    (for ([e basic-blocks]) (dict-set! instrBlocks (car e) (cdr e)))
    (Def (Def-name df) (Def-param* df) (Def-rty df) (Def-info df) instrBlocks)
)

(define (explicate_pred cnd thn els)
    (match cnd
       [(Bool b) (if b thn els)]
       [(Var x) ;((display "fasdf")
                 (IfStmt (Prim 'eq? (list (Var x) (Bool #t)))
                    (create-block thn)
                    (create-block els))
                 ;)
        ]
        [(Let x rhs body) 
            (explicate-assign rhs x (explicate_pred body thn els))    
        ]
        [(If cnd^ thn^ els^)
         (define elsB (create-block els))
         (define thnB (create-block thn))
         (explicate_pred cnd^ (explicate_pred thn^ thnB elsB)
                                 (explicate_pred els^ thnB elsB))]
        [(Begin es exp)
            (define thnBlock (create-block thn))
            (define elsBlock (create-block els)) 
            (explicate_effect (Begin es (Void)) (explicate_pred exp thnBlock elsBlock))]
        [(Prim 'not (list e)) (IfStmt (Prim 'eq? (list e (Bool #f)))
                    (create-block thn)
                    (create-block els))]
                    [(Apply fn es) 
            (define vr (gensym))
            (Seq (Assign (Var vr) (Call fn es)) (IfStmt (Prim 'eq? (list (Var vr) (Bool #t))) 
                                           (create-block thn) (create-block els)
                                     )
            )
        ]
        [(Prim 'vector-ref es) 
            (define tmp (gensym 'tmp))
            (Seq (Assign (Var tmp) cnd) 
                (IfStmt (Prim 'eq? (list (Var tmp) (Bool #t))) (create-block thn) (create-block els)))]
        [(Prim op es) #:when (check-cmp op)
            (IfStmt (Prim op es) (create-block thn) (create-block els))]     
        [_ (error "explicate case not valid" cnd)]
    )
)

(define (explicate_control p)
    (match p
       [(ProgramDefs info dfList) 
            (ProgramDefs info 
                (for/list ([df dfList]) (explicate_control_def df))
            )
        ]    
    )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (select-instructions-atomic a)
  (match a
    [(Var g) a]
    [(Bool #t) (Imm 1)]
    [(Bool #f) (Imm 0)]
    [(Void) (Imm 0)]
    [(Int y)
    (Imm y)]))

(define (cmp-jcc opr)
  (match opr
    ['>= 'ge]
    ['> 'g]
    ['eq? 'e]
    ['< 'l]
    ['<= 'le]

  )
)


 (define (select-instructions-statement tr fname)
   (match tr
     ['() '()]
     [(Seq (Prim 'read '()) t*) (append (list (Callq 'read_int 0)) (select-instructions-statement t* fname))]
     [(Seq (Assign var exp) t*) (append (select-instructions-assignment exp var) (select-instructions-statement t* fname))]
     [(Goto lbl) 
         ; (display "gotolabel")
         (list (Jmp lbl))
     ]
     [(IfStmt (Prim cmp (list e1 e2)) (Goto l1) (Goto l2))
                  ;(display "sadhf")
                  (list
                         (Instr 'cmpq (list (select-instructions-atomic e2) (select-instructions-atomic e1)))
                        (JmpIf (cmp-jcc  cmp) l1)
                        (Jmp l2)
                  )
     ]
     [(Seq (Prim 'vector-set! (list vecName ind rhs)) t*)
                (define offset (* 8 (+ (Int-value ind) 1)))
                 (append (list (Instr 'movq (list vecName (Reg 'r11)))
                              (Instr 'movq (list (select-instructions-atomic rhs) (Deref 'r11 offset)))                         
                         ) 
                         (select-instructions-statement t* fname)
                 )
         ]
         [(Seq (Collect bytes) t*) 
             (append
                 (list 
                         (Instr 'movq (list (Reg 'r15) (Reg 'rdi)))
                       (Instr 'movq (list (Imm bytes) (Reg 'rsi)))
                       (Callq 'collect 2)
                 )
                 (select-instructions-statement t* fname)
             )
         ]
         [(Return exp) 
         (append (select-instructions-assignment exp (Reg 'rax)) 
         (list (Jmp (symbol-append fname 'conclusion))))]

        [(TailCall fname es) (append
            (select-instructions-movArgReg es)
            (list (TailJmp fname (length es)))
        )]
     )
   )

(define (cmp-setcc cmprtr)
  (match cmprtr
    ['<=
     ;(display "leq")
     'setle]
    ['>= 'setge]
    ['< 'setl]
    ['> 'setg]
    ['eq? 'sete]
  )
)
(define (ptr-bool? type)
  (match type
    [`(Vector ,ts ...) #t]
    [_ #f])
)

(define (ptr? type)
  (match type
    [`(Vector ,ts ...) 1]
    [_ 0])
)

(define (get-vector-metadata-helper cur_tag ptype cur_ind)
    (bitwise-ior cur_tag (arithmetic-shift ptype cur_ind))
)

(define (get-vector-metadata len T cur_tag cur_ind)
    (define initial_tag (get-vector-metadata-helper 1 len 1))
    (for/fold ([cur_tag initial_tag])
            ([type T]
                [cur_ind (range 7 (+ 7 len))])
        (get-vector-metadata-helper cur_tag (ptr? type) cur_ind))
)

(define (select-instructions-assignment e x)
     (define (get-vector-len-stmt vecName v)
         (define movq-proc (Instr 'movq (list (Deref 'r11 0) (Reg 'r11))))
         ;(display movq-proc)
         (list (Instr 'movq (list vecName (Reg 'r11)))
                 movq-proc
                 (Instr 'sarq (list (Imm 1) (Reg 'r11)))
                 (Instr 'andq (list (Imm 63) (Reg 'r11)))
                 (Instr 'movq (list (Reg 'r11) v))
         )
         ;(display "soadf")
     )
        (define (handle-int-var-b ex v)
     (list (Instr 'movq (list (select-instructions-atomic ex) v))))
   (define (handle-not-conds e1 ex11)
         (if (eq? e1 ex11)
         (list (Instr 'xorq (list (select-instructions-atomic (Bool #t)) (select-instructions-atomic ex11))))
         ;(display "shdf")
         (list (Instr 'movq (list (select-instructions-atomic e1) ex11))
               ;(display "dsfl")-
               (Instr 'xorq (list (select-instructions-atomic (Bool #t)) 
                                  (select-instructions-atomic ex11))))))
    (match e
     [(Bool b) (handle-int-var-b e x)]
     [(Int i) (handle-int-var-b e x)]
     [(Var v) (list (Instr 'movq (list e x)))]
        [(Void) (list (Instr 'movq (list (select-instructions-atomic e) x)))]
             [(Prim 'vector-ref (list vecName ind))
         (define offset (* 8 (+ (Int-value ind) 1)))
         (define old-offset1 (* 8 (+ (Int-value ind) 1)))
         (list (Instr 'movq (list vecName (Reg 'r11)))
                 (Instr 'movq (list (Deref 'r11 offset) x))
         )
         ;(display "kasdhjf")
     ]
     [(Allocate len `(Vector ,T ...))
             (define stmt '())
             (define tag (get-vector-metadata len T 0 7))
             (define off (* 8 (+ len 1)))
             ;(display tag)
             ;(display off)
             (list (Instr 'movq (list (Global 'free_ptr) (Reg 'r11)))
                   (Instr 'addq (list (Imm off) (Global 'free_ptr)))
                   (Instr 'movq (list (Imm tag) (Deref 'r11 0)))
                   (Instr 'movq (list (Reg 'r11) x))
             )   
     ]
             [(Prim 'vector-set! (list vecName ind rhs))
         (define offset (* 8 (+ (Int-value ind) 1)))
         (define stmt '())
         (list (Instr 'movq (list vecName (Reg 'r11)))
                 (Instr 'movq (list (select-instructions-atomic rhs) (Deref 'r11 offset)))
                 (Instr 'movq (list (Imm 0) x))
         )
     ]
             [(Prim 'vector-length (list vecName))
         (get-vector-len-stmt vecName x)]
             [(Prim '+ (list e1 e2))
         (define add1 e1)
         (if (equal? x e1) (list (Instr 'addq (list (select-instructions-atomic e2) x)))
         ;(display "dsf")
         (if (equal? x e2) (list (Instr 'addq (list (select-instructions-atomic e1) x)))
             (list (Instr 'movq (list (select-instructions-atomic e1) x))
                         (Instr 'addq (list (select-instructions-atomic e2) x)))))
     ]
             [(Prim '- (list e1 e2))
             (if
                 (equal? x e1) (list (Instr 'subq (list select-instructions-atomic e2) x))
                 ;(display v)
                 (list (Instr 'movq (list (select-instructions-atomic e1) x))
                       (Instr 'subq (list (select-instructions-atomic e2) x)))
             )
     ]
    [(Call fnName es) (append
         (select-instructions-movArgReg es)
         (list (IndirectCallq fnName (length es)))
         (list (Instr 'movq (list (Reg 'rax) x)))
        )]

    [(Prim '- (list a))
      (cons (Instr 'movq (list (select-instructions-atomic a) x))
            (cons (Instr 'negq (list x)) '()))
      ;(display "negatiat")
    ]
             [(Prim 'not (list e1))
      (handle-not-conds e1 x)
     ]
             [(Prim cmp (list e1 e2))
      (list (Instr 'cmpq (list (select-instructions-atomic e2) (select-instructions-atomic e1)))
            (Instr (cmp-setcc cmp) (list (ByteReg 'al)))
            ;(display "aslhf")
            (Instr 'movzbq (list (ByteReg 'al) x))
            )
      ]
        ;;; [(GlobalValue var) (list (Instr 'movq (list (Global var) x)))]
             [(GlobalValue var) 
         ;(display "global")
         (define glob-name var)
         (list (Instr 'movq (list (Global var) x)))
     ]

    [(Prim 'read '()) (list (Callq 'read_int 0)
            (Instr 'movq (list (Reg 'rax) x)))
      ;(display "read done")
     ]
        [(FunRef id n) (list (Instr 'leaq (list (Global id) x)))]

    )
)


(define (select-instructions-movArgReg es)
    (for/list ([arg es] [reg (set-to-list (get-registers "argument"))]) (Instr 'movq (list (select-instructions-atomic arg) reg)))
)
(define (select-instructions-movRegArg es)
    (for/list ([arg es] [reg (set-to-list (get-registers "argument"))]) (Instr 'movq (list reg (Var (car arg))) ))
)
(define (select-instructions-def df)
    (define instrBlocks (make-hash))
    (dict-for-each (Def-body df) (lambda (lbl instrs) (dict-set! instrBlocks lbl (Block '() (select-instructions-statement instrs (Def-name df))))))
    (define startLbl (symbol-append (Def-name df) 'start))
    (define startInstrs (Block-instr* (dict-ref instrBlocks startLbl)))
    (set! startInstrs (append (select-instructions-movRegArg (Def-param* df)) startInstrs))
    (dict-set! instrBlocks startLbl (Block '() startInstrs))
    ;(display "dictset done")
    (define info (Def-info df))
    (set! info (dict-set info 'num-params (length (Def-param* df))))
    ;(display "done")
    (Def (Def-name df) (Def-param* df) (Def-rty df) info instrBlocks)
)

;; select-instructions : C0 -> pseudo-x86
(define (select-instructions p)
; ;;;   (define instrBlocks (make-hash))
; ;;;   (define (run-select lbl instrs) (dict-set! instrBlocks lbl (Block '() (select-instructions-statement instrs))))
  (match p
    [(ProgramDefs info dfList) 
        (ProgramDefs info 
            (for/list ([df dfList]) (select-instructions-def df))
        )
    ] 
  )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (check-cond e)
    (match e
        [(FunRef id n) #f]
        [(Global g) #f]
        [(Imm e) #f]
        [_ #t]
    )
)

(define (list-to-set lst)
    (list->set (for/list ([e lst] #:when (check-cond e)) (check-deref e)))  
)

(define label-live (make-hash))
(define live-after-sets (make-hash))

(define (check-deref e)
    (match e
        [(Deref r i) (Reg r)]
        [_ e]
    )
)

(define (get-live-after-help listOfInstructions initialSet)
    (match listOfInstructions
        [_ (let ([list-live-after (get-live-after (cdr listOfInstructions) initialSet)])
              (define reads (collect-reads (car listOfInstructions)))
            (define writes (extract-writes (car listOfInstructions)))
            
            (append (list
                    (set-union reads
                        (set-subtract (car list-live-after) writes)
                    )
                )
            list-live-after))
        ]
    )
)
(define (get-live-after listOfInstructions initialSet)
    (match listOfInstructions
        [(list a) (define readSet (collect-reads a)) (define writes (extract-writes a)) (list 
                    (set-union readSet
                        (set-subtract initialSet writes ))
                  )
        ] 
        [_ (get-live-after-help listOfInstructions initialSet)]
    )
)

(define (collect-reads instr)
    (match instr
        [(Instr 'addq es) 
        ;(display es)
        (list-to-set es)]
        [(Instr 'subq es) 
        ;(display es)
        (list-to-set es)]
        [(Instr 'negq es) (list-to-set es)]
                [(Instr 'leaq es) (list-to-set (list (car es)))]

        [(Jmp _) (set (Reg 'rax) (Reg 'rsp))]
        [(Instr 'movq es) (list-to-set (list (car es)))]
        [(Instr 'cmpq es) 
        ;(display es)
        (list-to-set es)]
        ;;; [(Callq _ _) (get-registers "argument")]
        [(Callq fnName n)
            (if (<= n 6) (list->set (take (set-to-list (get-registers "argument")) n))
                        (list->set (take (set-to-list (get-registers "argument")) 6))
            )
        ]
        [(IndirectCallq fnName n)
            (set-union (set fnName) (list->set (take (set-to-list (get-registers "argument")) n)))
        ]
        [(TailJmp fnName n)
            (set-union (set fnName) (list->set (take (set-to-list (get-registers "argument")) n)))
        ]
        [else  (set)]
    )
)
(define (get-set ls) (list->set ls)) 

(define (extract-writes instr)
    (match instr
        [(Instr 'movzbq es) (get-set (cdr es))]
        [(Instr 'negq es) (get-set es)]
        ;;; [(Callq _ _) (get-registers "caller")]
        [(Instr 'subq es) (get-set (cdr es))]
        [(Instr 'leaq es) (list->set (cdr es))]
        [(Instr 'movq es) (get-set (cdr es))]
        [(Instr 'addq es) (get-set (cdr es))]
         [(IndirectCallq fnName n) (get-registers "caller")]
        [(TailJmp fnName n) (get-registers "caller")]
        [else (set)]))

(define (uncover-live-block label instrs initialSet)
    (define lal (get-live-after instrs initialSet))
    (dict-set! live-after-sets label lal)
    (car lal)
)



(define (makeCFG lbl instrs [cfgEdge '()])
    (match instrs
        ['() 
         cfgEdge]
        [(cons a c) 
            ;(display a)
            ;(display c)
                (match a
        [(Jmp dest) 
        ;(display "hello")
        (makeCFG lbl c (append cfgEdge (list (list lbl dest))))] 
        [(JmpIf cmp dest) 
        ;(display "jmpif")
        (makeCFG lbl c (append cfgEdge (list (list lbl dest))))] 
        [_ (makeCFG lbl c cfgEdge)])]
    )
)


(define (get-worklist G fname)
    (define worklist (make-queue))
        (for ([v (in-vertices G)]  #:when (not (eq? v (symbol-append fname 'conclusion)))) 
        (enqueue! worklist v))
    worklist
)

(define (analyze_dataflow G transfer bottom join e fname)
    (define worklist (get-worklist G fname))
    ;(display worklist)
    (define mapping (make-hash))
    (for ([v (in-vertices G)])
        (dict-set! mapping v bottom))

    (define trans-G (transpose G))
    (while (not (queue-empty? worklist))
        (define instructions '())
        (define node (dequeue! worklist))
        (define block (dict-ref e node))
        ;(display "block done!")
        (define input (for/fold ([state bottom])
                        ([pred (in-neighbors trans-G node)])
                      (join state (dict-ref mapping pred))))
        (match block
            [(Block info instr) (set! instructions instr) instr]
        )
        (define output (transfer node instructions input))
        ;(display "output")
        (if (not (equal? output (dict-ref mapping node)))
            (begin (dict-set! mapping node output)
            (for ([v (in-neighbors G node)])
                (enqueue! worklist v))) void)
    )
    mapping
)
	
(define (uncover-live-def df)
    (define body (Def-body df)) 
    (set! live-after-sets (make-hash))
    (define cfgEdges '())
    (dict-for-each body 
        (lambda (lbl instrs) (set! cfgEdges (append cfgEdges (makeCFG lbl (Block-instr* instrs)))))
    )
    (define graph (make-multigraph cfgEdges))
    (dict-for-each body 
        (lambda (lbl instrs) (add-vertex! graph lbl))
    )
    (analyze_dataflow (transpose graph) uncover-live-block (set) set-union body (Def-name df))
    (dict-for-each body 
        (lambda (lbl block) 
            (dict-set! body lbl (Block (dict-set (Block-info block) 'live-after (dict-ref live-after-sets lbl)) (Block-instr* block)))
        )
    )
    (Def (Def-name df) (Def-param* df) (Def-rty df) (Def-info df) body)
)

(define (uncover-live p)
    (match p
        [(ProgramDefs info dfList) 
            (ProgramDefs info 
                (for/list ([df dfList]) (uncover-live-def df))
            )]
    ))


(define (set-to-list s) 
    (for/list ([e s]) e)
)

(define (add-edges-helper curWrite curInstr curLive interference-graph)
    (match curWrite
        ['() 
        ;(display "GOOD4") 
        interference-graph]
        [(cons a c) 
        ;(display "GOOD5") 
        (add-edges-helper c curInstr curLive (add-edges a curInstr curLive interference-graph)) ]
    )
)


(define (build-graph liveAfterList instrs ig ) 
    (cond [(eq? instrs '()) ig ] 
        [else  (define nextInstrs (cdr instrs))
           (define curInstr (car instrs))
            (define curWrite (extract-writes curInstr))
            (define nextLives (cdr liveAfterList))
            (define curLives (car liveAfterList))
            ; (display "GOOD3")
            (build-graph nextLives nextInstrs (add-edges-helper (set-to-list curWrite) curInstr curLives ig))
        ]
    )
)

(define local-vars (make-hash))

(define (add-edges d curInstr curLive interference-graph)
    (for ([v curLive]) 
        (when (not (eq? v d)) 
            (match curInstr
                  [(Callq fnName n)
                    (cond 
                        [(and (not (set-member? (list->set  (get-registers "all")) v)) (ptr-bool? (dict-ref local-vars (Var-name v)))) 
                            (for ([reg (get-registers "all")]) 
                                (add-edge! interference-graph reg v))
                        ]
                    )
                    (add-edge! interference-graph v d)
                ]
                [(IndirectCallq fnName n) 
                    (cond 
                        [(and (not (set-member? (list->set (get-registers "all")) v)) (ptr-bool? (dict-ref local-vars (Var-name v)))) 
                            (for ([reg (get-registers "all")]) 
                                (add-edge! interference-graph reg v))
                        ]
                    )
                    (add-edge! interference-graph v d)
                ]
                [(Instr 'movq (list src dest)) 
                (if (not (eq? src v)) 
                (add-edge! interference-graph v d) void)]
                [(Instr 'movzbq (list src dest)) 
                (cond [(not (eq? src v)) (add-edge! interference-graph v d)])]
                [_ 
                ;(display "else condition")
                ;(display _)
                (add-edge! interference-graph v d)]
            )
        )
    )
    interference-graph
)

(define (build-interference-def df)
     (match df
        [(Def nm prm rty info body)
        (define dicref (dict-ref info 'locals-types))
        (set! local-vars dicref )
            (define graph (undirected-graph '()))
            (define (build-helper lbl instrs)
              (match (dict-ref body lbl)
                [(Block sinfo bbody) 
                ;(display "GOOD1")
                 (define xy (dict-ref sinfo 'live-after))
                 ;(display "GOOD2")
                 (set! graph (build-graph xy bbody graph))])
            )
         (dict-for-each body build-helper)
          (Def nm prm rty (dict-set info 'conflicts graph) body)
        ]
    )
)
	(define (build-interference p)
    (match p
        [(ProgramDefs info dfList) 
            (ProgramDefs info 
                (for/list ([df dfList]) (build-interference-def df))
            )
        ] 
    )
)

(struct node (name [blockedColorsSet #:mutable]))

(define (assign-homes-convert e varmap usedCalleeNum)
  (define (get-color e)
           (dict-ref varmap (Var e)))
    (match e
        [(Var e) 
            (define color (get-color e))
            ;(display color)
            (if (< color 11)
                (register-color color)
                (if (odd? color)
                    (Deref 'rbp (- (* 8  (+ (/ (- color 9) 2) usedCalleeNum))) )
                    
                    (Deref 'r15 (- (* 8  (/ (- color 10) 2))))))]
        [_ e]
    )
)
(define (assign-homes-mapvars varmap stm usedCalleeNum)
    (match stm
        [(Instr op args) 
            (Instr op (map (lambda (x) (assign-homes-convert x varmap usedCalleeNum)) args))]
        [(IndirectCallq fnName n)
            ;(display "indirect call matched")
            (define convert (assign-homes-convert fnName varmap usedCalleeNum))
            (IndirectCallq convert n)]
        [(TailJmp fnName n)
            ;(display "tail")
            (define convert (assign-homes-convert fnName varmap usedCalleeNum))
            (TailJmp convert n)]
       [_ stm]
    )
)
(define (assign-homes instrs varmap usedCalleeNum)
    (for/list ([stm instrs]) 
    (define stm-temp stm)
    ;(display instrs)    
    (assign-homes-mapvars varmap stm usedCalleeNum))
)



(define (mex v s [i 0])
    (if (eq? 11 i) 
        (cond [(ptr-bool? (dict-ref local-vars (Var-name v))) 
        ;(display ptrbool)
        (set! i 12)]
        [else 
        (define tempi (- i 1))
        (set! i 11)]
        
        ) 
        (set! i i)
    )

    (match (member i s)
        [#f i]
        [_ (cond [(< i 11) 
        ;(display i)
        (define i1 (+ i 1))
        (mex v s (+ i 1))]
         [else (mex v s (+ i 2))])])
)

(define cmp-<                 
  (lambda (node1 node2)
    (define alen (length (set-to-list (node-blockedColorsSet node1))) )
    (define blen (length (set-to-list (node-blockedColorsSet node2))) )         
    (<  alen blen ) )
)



;;; UPDATE NEIGHBORS
(define (update-neighbours q vname-pointer curColor neighbors)
    (match neighbors
        ['() q]
        [_
            (define leftcdd (cdr neighbors))
            (define curNeighbour (dict-ref vname-pointer (car neighbors)) )
            (define nk  (node-key curNeighbour) )
            (define newSet (list->set (append (list curColor) (set-to-list (node-blockedColorsSet nk)))))
            (set-node-blockedColorsSet! nk newSet) 
            (pqueue-decrease-key! q curNeighbour)
            (update-neighbours   q vname-pointer curColor leftcdd)                                       
        ]
    )   
)

(define (curnode-helper curNode q vname-pointer graph var-colors)
  (match (node-name curNode)
    [(Reg r) (assign-next q vname-pointer graph 
    (dict-set var-colors (node-name curNode) (register-color (Reg r))))
    ]
    [_ 
        (define updatedQ 
        (update-neighbours q vname-pointer  (mex (node-name curNode) (set-to-list (node-blockedColorsSet curNode))) (sequence->list (in-neighbors graph (node-name curNode))) ))
        (assign-next updatedQ vname-pointer graph (dict-set var-colors (node-name curNode)  (mex (node-name curNode) (set-to-list (node-blockedColorsSet curNode)))))
    ]
    ))

;;; ASSIGN NEXT 
;; assign-homes : pseudo-x86 -> pseudo-x86

(define (assign-next q vname-pointer graph [var-colors '()] ) 
    (if (eq? (pqueue-count q) 0) var-colors
      (curnode-helper (pqueue-pop! q) q vname-pointer graph var-colors)))



(define (allocate-registers-helper variableList graph [vname-pointer '()] [q (make-pqueue cmp-<)] [registerList '()]) 
    (match variableList
        ['()
            (for ([rg registerList]) 
            (update-neighbours q vname-pointer (register-color rg) (sequence->list (in-neighbors graph rg)))
            )
            ;(display "here in allocate")
            (assign-next q vname-pointer graph)]
        [_ 
            (define first (car variableList))
            (define remaining (cdr variableList))
            ;(display "here in _allocate")
            (match first
                [(Reg _) 
                    (allocate-registers-helper remaining graph
                    ;(display "allocate reg call") 
                    (dict-set vname-pointer first (pqueue-push! q (node first (set))))
                     q (cons first registerList)
                    )
                ] 
                [_ 
                    (allocate-registers-helper remaining graph 
                    ;(display "allocate reg call 2222")
                    (dict-set vname-pointer first (pqueue-push! q (node first (set)))) 
                    q registerList)
                ]
            )
        ]
    )
)

(define (num-spilled-var varColors [max 0]) 
    (match varColors
      
        ['()
            (if (> max 10) (/ (- max 9) 2) 0) 
        ]
        [_  
            (define first (car varColors))
            (define remaining (cdr varColors))
            (match (car first)
                [(Var _)
                    (cond 
                        [(< (cdr first) max) (num-spilled-var remaining max)]

                         [(odd? (cdr first)) (num-spilled-var remaining (cdr first))]
                        [else (num-spilled-var remaining max)]
                    )
                ]
                [_ (num-spilled-var remaining max)]
            )
        ]
    )
)

(define (num-root-spilled-var varColors [max 0]) 
    (match varColors
        ['()
            (if (> max 10) (/ (- max 10) 2) 0) 
        ]
        [_  
            (define first (car varColors))
            (define remaining (cdr varColors))
            (match (car first)
                [(Var _) 
                    (define color (cdr first) )
                    
                    (cond 
                        [(< color max) (num-root-spilled-var remaining max)]
                        [(even? color) (num-root-spilled-var remaining color)]
                        [else (num-root-spilled-var remaining max)]
                    )
                ]
                [_ (num-root-spilled-var remaining max)]
            )
        ]
    )
)

(define (used-callee varColors [usedCallee '()]) 
    (match varColors
        ['() 
        ; (display "used callee")
        (list->set usedCallee)]
        [_  
            (match (car (car varColors))
                [(Var _)
                    ;(display "used callee1")
                    (define color (cdr (car varColors)))
                    ;(display "used callee2")
                    (cond 
                        [(< color 11) 
                            (define reg (register-color color))
                            ;(display "used callee3")
                            (cond 
                                [(eq? #f (member reg (get-registers "callee"))) 
                                ; (display "used callee5")
                                (used-callee (cdr varColors) usedCallee)]
                                [else 
                                ;  (display "used callee4")
                                  (used-callee (cdr varColors) (cons reg usedCallee))]
                            )
                        ]
                        [else  
                        ; (display "used callee7") 
                        (used-callee (cdr varColors) usedCallee)]
                    )
                ]
                [_ 
                ;  (display "used callee6")
                (used-callee (cdr varColors) usedCallee)]
            )
        ]
    )
)


(define (allocate-registers-def df)
    (match df
        ['() '()]
        [
            
            (Def nm prm rty info body)
            (set! local-vars (dict-ref info 'locals-types))
            (define colors (allocate-registers-helper (sequence->list (in-vertices (dict-ref info 'conflicts))) (dict-ref info 'conflicts)))
            (dict-for-each body
                (lambda (lbl instrs)
                    (match (dict-ref body lbl)
                        [(Block sinfo instrs) (dict-set! body lbl (Block sinfo (assign-homes instrs colors (length (set-to-list (used-callee colors))))))] 
                    )
                )
            )

            (Def nm prm rty (dict-set (dict-set (dict-set info 'stack-space (num-spilled-var colors)) 'num-root-spills (num-root-spilled-var colors)) 'used_callee (used-callee colors)) body)
        ]
    )
)

(define (allocate-registers p)
    (match p
        [(ProgramDefs info dfList) 
            (ProgramDefs info 
                (for/list ([df dfList]) (allocate-registers-def df))
            )
        ] 
    )
)

(define (patch-instructions-convert instr)
    (match instr
        [(Instr 'cmpq (list src (Imm n))) 
                    (list
                        (Instr 'movq (list (Imm n) (Reg 'rax)))
                        (Instr 'cmpq (list src (Reg 'rax)))
                    )
            ]

    [(Instr op (list (Reg rega) (Reg regb )))
      (if (eq? rega regb) '()
        (list (Instr op (list (Reg rega) (Reg regb)))))]

     [(Instr 'movzbq (list (ByteReg 'al) (Deref 'rbp offset))) 
                (list
                    (Instr 'movzbq (list (ByteReg 'al) (Reg 'rax)))
                    (Instr 'movq (list (Reg 'rax) (Deref 'rbp offset))))]

       
       [(Instr op (list (Deref rega off1) (Deref regb off2)))
      (if (eq? rega regb) '()
      (list (Instr 'movq (list (Deref rega off1) (Reg 'rax))) 
      (Instr op (list (Reg 'rax) (Deref regb off2)))))]
        
        [(Instr 'leaq (list src (Deref reg1 offset))) 
                (list
                    (Instr 'leaq (list src (Reg 'rax)))
                    (Instr 'movq (list (Reg 'rax) (Deref reg1 offset)))
                )
        ]
        [(TailJmp fnName n)
            (list
                (Instr 'movq (list fnName (Reg 'rax)))
                (TailJmp (Reg 'rax) n)
            )
        ]
        [else (list instr)]
    )
)

(define (patch-instructions-def df)
    (match df
        ['() '()]
        [(Def nm prm rty info body)
            (dict-for-each body
                (lambda (lbl instrs)
                    (match (dict-ref body lbl)
                        [(Block sinfo instrs) (dict-set! body lbl (Block sinfo (append-map patch-instructions-convert instrs)))] 
                    )
                )
            )
            (Def nm prm rty info body)
        ]
    )
)

;; patch-instructions : psuedo-x86 -> x86
(define (patch-instructions p)
    (match p
        [(ProgramDefs info dfList) 
            (ProgramDefs info 
                (for/list ([df dfList]) (patch-instructions-def df))
            )
        ] 
    )
)

(define (push-pop registers instr)
    (cond 
        [(equal? instr "push") (for/list ([rg (set-to-list registers)]) (Instr 'pushq (list rg)))]
        [(equal? instr "pop") (for/list ([rg (reverse (set-to-list registers))]) (Instr 'popq (list rg))) ]
    )
)

(define (zeroOutRootStack num i)
    (if (> i (- num 1)) '() (append (list (Instr 'movq (list (Imm 0) (Deref 'r15 (* 8 i))))) (zeroOutRootStack num (+ i 1))))

)

(define (tailJmpConvert instr A R info fnName)
    (match instr
        [(TailJmp fnName n) 
            (append (list (Instr 'subq (list (Imm R) (Reg 'r15))))
                    (list (Instr 'addq (list (Imm A) (Reg 'rsp))))
                    (push-pop (dict-ref info 'used_callee) "pop")
                    (list (Instr 'popq (list (Reg 'rbp))))
                    (list (IndirectJmp fnName))
            )
        ]
        [_ (list instr)]
    )
)

(define (prelude-and-conclusion-def df)
    (match df [(Def nm prm rty info body)
        (define A (- (align (+ (* 8 (dict-ref info 'stack-space)) (* 8 (length (set-to-list (dict-ref info 'used_callee))))) 16) (* 8 (length (set-to-list (dict-ref info 'used_callee))))))

        (dict-for-each body
            (lambda (lbl instrs)
                (match (dict-ref body lbl)
                    [(Block sinfo instrs) 
                        (dict-set! body lbl (Block sinfo (foldr append '() (for/list ([instr instrs]) (tailJmpConvert instr A (* 8 (dict-ref info 'num-root-spills)) info nm)))))
                    ] 
                )
            )
        )
        (define R (* 8 (dict-ref info 'num-root-spills)))

        (dict-set! body nm 
            (Block info (append (list (Instr 'pushq (list (Reg 'rbp)))) 
                                (list (Instr 'movq (list (Reg 'rsp) (Reg 'rbp)))) 
                                (push-pop (dict-ref info 'used_callee) "push") 
                                (list (Instr 'subq (list (Imm A) (Reg 'rsp))))
                                
                                (if (eq? nm 'main)
                                    (append 
                                        (list (Instr 'movq (list (Imm 16384) (Reg 'rdi))))
                                        (list (Instr 'movq (list (Imm 16384) (Reg 'rsi))))
                                        (list (Callq 'initialize 2))
                                        (list (Instr 'movq (list (Global 'rootstack_begin) (Reg 'r15))))
                                    )
                                    '()
                                )

                                (zeroOutRootStack (dict-ref info 'num-root-spills) 0)
                                (list (Instr 'addq (list (Imm R) (Reg 'r15))))
                                (list (Jmp (symbol-append nm 'start)))
                        )
            )
        )
        (dict-set! body (symbol-append nm 'conclusion)
                        (Block info (append (list  (Instr 'subq (list (Imm R) (Reg 'r15))))
                                            (list (Instr 'addq (list (Imm A) (Reg 'rsp))))
                                            (push-pop (dict-ref info 'used_callee) "pop")
                                            (list (Instr 'popq (list (Reg 'rbp))))
                                            (list (Retq))
                                    )
                        )
        )

        (Def nm prm rty info body)]
    )
)

;; prelude-and-conclusion : x86 -> x86
(define (prelude-and-conclusion p)
    (match p
        [(ProgramDefs info dfList) 
            (define finalBody '())            
            (for/list ([df (for/list ([df dfList]) (prelude-and-conclusion-def df))])
                (dict-for-each (Def-body df)
                    (lambda (lbl instrs)
                        (set! finalBody (append finalBody (list (cons lbl (dict-ref (Def-body df) lbl)))))
                    )
                )
            )

            (X86Program info finalBody)
        ] 
    )  
)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE END PASSES

;  CALLING PASSES

(define compiler-passes
  `( 
        ("shrink", shrink, interp-Lfun, type-check-Lfun)
     ("uniquify", uniquify, interp-Lfun, type-check-Lfun)
     ("reveal functions", reveal-functions, interp-Lfun, type-check-Lfun)
     ("limit functions", limit-functions, interp-Lfun, type-check-Lfun)
     ("expose allocation", expose_allocation, interp-Lfun, type-check-Lfun)
     ("uncover get!", uncover-get!, interp-Lfun, type-check-Lfun)
     ("remove complex opera*", remove-complex-opera*, interp-Lfun, type-check-Lfun)
     ("explicate control", explicate_control, interp-Cfun, type-check-Cfun)
     ("instruction selection", select-instructions, interp-x86-3)
     ("uncover live", uncover-live, interp-x86-3)
     ("interference graph", build-interference, interp-x86-3)
     ("allocate registers", allocate-registers, interp-x86-3)
     ("patch instructions", patch-instructions, interp-x86-3)
     ("prelude-and-conclusion", prelude-and-conclusion, interp-x86-3)
     
     )
     
)