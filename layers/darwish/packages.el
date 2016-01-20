(setq darwish-packages
      '(yaml-mode jinja2-mode systemd google-this evil-mc flycheck python yasnippet pyvenv git-link evil-nerd-commenter magit))

(defun darwish/init-yaml-mode ()
  (use-package yaml-mode))

(defun darwish/init-systemd ()
  (use-package systemd))

(defun darwish/init-jinja2-mode ()
  (use-package jinja2-mode))

(defun darwish/init-google-this ()
  (use-package google-this
    :init (spacemacs/set-leader-keys "xgs" 'google-this-noconfirm)))

(defun darwish/post-init-evil-mc ()
  (global-evil-mc-mode t))

(defun darwish/post-init-flycheck ()
  (global-flycheck-mode t))

(defun darwish/post-init-yasnippet ()
  (add-to-list 'yas-snippet-dirs dcp-snippet-dir))

(defun darwish/post-init-pyvenv ()
  (add-hook 'python-mode-hook (pyvenv-tracking-mode t)))

(defun darwish/pre-init-git-link ()
  (eval-after-load "git-link"
    '(progn
      (add-to-list 'git-link-remote-alist
                   '("git.infinidat.com" git-link-gitlab))
      (add-to-list 'git-link-commit-remote-alist
                   '("git.infinidat.com" git-link-commit-gitlab)))))

(defun darwish/post-init-company ()
  (setq-default company-idle-delay 0.0))

(defun darwish/post-init-evil-nerd-commenter ()
  (define-key evil-normal-state-map (kbd "s-/") 'evilnc-comment-operator))

(defun darwish/post-init-magit ()
  (if (eq system-type 'darwin)
      (setq-default magit-revision-show-gravatars nil)
    ))
