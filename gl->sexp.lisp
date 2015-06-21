;;;; gl-to-sexp.lisp

(in-package #:gl-to-sexp)

(defun peek (x) (swank:inspect-in-emacs x) x)

(defun export-all ()
  (with-open-file (str #p"./spec/glsl"
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (format str "~s" (mapcar #'spec->sexp (directory "/home/baggers/Code/docs.gl/sl4/*.xhtml")))))

(defun spec->sexp (path)
  (let* ((root-node (plump:parse path))
         (func-prototypes (get-func-prototypes root-node))
         (version-table (get-version-table root-node)))
    (list
     (mapcar #'parse-prototype func-prototypes)
     (exteract-version-data version-table))))

(defun get-v-table ()
  (get-version-table (plump:parse #P"/home/baggers/Code/docs.gl/sl4/EmitStreamVertex.xhtml")))

(defun get-version-table (root-node)
  (plump:child-elements
   (aref (plump:child-elements
          (aref (plump:child-elements (plump:get-element-by-id root-node "versions"))
                1))
         0)))

(defun exteract-version-data (version-table)
  (let ((rows (plump:child-elements (aref version-table 2))))
    (loop for x across rows collect (parse-version-row x))))

(defun parse-version-row (row)
  (let ((cells
         (mapcar #'(lambda (_)
                     (plump:text (aref (plump:children _) 0)))
                 (concatenate 'list (plump:child-elements row))))
        (versions '(:110 :120 :130 :140 :150 :330 :400 :410 :420 :430 :440 :450)))
    (cons (first cells) (mapcar (lambda (_ v) (unless (equal "-" _) v))
                                (rest cells) versions))))

(defun get-func-prototypes (root-node)
  (concatenate
   'list
   (remove-if (lambda (_) (not (equal "table" (plump:tag-name _))))
              (plump:child-elements
               (elt (plump:child-elements
                     (elt (plump:child-elements (elt (plump:child-elements root-node)
                                                     0))
                          2))
                    1)))))



(defun parse-prototype (x)
  (let* ((children (concatenate 'list (plump:child-elements x))))
    (list (extract-func-spec (first children))
          (mapcar #'extract-arg-spec
                  children))))

(defun extract-arg-spec (x)
  (let* ((node (aref (plump:child-elements x) 1))
         (children (plump:children node)))
    (list (trim (plump:text (aref (plump:children (aref children 1)) 0)))
          (trim (plump:text (aref children 0))))))

(defun extract-func-spec (x)
  (let* ((node (aref (plump:child-elements x) 0))
         (children (plump:children (aref (plump:child-elements node) 0))))
    (list
     (trim (plump:text (aref (plump:children (aref children 1)) 0)))
     (trim (plump:text (aref children 0))))))


(defun trim (x)
  (string-trim '(#\space) x))
