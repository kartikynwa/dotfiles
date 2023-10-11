;;; Emacs Bedrock
;;;
;;; Extra config: Development tools

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Version Control
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Magit: best Git client to ever exist
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Common file types
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package markdown-mode
  :commands (markdown-mode)
  :hook ((markdown-mode . visual-line-mode)))

(use-package yaml-mode
  :commands (yaml-mode)
  :ensure t)

(use-package json-mode
  :commands (json-mode)
  :ensure t)

(use-package web-mode
  :mode
  "\\.html\\'"
  "\\.html.erb\\'"
  "\\.phtml\\'"
  "\\.tpl\\.php\\'"
  "\\.[agj]sp\\'"
  "\\.as[cp]x\\'"
  "\\.erb\\'"
  "\\.mustache\\'"
  "\\.djhtml\\'"
  "\\.jsx?\\'"

  :custom
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)
  (web-mode-attr-indent-offset 2)
  (web-mode-sql-indent-offset 2)

  :commands (web-mode))

;; Emacs ships with a lot of popular programming language modes. If it's not
;; built in, you're almost certain to find a mode for the language you're
;; looking for with a quick Internet search.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Eglot, the built-in LSP client for Emacs
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eglot
  :elpaca nil

  :custom
  (eglot-send-changes-idle-time 0.1)

  :config
  (fset #'jsonrpc--log-event #'ignore))  ; massive perf boost---don't log every event


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Utilities
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun consult-buffer-smart ()
  "Execute `consult-buffer-project` if buffer is a projectile project, or `consult-buffer` otherwise"
  (interactive)
  (if (projectile-project-p)
    (consult-project-buffer)
    (consult-buffer)))

(defun find-file-smart ()
  "Execute `projectile-find-file` if buffer is a projectile project, or `find-file` otherwise"
  (interactive)
  (if (projectile-project-p)
    (projectile-find-file)
    (call-interactively #'find-file)))

(use-package projectile
  :ensure t
  :config
  (evil-define-key 'normal 'projectile-mode-map (kbd "<leader>p") 'projectile-command-map)
  (evil-define-key 'normal 'projectile-mode-map (kbd "<leader>b") 'consult-buffer-smart)
  (evil-define-key 'normal 'projectile-mode-map (kbd "<leader>f") 'find-file-smart)
  (projectile-mode +1))
