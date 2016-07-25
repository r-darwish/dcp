(setq darwish-packages
      '((slash :location local)
        modern-cpp-font-lock
        python-mode
        git-messenger
        git-link))

(defun darwish/init-slash ()
  (use-package slash))

(defun darwish/init-python-mode ()
  (use-package python-mode))

(defun darwish/init-modern-cpp-font-lock ()
  (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode))

(defun darwish/pre-init-git-link ()
  (eval-after-load "git-link"
    '(progn
      (add-to-list 'git-link-remote-alist '("git.infinidat.com" git-link-gitlab))
      (add-to-list 'git-link-commit-remote-alist '("git.infinidat.com" git-link-commit-github)))))

(defun darwish/post-init-git-messenger ()
  (spacemacs|use-package-add-hook git-messenger
    :post-config
    (progn
      (define-key git-messenger-map (kbd "l") 'git-link-commit-from-messenger)
      (define-key git-messenger-map (kbd "d") 'git-messenger-show-with-magit))))
