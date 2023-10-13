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

;; General for managing keybindings
(use-package general
  :ensure t
  :config
  (evil-general-setup))

(defun evil-general-setup ()
  "Perform basic general.el setup for evil-mode"
  (general-create-definer tyrant-def
    :states '(normal insert motion emacs)
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
    :prefix-command 'tyrant-prefix-command
    :prefix-map 'tyrant-prefix-map)
  (tyrant-def
    "h" '(:keymap help-map :wk "help")
    "f" 'find-file
    "b" 'consult-buffer))
