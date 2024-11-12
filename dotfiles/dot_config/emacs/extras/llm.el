(use-package gptel
  :ensure t
  :straight t
  :config
  (setq
    gptel-model 'mistral:latest
    gptel-backend (gptel-make-ollama "Ollama"
                    :host "localhost:11434"
                    :stream t
                    :models '(qwen2.5-coder:7b))))
