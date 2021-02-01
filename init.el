;;(add-hook! 'emacs-startup-hook
 ;; (setq gc-cons-threshold 16777216
  ;;      gc-cons-percentage 0.1
   ;;     file-name-handler-alist last-file-name-handler-alist))

(setq package-enable-at-startup nil ; don't auto-initialize!
      ;; this tells package.el not to add those pesky customized variable settings
      ;; at the end of your init.el
      package--init-file-ensured t)

(setq package-archives '(
			 ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
			 )
      )
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

(setq package-check-signature nil)


;;(set-frame-font "WenQuanYi Micro Hei Mono 12")
;;(add-to-list 'after-make-frame-functions
;;             (lambda (new-frame)
;;               (select-frame new-frame)
;;               (set-frame-font "WenQuanYi Micro Hei Mono 12")
;;               ))

;;(set-frame-font "Sarasa Fixed SC 14")
;;(add-to-list 'after-make-frame-functions
;;             (lambda (new-frame)
;;               (select-frame new-frame)
;;               (set-frame-font "Sarasa Fixed SC 14")
;;               ))

;;(load-theme 'spacemacs-light t)
(load-theme 'leuven)

(menu-bar-mode -1)
(tool-bar-mode -1)
;;(scroll-bar-mode -1)
(global-hl-line-mode t)
(add-hook 'prog-mode-hook 'linum-mode)

(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq help-window-select t)
(setq large-file-warning-threshold 100000000)

(setq tab-width 4)
(setq c-basic-offset 8)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 8)
(setq-default tab-width 4)
(setq-default c-basic-indent 8)

(show-paren-mode t)
(desktop-save-mode -1)
(auto-save-mode -1)


;;; fundamental framework packages
(defun volatile-kill-buffer ()
  "Kill Current buffer unconditionally."
  (interactive)
  (if
      (buffer-modified-p (current-buffer))
      (progn
        (print "This buffer has been modified and not saved!")
        (interactive)
        (kill-buffer (current-buffer))
        )
    (kill-buffer (current-buffer))
    )
  )

(use-package ivy
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

;;(use-package windmove
;;  :config
;;  :bind (
;;         ("<f5> w  h" . windmove-left)
;;         ("<f5> w  <left>" . windmove-left)
;;         ("<f5> w  l" . windmove-right)
;;         ("<f5> w  <right>" . windmove-right)
;;         ("<f5> w  j" . windmove-down)
;;         ("<f5> w  <down>" . windmove-down)
;;         ("<f5> w  k" . windmove-up)
;;         ("<f5> w  <up>" . windmove-up)
;;         ("<f5> w D ". delete-other-windows)
;;         ("<f5> w s h" . windmove-swap-states-left)
;;         ("<f5> w s l" . windmove-swap-states-right)
;;         ("<f5> w s j" . windmove-swap-states-down)
;;         ("<f5> w s k" . windmove-swap-states-up)
;;         ("<f5> w d" . delete-window)
;;         ;;("C-w d"    . delete-window)
;;         ("<f5> f o" . other-frame)
;;         ("<f5> b p" . switch-to-prev-buffer)
;;         ("<f5> b n" . switch-to-next-buffer)
;;         )
;;  )


;;(use-package awesome-tab
;;  :load-path "elpa/awesome-tab"
;;  :hook (after-init . awesome-tab-mode)
;;  ;;:after hydra
;;  :config
;;  (setq awesome-tab-show-tab-index t)
;;  (setq awesome-tab-label-fixed-length 10)
;;  (setq awesome-tab-height 100)
;;  :bind (
;;	 ("<f5> t l" . awesome-tab-forward-tab)
;;	 ("<f5> t h" . awesome-tab-backward-tab)
;;	 ("<f5> t j" . awesome-tab-forward-group)
;;	 ("<f5> t k" . awesome-tab-backward-group)
;;	 ("<f5> t s g" . awesome-tab-switch-group)
;;	 ("<f5> t n 1" . awesome-tab-select-visible-tab)
;;	 ("<f5> t n 2" . awesome-tab-select-visible-tab)
;;	 ("<f5> t n 3" . awesome-tab-select-visible-tab)
;;	 ("<f5> t n 4" . awesome-tab-select-visible-tab)
;;	 ("<f5> t n 5" . awesome-tab-select-visible-tab)
;;	 ("<f5> t n 6" . awesome-tab-select-visible-tab)
;;	 ("<f5> t n 7" . awesome-tab-select-visible-tab)
;;	 ("<f5> t n 8" . awesome-tab-select-visible-tab)
;;	 ("<f5> t n 9" . awesome-tab-select-visible-tab)
;;	 ("<f5> t n 0" . awesome-tab-select-visible-tab)
;;	 )
;;  )

;;; better configure
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode)
  )

