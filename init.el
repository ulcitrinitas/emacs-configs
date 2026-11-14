;; -*- lexical-binding: t; -*-
;; esconder itens da interface
(menu-bar-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; inibir startup screen
;; (setq inhibt-startup-screen t)
(setq inhibit-startup-message t)

;; Font
(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 120)

;; Tema padrão
(load-theme 'wombat t)

;; Quebra de linha automática em texto
(global-visual-line-mode 1)

;; Fechar parênteses automaticamente
(electric-pair-mode t)

;; Mostrar número das linhas
(global-display-line-numbers-mode 1)

;; troca o tipo de lista do buffer
(global-set-key [remap list-buffers] 'ibuffer)

;; destaque da linha atual
(global-hl-line-mode -1)

;; alertas visuais
(setq visible-bell t)

;; habilita o which-key
(which-key-mode t)
(which-key-setup-side-window-right)

;; espaçamento das bordas laterais
(set-fringe-mode 10)

;; desabilita o Ctrl-Z (suspend frame)
(global-unset-key (kbd "C-z"))

;; texto substitui a seleção
(delete-selection-mode t)

;; rolagem suave
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1)) ;; duas linhas por vez
      mouse-wheel-progressive-speed nil ;; não acelera a rolagem
      mouse-wheel-follow-mouse 't ;; rola a janela sob o mouse
      scroll-step 1 ;; rola uma linha com o teclado
      )


;; organizando os backups
(setq backup-directory-alist `(("." . "~/.saves")))

;; tipo do cursor
(setq-default cursor-type 'bar)

;; função para criar um novo buffer

(defun debmx-new-buffer ()
  "Cria um novo buffer `sem nome`"
  (interactive) ;; funções disponiveis no emacs ou um comando personalizavel
  (let ((debmx/buf (generate-new-buffer "sem nome")))
    (switch-to-buffer debmx/buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    debmx/buf))

;; modo inicial
;; (setq initial-major-mode 'prog-mode)
;; (setq initial-buffer-choice 'debmx-new-buffer)






