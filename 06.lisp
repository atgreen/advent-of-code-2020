;;; Advent Of Code 2020 - Day 6 - Anthony Green <green@moxielogic.com>

(ql:quickload :alexandria)
(ql:quickload :cl-ppcre)

;; Solution 1
(apply #'+
       (mapcar
        (lambda (group)
          (length (remove-duplicates
                   (sort (cl-ppcre:regex-replace-all "\\n" group "")  #'char<))))
        (cl-ppcre:split "\\n\\n"
                        (alexandria:read-file-into-string "06.input"))))

;; Solution 2
(apply '+
       (mapcar
        (lambda (group)
          (length
           (loop for answer in (cdr group)
                 with ilist = (car group)
                 do (setf ilist (intersection ilist answer))
                 finally (return ilist))))
        (mapcar
         (lambda (group)
           (mapcar
            (lambda (answer)
              (coerce answer 'list))
            (cl-ppcre:split "\\n" group)))
         (cl-ppcre:split "\\n\\n"
                         (alexandria:read-file-into-string "06.input")))))
