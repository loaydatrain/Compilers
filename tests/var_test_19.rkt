(let ([x 10])
  (let ([y (+ x 2)])
  (let ([z (+ x y)])
  (+ x (+ y (+ z (- 2))))
  )
  )
)