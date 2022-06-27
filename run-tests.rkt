#! /usr/bin/env racket	
#lang racket	
(require "utilities.rkt")	
(require "interp-Lvar.rkt")
(require "interp-Lwhile.rkt")
(require "interp-Lvec.rkt")
(require "interp-Cvar.rkt")
(require "interp-Cwhile.rkt")
(require "interp-Cvec.rkt")
(require "interp.rkt")	
(require "compiler.rkt")
(require "interp-Lif.rkt")
(require "type-check-Lif.rkt")
(require "type-check-Lwhile.rkt")
(require "type-check-Lvec.rkt")
(require "type-check-Lvar.rkt")
;;; (require "type-check-Lvec.rkt")
(require "type-check-Lfun.rkt")

;; (debug-level 1)	
;; (AST-output-syntax 'concrete-syntax)	
;; all the files in the tests/ directory with extension ".rkt".	
(define all-tests	
  (map (lambda (p) (car (string-split (path->string p) ".")))	
       (filter (lambda (p)	
                 (string=? (cadr (string-split (path->string p) ".")) "rkt"))	
               (directory-list (build-path (current-directory) "tests")))))	
(define (tests-for r)	
  (map (lambda (p)	
         (caddr (string-split p "_")))	
       (filter	
        (lambda (p)	
          (string=? r (car (string-split p "_"))))	
        all-tests)))	
;(debug-level 1)	
;(interp-tests "while" type-check-Lwhile compiler-passes interp-Lwhile "while_test" (tests-for "while"))	
;(interp-tests "vectors" type-check-Lvec compiler-passes interp-Lvec "vectors_test" (tests-for "vectors"))
;;; ;
;;; (compiler-tests "vectors" type-check-Lvec compiler-passes "vectors_test" (tests-for "vectors"))
;;; (compiler-tests "while" type-check-Lwhile compiler-passes "while_test" (tests-for "while"))
;;; (compiler-tests "var" type-check-Lvar compiler-passes "var_test" (tests-for "var"))
;;; (compiler-tests "cond" type-check-Lif compiler-passes "cond_test" (tests-for "cond"))
;;; (interp-tests "functions" type-check-Lfun compiler-passes interp-Lfun "functions_test" (tests-for "functions"))

;; Uncomment the following when all the passes are complete to
;; test the final x86 code.

(compiler-tests "functions" type-check-Lfun compiler-passes "functions_test" (tests-for "functions"))