(use-package rainbow-delimiters
  :ensure t
  :hook (
         (prog-mode emacs-lisp-mode lisp-mode c-mode c++-mode objc-mode) .
         (lambda()
           (require 'rainbow-delimiters)
           (rainbow-delimiters-mode-enable)
           )
         )
  )

(add-hook 'prog-mode-hook #'hs-minor-mode)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'toggle-company-english-helper)

;;;lang
;; c-c++

;;（use-package company-c-heads
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
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'lsp-mode)(lsp))
         )
;;  :bind (
;;         ("<f7> g d" . lsp-find-declaration )
;;         ("<f7> g g" . lsp-find-definition )
;;         ("<f7> g r" . lsp-ui-peek-find-references )
;;         ("<f7> g f" . lsp-format-buffer )
;;         ("<f7> g n" . lsp-rename)
;;         ("<f7> g e" . lsp-treemacs-errors-list)
;;         )
  :config
  (setq gc-cons-threshold (* 100 1024 ))
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-headerline-breadcrumb-enable t)
  (setq company-idle-delay 0.0)
  (setq company-minimum-prefix-length 1)
  (setq lsp-idle-delay 0.1)
  )
(use-package lsp-ui :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-position 'top)
;;  (add-hook 'lsp-ui-doc-frame-hook
;;            (lambda (frame _w)
;;              (set-face-attribute 'default frame :font "WenQuanYi Micro Hei Mono" :height 100))
;;	    )
  )
(use-package company-lsp :commands company-lsp)


;;(use-package ccls
;;  :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;         (lambda () (require 'ccls) (lsp)))
;;  :config
;;  (setq ccls-sem-highlight-method 'font-lock)
;;  (add-hook 'lsp-after-open-hook #'ccls-code-lens-mode)
;;  (ccls-use-default-rainbow-sem-highlight)
;;  :bind (
;;         ("<f7> g d" . lsp-find-declaration )
;;         ("<f7> g g" . lsp-find-definition )
;;         ("<f7> g r" . lsp-find-references )
;;         ("<f7> g f" . lsp-format-buffer )
;;         )
;;  )
;;
;;(use-package eglot
;;  :ensure t
;;;;  :hook ((c-mode c++-mode objc-mode) .
;;;;         (lambda ( (require 'eglot)(eglot)))
;;;;         )
;;  )

;; elisp

;; gauche
;;(use-package geiser-gauche
;;  :after geiser
;;  :init (add-to-list 'geiser-active-implementations 'gauche))
;;(setq geiser-gauche-binary "c:\\Program Files\\Gauche\\bin\\gosh")
;;; other utilities

;;(use-package magit
;;  :ensure t
;;  )
;;(use-package diff-hl
;;  :ensure t
;;  :hook (after-init . global-diff-hl-mode)
;;  :config
;;  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
;;  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
;;  )

;; evil-mode for fast editting
(use-package evil
  :ensure t
  :hook (after-init . evil-mode)
  ;;:bind ("<f6>" . evil-mode)
  )

;;org literature programming
;;org-ref
;;(use-package org-ref
;;  :ensure t
;;)
;;(require 'org-ref)

;;pdf-tools
;;(use-package pdf-tools
;;  :hook (doc-view-mode . pdf-view-mode)
;;  :init
;;  (pdf-tools-install)
;;  )

;;org-agenda
;;(setq org-agenda-files (directory-files-recursively "c:/Users/pccha/Desktop/BDP-work/" "\\.org$"))

;; writerroom-mode for read large paragraph
;;(use-package writeroom-mode
;;  ;;:ensure t
;;  :config
;;  (setq writeroom-fullscreen-effect 'maximized)
;;  (setq writeroom-mode-line t)
;;  )
;;(use-package bing-dict
;;  :ensure t
;;  :bind
;;  ("<f7> o b" . bing-dict-brief)
;;  )

;;(use-package company-english-helper
;;  :load-path "elpa/company-english-helper"
;;  :hook (org-mode .
;;                   (lambda ()
;;                            (require 'company-english-helper)
;;                            (toggle-company-english-helper)
;;                            )
;;                   )
;;  :bind
;;  ("<f7> o e")
;;  )
;;

;; restart-emacs easily
(use-package restart-emacs
  :ensure t
  )



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yasnippet-snippets restart-emacs evil company-lsp lsp-ui lsp-mode rainbow-delimiters smartparens ace-window projectile company ivy-hydra use-package-hydra hydra which-key avy flx smex counsel ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
