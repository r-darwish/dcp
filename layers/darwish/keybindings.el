(define-key evil-normal-state-map (kbd "<M-down>") 'spacemacs/next-error)
(define-key evil-normal-state-map (kbd "<M-up>") 'spacemacs/previous-error)
(spacemacs/set-leader-keys "h m" 'man)
(spacemacs/set-leader-keys-for-major-mode 'python-mode
  "tp" 'darwish/python-pytest-parametrize
  "to" 'darwish/python-pytest-parametrize-boolean)
