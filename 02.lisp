;;; Advent Of Code 2020 - Day 2 - Anthony Green <green@moxielogic.com>

(ql:quickload :split-sequence)

;; Problem 1
(print (count-if
        (lambda (line)
          (destructuring-bind (freq-min rest-of-line)
              (split-sequence:split-sequence #\- line)
            (flet ((in-range (n min max)
                     (and (>= n min) (<= n max))))
              (in-range (- (count (find-if #'alpha-char-p rest-of-line) rest-of-line) 1)
                        (parse-integer freq-min)
                        (parse-integer rest-of-line :junk-allowed t)))))
        (uiop:read-file-lines "02.input")))

;; Problem 2
(print (count-if
        (lambda (line)
          (destructuring-bind (pos1 rest-of-line)
              (split-sequence:split-sequence #\- line)
            (destructuring-bind (before-colon after-colon)
                (split-sequence:split-sequence #\: line)
              (let ((char (find-if #'alpha-char-p rest-of-line)))
                (not (eq (null (eq char (aref after-colon (parse-integer pos1))))
                         (null (eq char (aref after-colon (parse-integer rest-of-line :junk-allowed t))))))))))
        (uiop:read-file-lines "02.input")))
