(setq darwish-packages
      '((slash :location local)
        modern-cpp-font-lock
        git-link))

(defun darwish/init-slash ()
  (use-package slash))

(defun darwish/init-modern-cpp-font-lock ()
  (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode))

(defun darwish/pre-init-git-link ()
  (eval-after-load "git-link"
    '(progn
      (add-to-list 'git-link-remote-alist '("git.infinidat.com" git-link-gitlab))
      (add-to-list 'git-link-commit-remote-alist '("git.infinidat.com" git-link-commit-github)))))
