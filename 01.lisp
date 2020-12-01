;;; Advent Of Code 2020 - Day 1 - Anthony Green <green@moxielogic.com>

(ql:quickload :alexandria)

(let ((number-list nil))

  ;; Load all of the data...
  (with-open-file (in "01.input" :direction :input)
    (loop for line = (read-line in nil)
          while line do (setf number-list (cons (parse-integer line) number-list))))

  ;; Solve for steps 1 and 2 using the same mechanism...
  (macrolet ((find-numbers (l)
               `(block try-block
                  (flet ((test-fn (p)
                           (when (equal 2020 (apply #'+ p))
                             (return-from try-block (apply #'* p)))))
                    (alexandria:map-combinations #'test-fn number-list :length ,l)))))
    (print (find-numbers 2))
    (print (find-numbers 3))))
