(defvar slime-description-highlights
  `(("^  [^\\[ ]\\([^:]*\\):" . font-lock-doc-face)))

(define-derived-mode slime-description-mode fundamental-mode "Slime description"
  "Slime description mode."
  (setq font-lock-defaults '(slime-description-highlights)))

(define-key slime-description-mode-map (kbd "q")  'quit-window)

(setq slime-description-highlights
  `(("^  \\b[^:]+:" . font-lock-doc-face)
    ("^\\b[^ ]+" . font-lock-function-name-face)))

(defun enable-description-mode-advice (&rest args)
  "Something with ARGS."
  (if (get-buffer "*slime-description*")
   (with-current-buffer (get-buffer "*slime-description*")
     (slime-description-mode))))

(defun enable-company-description-mode-advice (&rest args)
  "Something with ARGS."
  (if (get-buffer "*company-documentation*")
   (with-current-buffer (get-buffer "*company-documentation*")
     (slime-description-mode))))

(advice-add 'slime-show-description :after #'enable-description-mode-advice)
(advice-add 'slime-company--doc-buffer :after #'enable-company-description-mode-advice)
