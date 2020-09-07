
(print 'hello)


(defvar *data*
  '((name
      (lname menzies)
      (fnmae timm))
    (address
      (street thing)
      (number 23))
    (dob
      (year 1)
      (month july)
      (day (28)))))

(print *data*)

(defun visit (f things)
  (if (consp things)
      (dolist (thing things)
         (visit f thing))
      (funcall f things)))


(defun sums ( &aux (out 0))
  (visit #'(lambda(x) (if (numberp x)
                        (incf out x)))
         *data*)
  out)

(print (sums))

