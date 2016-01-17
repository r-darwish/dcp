(add-to-list 'auto-mode-alist '("PKGBUILD\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.pylintrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("slashrc\\'" . python-mode))
(setq-default js2-basic-offset 2
              css-indent-offset 2
              c-basic-offset 4
              git-commit-summary-max-length 200
              git-commit-fill-column 200
              vc-follow-symlinks t
              magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256")))
