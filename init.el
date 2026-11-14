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


;; Elpaca package manager

(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; fim da definição do elpaca

;; elpaca use-package

(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

;; general.el
;; (use-package general :ensure (:wait t) :demand t)

;; evil mode
;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil :ensure t :demand t)





