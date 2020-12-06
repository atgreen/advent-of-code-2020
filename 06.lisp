;;; Advent Of Code 2020 - Day 6 - Anthony Green <green@moxielogic.com>

(ql:quickload :alexandria)
(ql:quickload :cl-ppcre)

;; Solution 1
(apply #'+
       (mapcar
        (lambda (group)
          (length (remove-duplicates
                   (cl-ppcre:regex-replace-all "\\n" group ""))))
        (cl-ppcre:split "\\n\\n"
                        (alexandria:read-file-into-string "06.input"))))

;; Solution 2
(apply '+
       (mapcar
        (lambda (group)
          (length (reduce #'intersection group)))
        (mapcar (lambda (group)
                  (mapcar (lambda (answer)
                            (coerce answer 'list))
                          (cl-ppcre:split "\\n" group)))
                (cl-ppcre:split "\\n\\n"
                                (alexandria:read-file-into-string "06.input")))))
