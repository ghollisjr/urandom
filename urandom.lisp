(defpackage :urandom
  (:use
   :cl)
  (:export
   :*state*
   :urandom
   :urandom-seed))

(in-package :urandom)

(defun urandom-seed (&optional (nbits 32))
  "Set random state using nbits from /dev/urandom"
  (with-open-file (rand "/dev/urandom"
                        :direction :input
                        :element-type (list 'unsigned-byte nbits))
    (let* ((result (make-array 1 :element-type (list 'unsigned-byte nbits))))
      (read-sequence result rand)
      (elt result 0))))

(defparameter *state* nil
  "Random state")

(defun ensure-seed (&optional (nbits 32))
  "Make sure that *state* is initialized, and use nbits to init if not."
  (when (not *state*)
    (setf *state*
          (sb-ext:seed-random-state
           (urandom-seed nbits)))))

(defun urandom (arg &optional (seed-nbits 32))
  "Generate random number using arg and random state initialized by
/dev/urandom using seed-nbits.  NOTE: seed-nbits is only used if
*state* has not been initialized.  To change the random state, set
*state* to NIL and call urandom with a non-NIL seed-nbits argument."
  (ensure-seed seed-nbits)
  (random arg *state*))
