(defun pylint-ignore-errors-at-point ()
  (interactive)
  (let* ((errs (flycheck-overlay-errors-in (line-beginning-position) (line-end-position)))
         (ids (-map (lambda (s) (flycheck-error-id s)) errs)))
    (if (> (length ids) 0)
        (save-excursion
          (end-of-line)
          (insert "  # pylint: disable="
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

(defun projectile-switch-and-search ()
  (interactive)
  (let ((projectile-switch-project-action 'spacemacs/search-project-auto))
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

(defun project-git ()
  (interactive)
  (cl-letf (((symbol-function 'git-link--relative-filename) (lambda () ".gitignore"))
            ((symbol-function 'git-link--get-region) (lambda () nil)))
    (call-interactively 'git-link)))

(defun my-compilation-hook ()
  (spacemacs/scale-down-font))

(add-hook 'compilation-mode-hook 'my-compilation-hook)


(add-hook 'python-mode-hook
          (lambda () (let ((root-dir (projectile-project-root)))
                        (when root-dir
                          (let ((pylintrc (concat (file-name-as-directory root-dir) ".pylintrc")))
                            (when (file-exists-p pylintrc)
                              (make-local-variable 'flycheck-pylintrc)
                              (setq flycheck-pylintrc pylintrc)))))))
