This is a simple Common Lisp library for accessing the urandom system
on Linux or other systems which support this RNG filesystem API.

Example usage:

(let* ((nbits 64))
  ;; get a list of 100 random double-float values between 0d0 and 1d0
  ;; using 64-bit seed from /dev/urandom:
  (loop
    for i below 100
    collecting (urandom 1d0 nbits)))
;; note: nbits only needed for first call, but safe to include in
;; future calls.

