;;; Advent Of Code 2020 - Day 3 - Anthony Green <green@moxielogic.com>

(defparameter +map+ (uiop:read-file-lines "03.input"))
(defparameter +map-max-x+ (length (car +map+)))
(defparameter +map-max-y+ (length +map+))

(defun slide (x y tree-count slope-x slope-y)
  (if (< y +map-max-y+)
      (+ tree-count
         (slide (+ x slope-x) (+ y slope-y) tree-count slope-x slope-y)
         (if (eq #\# (aref (nth y +map+) (rem x +map-max-x+))) 1 0))
      0))

;; Part 1
(print (slide 0 0 0 3 1))

;; Part 2
(print (* (slide 0 0 0 1 1)
          (slide 0 0 0 3 1)
          (slide 0 0 0 5 1)
          (slide 0 0 0 7 1)
          (slide 0 0 0 1 2)))
