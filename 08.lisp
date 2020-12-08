;;; Advent Of Code 2020 - Day 8 - Anthony Green <green@moxielogic.com>

(ql:quickload :alexandria)

(defparameter +code+ (coerce (uiop:read-file-lines "08.input") 'vector))
(defvar *completed?* nil)

(defun run-code (code)
  (loop
    with acc = 0
    with pc = 0
    while (< pc (length code))
    do
       (progn
         (let ((insn (subseq (aref code pc) 0 3))
               (op (parse-integer (subseq (aref code pc) 4))))
           (setf (aref code pc) "xxx 0")
           (alexandria:eswitch (insn :test #'equal)
             ("acc" (setf acc (+ acc op)))
             ("nop" t)
             ("jmp" (incf pc (- op 1)))
             ("xxx" (return acc)))
           (incf pc)))
    finally (return (setf *completed?* acc))))

;; Solution 1
(run-code (copy-seq +code+))

;; Solution 2
(progn
  (setf *completed?* nil)
  (loop
    with pc = -1
    while (let ((code (copy-seq +code+)))
            (flet ((run-test (ignore)
                     (run-code code)))
              (incf pc)
              (not (let ((insn (subseq (aref code pc) 0 3))
                         (op (parse-integer (subseq (aref code pc) 4))))
                     (alexandria:eswitch (insn :test #'equal)
                       ("jmp"
                        (let ((acc (run-test (setf (aref code pc) "nop 0"))))
                          (when *completed?* (return acc))))
                       ("acc" nil)
                       ("nop"
                        (let ((acc (run-test (setf (aref code pc) (format nil "jmp ~A" op)))))
                          (when *completed?* (return acc)))))))))))
