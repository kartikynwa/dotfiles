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

;;

(use-package envrc
  :ensure t
  :config
  (envrc-global-mode))

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

(use-package blacken
  :ensure t
  :commands (blacken-buffer blacken-mode)
  :general
  (lang-prefix-def :keymaps 'python-mode-map "f" 'blacken-buffer))

;; Emacs ships with a lot of popular programming language modes. If it's not
;; built in, you're almost certain to find a mode for the language you're
;; looking for with a quick Internet search.

(use-package go-mode
  :ensure t
  :commands (go-mode)
  :general
  (lang-prefix-def :keymaps 'go-mode-map "f" 'gofmt))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Eglot, the built-in LSP client for Emacs
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-package eglot
  :elpaca nil

  :custom
  (eglot-send-changes-idle-time 0.1)

  :general
  (lang-prefix-def "l" 'eglot)
  (lang-prefix-def
    :keymaps 'eglot-mode-map
    "r" 'eglot-rename
    "R" 'eglot-reconnect
    "q" 'eglot-shutdown
    "Q" 'eglot-shutdown-all)

  :config
  (fset #'jsonrpc--log-event #'ignore)) ; massive perf boost---don't log every event

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
  :ensure t :demand t
  :general
  (leader-def
    :keymaps 'projectile-mode-map
    "p" '(projectile-command-map :wk "projectile")
    "," 'consult-buffer-smart
    "." 'find-file-smart)
  :init
  (projectile-mode +1))
