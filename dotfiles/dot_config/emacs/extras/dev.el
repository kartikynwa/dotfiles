;;; Emacs Bedrock
;;;
;;; Extra config: Development tools

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Version Control
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Magit: best Git client to ever exist
(use-package transient :ensure t)
(use-package magit
  :ensure t
  :after transient
  :bind (("C-x g" . magit-status)))

(use-package envrc
  :ensure t
  :config
  (envrc-global-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Common file types
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist '(javascript typescript))
  (global-treesit-auto-mode))

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
  :ensure t

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
  ;; "\\.jsx?\\'"

  :custom
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)
  (web-mode-attr-indent-offset 2)
  (web-mode-sql-indent-offset 2)

  :init
  (define-derived-mode web-mode-svelte web-mode "Svelte")
  (add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode-svelte))

  :commands (web-mode))

;; Emacs ships with a lot of popular programming language modes. If it's not
;; built in, you're almost certain to find a mode for the language you're
;; looking for with a quick Internet search.

(use-package go-mode
  :ensure t
  :commands (go-mode))

(use-package rust-mode
  :ensure t)

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Eglot, the built-in LSP client for Emacs
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-package eglot
  :ensure nil

  :custom
  (eglot-send-changes-idle-time 0.1)
  (eglot-extend-to-xref t)

  :general
  (lang-prefix-def "l" 'eglot)
  (lang-prefix-def
    :keymaps 'eglot-mode-map
    "r" 'eglot-rename
    "R" 'eglot-reconnect
    "q" 'eglot-shutdown
    "Q" 'eglot-shutdown-all)

  :config
  (add-to-list 'eglot-server-programs '(web-mode-svelte . ("svelteserver" "--stdio")))
  (fset #'jsonrpc--log-event #'ignore)) ; massive perf boost---don't log every event

;; (use-package eglot-booster
;;   :ensure (:host github :repo "jdtsmith/eglot-booster")
;;   :after eglot
;;   :config (eglot-booster-mode))

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
