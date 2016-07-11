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

(defun jump-to-bad-ctor ()
  (interactive)
  (search-forward "required from here")
  (recenter-top-bottom)
  (compile-goto-error))

(defun projectile-rebuild-project ()
  (interactive)
  (save-some-buffers t)
  (let ((compilation-read-command nil))
    (projectile-compile-project nil)))

(defun projectile-switch-to-git ()
  (interactive)
  (let ((projectile-switch-project-action 'projectile-vc))
    (projectile-switch-project)))

(defun git-link-commit-from-messenger ()
  (interactive)
  (require 'git-link)
  (cl-letf (((symbol-function 'word-at-point)
             (lambda () git-messenger:last-commit-id)))
    (call-interactively 'git-link-commit)))

(defun git-messenger-show-with-magit ()
  (interactive)
  (magit-show-commit git-messenger:last-commit-id)
  (git-messenger:popup-close))
