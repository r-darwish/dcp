(spacemacs/set-leader-keys-for-major-mode 'python-mode
  "tp" 'slash-parametrize
  "to" 'slash-toggle
  "l" 'pylint-ignore-errors-at-point)

(spacemacs/set-leader-keys-for-major-mode 'compilation-mode
  "j" 'jump-to-bad-ctor)

(spacemacs/set-leader-keys
  "pr" 'projectile-rebuild-project
  "pg" 'projectile-switch-to-git
  "ps" 'projectile-switch-and-search
  "pp" 'projectile-switch-project
  "jt" 'avy-goto-char-2
  "glp" 'project-git)

(spacemacs/set-leader-keys "ag"
  (lambda ()
     (interactive)
     (when (not (fboundp 'engine/search-google))
       (require 'engine-mode))
     (call-interactively 'engine/search-google)))
