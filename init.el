;;(ADD-hook! 'emacs-startup-hook
;;  (setq gc-cons-threshold 16777216
;;        gc-cons-percentage 0.1
;;        file-name-handler-alist last-file-name-handler-alist))
(xterm-mouse-mode)
(setq package-enable-at-startup nil ; don't auto-initialize!
      ;; this tells package.el not to add those pesky customized variable settings
      ;; at the end of your init.el
      package--init-file-ensured t)

(setq package-archives '(
			 ;;("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ;;("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ;;("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
             ;;("gnu"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/gnu/")
             ;;("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/")
             ;;("org"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/org/")
             ("gnu"   . "https://elpa.emacs-china.org/gnu/")
             ("melpa" . "https://elpa.emacs-china.org/melpa/")
             ("org"   . "https://elpa.emacs-china.org/org/")
			 ))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

(setq package-check-signature nil)

(set-frame-font "WenQuanYi Micro Hei Mono 14")
(add-to-list 'after-make-frame-functions
             (lambda (new-frame)
               (select-frame new-frame)
               (set-frame-font "WenQuanYi Micro Hei Mono 14")
               )
             )

;;(use-package spacemacs-theme
;; :hook (after-init . (load-theme 'spacemacs-light)))
;;(require 'spacemacs-common)
(load-theme 'leuven t)
;;(load-theme 'spacemacs-light t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode -1)
;;(global-linum-mode t)
(add-hook 'prog-mode-hook 'linum-mode)

;;(fset 'yes-or-no-p' 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq help-window-select t)
(setq large-file-warning-threshold 100000000)

(setq tab-width 4)
(setq c-basic-offset 8)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 8)
(setq-default tab-width 4)
(setq-default c-basic-indent 4)

(show-paren-mode t)
(desktop-save-mode -1)
(auto-save-mode -1)


;;; fundamental framework packages
;; from stackoverflow.com/question/6467002/
(defun volatile-kill-buffer ()
"Kill current buffer unconditionally."
(interactive)
(if
    (buffer-modified-p (current-buffer))
    (progn
      (print "This buffer has been modified and not saved!")
      (interactive)
      (kill-buffer (current-buffer))
      ;;(kill-buffer (current-buffer))
      ;;(volatile-kill-buffer)
     )
  (kill-buffer (current-buffer))
  )
)

(use-package ivy
  :diminish
  :ensure t
  :config
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  :bind
  (
   ("C-s" . swiper-isearch)
   ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-x b" . ivy-switch-buffer)
   ("C-c v" . ivy-push-view)
   ("C-c V" . ivy-pop-view)
   ("C-x k" . volatile-kill-buffer)
   )
  )

(use-package counsel
  :diminish
  :ensure t
  )
(use-package smex)
(use-package flx)
(use-package avy)

(use-package which-key
  :diminish
  :ensure t
  )

(use-package hydra
  :ensure t
  )
(use-package use-package-hydra
  :ensure t
  :after hydra
  )
(use-package ivy-hydra
  :ensure t
  :after (ivy hydra)
  )

;;; completion global configure
(use-package company
  :ensure t
  :defer t
  :hook (after-init . company-mode)
  :init
  (progn
    (setq company-frontends '(company-pseudo-tooltip-frontend
			      company-echo-metadata-frontend)
	  company-tooltip-align-annotations t
	  company-require-match nil
	  company-dabbrev-ignore-case nil
	  company-dabbrev-downcase nil
	  )
    (setq company-backends
	  (append
	   '(company-capf company-semantic)
	   '(company-abbrev company-dabbrev company-dabbrev-code)
	   '(company-files)
	   '(company-keywords company-yasnippet)
	   ))
    )
  (setq company-minimum-preifx-length 3
	company-idle-delay 0.1
	company-selection-wrap-around 'on
	)
  :config
  (global-company-mode t)
  )

(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)
  )


;; fast switch windows and buffers
(use-package ace-window
  :ensure t
  )
(use-package windmove
  :config
  :bind (
         ("<f5> w h" . windmove-left)
         ("<f5> w <left>" . windmove-left)
         ("<f5> w l" . windmove-right)
         ("<f5> w <right>" . windmove-right)
         ("<f5> w j" . windmove-down)
         ("<f5> w <down>" . windmove-down)
         ("<f5> w k" . windmove-up)
         ("<f5> w <up>" . windmove-up)
         ("<f5> w D". delete-other-windows)
         ("<f5> w s h" . windmove-swap-states-left)
         ("<f5> w s l" . windmove-swap-states-right)
         ("<f5> w s j" . windmove-swap-states-down)
         ("<f5> w s k" . windmove-swap-states-up)
	     ("<f5> w d" . delete-window)
         ("<f5> f o" . other-frame)
         )
  )

(use-package awesome-tab
  :load-path "elpa/awesome-tab"
  :hook (after-init . awesome-tab-mode)
  ;;:after hydra
  :config
  (setq awesome-tab-show-tab-index t)
  (setq awesome-tab-label-fixed-length 10)
  (setq awesome-tab-height 100)
  :bind (
	 ("<f5> t h" . awesome-tab-backward-tab)
	 ("<f5> t l" . awesome-tab-forward-tab)
	 ("<f5> t j" . awesome-tab-forward-group)
	 ("<f5> t k" . awesome-tab-backward-group)
	 ("<f5> t s g" . awesome-tab-switch-group)
	 ("<f5> t n 1" . awesome-tab-select-visible-tab)
	 ("<f5> t n 2" . awesome-tab-select-visible-tab)
	 ("<f5> t n 3" . awesome-tab-select-visible-tab)
	 ("<f5> t n 4" . awesome-tab-select-visible-tab)
	 ("<f5> t n 5" . awesome-tab-select-visible-tab)
	 ("<f5> t n 6" . awesome-tab-select-visible-tab)
	 ("<f5> t n 7" . awesome-tab-select-visible-tab)
	 ("<f5> t n 8" . awesome-tab-select-visible-tab)
	 ("<f5> t n 9" . awesome-tab-select-visible-tab)
	 ("<f5> t n 0" . awesome-tab-select-visible-tab)
	 )
  )

;;; better configure
(use-package smartparens
  :diminish
  :ensure t
  :config
  (smartparens-global-mode)
  )
(use-package rainbow-delimiters
  :ensure t
  :hook (
         (emacs-lisp-mode lisp-mode c-mode c++-mode objc-mode) .
         (lambda ()
           (require 'rainbow-delimiters)
           (rainbow-delimiters-mode-enable)
           ))
  )

(add-hook 'prog-mode-hook #'hs-minor-mode)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'org-mode-hook #'auto-fill-mode)
(add-hook 'org-mode-hook 'toggle-company-english-helper)
(add-hook 'prog-mode-hook #'hl-todo-mode)

;;;lang
;; c-c++

;;(use-package company-c-heads
;;  :defer t
;;  :config
;;  (require 'dash')
;;  (setq company-c-headers-path-user '(".")
;;	company-c-headers-path-system
;;	(-flatten
;;	 (append
;;	  '("/usr/inlcude/" "/usr/local/inlcude/")
;;	  )
;;	 )
;;	)

(use-package lsp-mode :commands lsp
  )
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp)))
  :config
  (setq ccls-sem-highlight-method 'font-lock)
  (add-hook 'lsp-after-open-hook #'ccls-code-lens-mode)
  (ccls-use-default-rainbow-sem-highlight)
  :bind (
         ("<f7> g d" . lsp-find-declaration )
         ("<f7> g g" . lsp-find-definition )
         ("<f7> g r" . lsp-find-references )
         ("<f7> g f" . lsp-format-buffer )
         ("<f7> g n" . lsp-rename)
         ("<f7> g e" . lsp-treemacs-errors-list)
         )
  )   


;;rust
;;(push 'company-lsp company-backends)


;;(setq lsp-rust-server 'rust-analyzer)
;;(setq lsp-rust-analyzer-server-command '("~/.cargo/bin/rust-analyzer"))
;;(use-package rustic
;;  :ensure t
;;  :config
;;  )
;;; other utilities

;;Magit
(use-package magit
  :ensure t
  )

(use-package diff-hl
  :ensure t
  :hook (after-init . global-diff-hl-mode)
  :config
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  )

;; evil-mode for fast editting
;; evil is useful to avoid modifing buffer by mistake
(use-package evil
  :ensure t
  :hook (after-init . evil-mode)
  :bind ("<f6>" . evil-mode)
  )

;; writerroom-mode for read large paragraph
(use-package writeroom-mode
  ;;:ensure t
  :config
  (setq writeroom-fullscreen-effect 'maximized)
  (setq writeroom-mode-line t)
  )
;; bing-dict
(use-package bing-dict
  :bind
  ("<f5> o b" . bing-dict-brief)
  )

(use-package company-english-helper
  :load-path "elpa/company-english-helper"
  :hook ( org-mode .
                   (lambda ()
                            (require 'company-english-helper)
                            (toggle-company-english-helper)
                            )
                   )
  :bind
  ("<f7> o e")
  )

;; restart-emacs easily
(use-package restart-emacs
  ;;:ensure t
  )

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/bin/sbcl")

;;pyim
(pyim-basedict-enable)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 8 t)
 '(column-number-mode t)
 '(custom-safe-themes
   '("378d52c38b53af751b50c0eba301718a479d7feea5f5ba912d66d7fe9ed64c8f" "2d40e8de2c676ec749cf13a0a48e35a8b678a056dc397ffe8de4424dfa69d460" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(package-selected-packages
   '(0blayout csharp-mode slime-company flycheck pyim-basedict forth-mode powerline diff-hl hl-todo gnu-elpa-keyring-update counsel-projectile ag lsp-treemacs leuven-theme rainbow-delimiters magit bing-dict flx smex company-lsp yasnippet lsp-ui ccls company use-package-hydra hydra awesome-tab restart-emacs evil counsel use-package))
 '(pyim-dicts
   '((:name "bigdict" :file "/mnt/c/Users/pccha/Desktop/home/20201027/pyim-bigdict.pyim.gz")))
 '(which-key-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
