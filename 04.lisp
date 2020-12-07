;;; Advent Of Code 2020 - Day 4 - Anthony Green <green@moxielogic.com>

(ql:quickload :split-sequence)
(ql:quickload :cl-ppcre)

(defparameter +passport-data+
  (append (uiop:read-file-lines "04.input") '("")))

(defstruct doc
  eyr
  byr
  hcl
  cid
  ecl
  hgt
  iyr
  pid)

(defun complete-passport (doc)
  (and doc
       (doc-byr doc)
       (doc-iyr doc)
       (doc-eyr doc)
       (doc-hgt doc)
       (doc-hcl doc)
       (doc-ecl doc)
       (doc-pid doc)))

(defparameter +four-digit-matcher+
  (cl-ppcre:create-scanner "^[0-9]{4}$"))
(defparameter +nine-digit-matcher+
  (cl-ppcre:create-scanner "^[0-9]{9}$"))
(defparameter +hcl-matcher+
  (cl-ppcre:create-scanner "^#[0-9a-f]{6}$"))
(defparameter +hgt-in-matcher+
  (cl-ppcre:create-scanner "^[0-9]+in$"))
(defparameter +hgt-cm-matcher+
  (cl-ppcre:create-scanner "^[0-9]+cm$"))

(defun valid-passport (doc)
  (and (complete-passport doc)
       (flet ((check-year (value min max)
                (and (cl-ppcre:scan +four-digit-matcher+ value)
                     (<= min (parse-integer value) max))))
         (and (check-year (doc-byr doc) 1920 2002)
              (check-year (doc-iyr doc) 2010 2020)
              (check-year (doc-eyr doc) 2020 2030)))
       (or (and (cl-ppcre:scan +hgt-in-matcher+ (doc-hgt doc))
                (<= 59 (parse-integer (doc-hgt doc) :junk-allowed t) 76))
           (and (cl-ppcre:scan +hgt-cm-matcher+ (doc-hgt doc))
                (<= 150 (parse-integer (doc-hgt doc) :junk-allowed t) 193)))
       (cl-ppcre:scan +hcl-matcher+ (doc-hcl doc))
       (let ((pos (search (doc-ecl doc) "ambblubrngrygrnhzloth")))
         (and pos (eq 0 (rem pos 3))))
       (cl-ppcre:scan +nine-digit-matcher+ (doc-pid doc))))

(defvar *doc* nil)
(defvar *docs* nil)

(progn
  (setf *docs* '(nil))
  (setf *doc* (make-doc))
  (dolist (line +passport-data+)
    (if (string= "" line)
        (progn
          (setf *docs* (cons *doc* *docs*))
          (setf *doc* (make-doc)))
        (dolist (value (split-sequence:split-sequence #\SPACE line))
          (let ((key-value (split-sequence:split-sequence #\: value)))
	    ;; This is dangerous.
	    ;; https://www.reddit.com/r/Common_Lisp/comments/k79s59/common_lisp_for_advent_of_code_2020/gevk6dr?utm_source=share&utm_medium=web2x&context=3
            (eval (read-from-string
                   (format nil "(setf (doc-~A *doc*) ~S)"
                           (car key-value) (cadr key-value))))))))

  ;; Step 1
  (print (count-if #'complete-passport *docs*))

  ;; Step 2
  (print (count-if #'valid-passport *docs*)))
