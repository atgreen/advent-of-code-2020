;;; Advent Of Code 2020 - Day 5 - Anthony Green <green@moxielogic.com>

(defparameter +seat-ids+
  (mapcar (lambda (insn)
            (+ (* (parse-integer
                   (substitute #\1 #\B (substitute #\0 #\F insn))
                   :radix 2 :junk-allowed t)
                  8)
               (parse-integer
                (substitute #\1 #\R (substitute #\0 #\L
                                                (subseq insn 7)))
                :radix 2)))
          (uiop:read-file-lines "05.input")))

;; Problem 1
(apply #'max +seat-ids+)

;; Problem 2
(let ((seats (coerce (sort +seat-ids+ #'<) 'vector)))
  (block seat-search
    (loop for seat from 1 to (length seats)
          do (unless (and (eq (aref seats (- seat 1))
                              (- (aref seats seat) 1))
                          (eq (aref seats (+ seat 1))
                              (+ (aref seats seat) 1)))
               (return-from seat-search (+ 1 (aref seats seat)))))))
