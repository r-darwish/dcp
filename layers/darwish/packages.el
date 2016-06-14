(setq darwish-packages
      '((slash :location local)
        modern-cpp-font-lock))

(defun darwish/init-slash ()
  (use-package slash))

(defun darwish/init-modern-cpp-font-lock ()
  (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode))
