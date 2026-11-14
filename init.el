;; -*- lexical-binding: t; -*-

;; startup perfomace

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)


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

;; package.el setup


;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)





