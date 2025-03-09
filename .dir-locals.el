((haskell-mode .
   ((mode . format-all)
    (eval . (progn
              (setq-local format-all-formatters '(("Haskell" fourmolu)))
              (add-hook 'after-save-hook 'format-all-buffer nil t)))
    )))
