(spacemacs/set-leader-keys-for-major-mode 'python-mode
  "tp" 'slash-parametrize
  "to" 'slash-toggle
  "l" 'pylint-ignore-errors-at-point)

(spacemacs/set-leader-keys-for-major-mode 'compilation-mode
  "j" 'jump-to-bad-ctor)
