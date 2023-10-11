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
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)

  ;; Enable this if you want C-u to scroll up, more like pure Vim
  ;(setq evil-want-C-u-scroll t)

  :config
  (evil-mode)
  (evil-set-leader nil (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>F") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>h") `("+help" . ,help-map))

  ;; Configuring initial major mode for some modes
  (evil-set-initial-state 'vterm-mode 'emacs))
