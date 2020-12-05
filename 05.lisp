;;; Advent Of Code 2020 - Day 5 - Anthony Green <green@moxielogic.com>

(defparameter +seat-ids+
  (labels ((sub (str slist)
             (if slist
                 (sub (substitute (caar slist) (cdar slist) str) (cdr slist))
                 (parse-integer str :radix 2 :junk-allowed t))))
    (mapcar (lambda (str)
              (sub str '((#\1 . #\B) (#\0 . #\F) (#\1 . #\R) (#\0 . #\L))))
            (uiop:read-file-lines "05.input"))))

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
