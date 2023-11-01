;;; Emacs Bedrock
;;;
;;; Extra config: Vim emulation

;;; Usage: Append or require this file from init.el for bindings in Emacs.

;;; Contents:
;;;
;;;  - Core Packages

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Core Packages
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Evil: vi emulation
(use-package evil
  :ensure t

  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)

  ;; Enable this if you want C-u to scroll up, more like pure Vim
  ;(setq evil-want-C-u-scroll t)

  :config
  (evil-mode)

  ;; Configuring initial major mode for some modes
  (evil-set-initial-state 'vterm-mode 'emacs))

(use-package evil-collection
  :ensure t
  :after (evil)
  :config
  (evil-collection-init))

;; General for managing keybindings
(use-package general
  :ensure t :demand t
  :after (evil)
  :config
  (general-define-key :states '(normal motion)
      "H" 'tab-previous
      "L" 'tab-next)
  ;; Basic leader prefix
  (general-create-definer leader-def
    :states '(normal insert motion emacs)
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
    :prefix-command 'leader-prefix
    :prefix-map 'leader-prefix-map)
  (leader-def
    "h" '(:keymap help-map :wk "help")
    "f" 'find-file
    ;; Buffer prefix
    "b" '(nil :wk "buffer")
    "bb" 'consult-buffer
    "bn" 'next-buffer
    "bp" 'previous-buffer
    "bd" 'kill-this-buffer
    "bs" 'scratch-buffer
    ;; Tab prefix
    "t" '(nil :wk "tab")
    "tt" 'tab-new
    "tn" 'tab-next
    "tp" 'tab-previous
    "tq" 'tab-close
    ;;
    "w" '(:keymap evil-window-map :wk "window"))
  ;; Prefix for lsp, formatting, etc. based commands
  (general-create-definer lang-prefix-def
    :states '(normal insert motion emacs)
    :prefix "SPC l"
    :non-normal-prefix "M-SPC l"
    :prefix-command 'lang-prefix
    :prefix-map 'lang-prefix-map)
  (lang-prefix-def
    "" '(nil :wk "language"))
)
(elpaca-wait)

;; You have been SURROUNDED
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))
