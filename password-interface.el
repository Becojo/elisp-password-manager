(defun get-password ()
  "Grabs password from entity query.
Assumes point is at the begining of the org-mode table.
Hard-coded columns for now where 1 is entity, 3 password."
  (let ((passwords (list)))
    (while (< (line-number-at-pos (point))
	      (line-number-at-pos (marker-position
				   (org-table-end))))
      (next-line)
      (add-to-list 'passwords (cons (chomp (org-table-get-field 1))
				    (chomp (org-table-get-field 3)))))
    (let ((choice (ido-completing-read "Which entity? "
				       (loop for (key . value) in foobar
					     collect key))))
      (cdr (car (cl-remove-if-not
		 '(lambda (a) (string= (car a) choice)) passwords))))))

