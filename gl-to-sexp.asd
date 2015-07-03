;;;; gl-to-sexp.asd

(asdf:defsystem #:gl-to-sexp
  :description "Describe gl-to-sexp here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:plump #:cl-json)
  :components ((:file "package")
               (:file "gl->sexp")))
