(defun pylint-ignore-errors-at-point ()
  (interactive)
  (let* ((errs (flycheck-overlay-errors-in (line-beginning-position) (line-end-position)))
         (ids (-map (lambda (s) (flycheck-error-id s)) errs)))
    (if (> (length ids) 0)
        (save-excursion
          (comment-indent)
          (insert " pylint: disable="
                  (s-join ", " ids))
          ))))
