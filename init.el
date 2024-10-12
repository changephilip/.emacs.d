;; -*- lexical-binding: t; -*-
(set-default-coding-systems 'utf-8)
(setq package-archives '(
			 ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("nongnu-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
			 ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)
(setq package-check-signature nil)

;;(xterm-mouse-mode)
(if (display-graphic-p)
    ()
    (xterm-mouse-mode)
    )
(context-menu-mode)
;;(auto-save-mode nil)
(scroll-bar-mode nil)
(global-hl-line-mode nil)

(setq ring-bell-function 'ignore)
(setq large-file-warning-threshold 100000000)

(setq tab-width 4)
(indent-tabs-mode nil)


(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook 'breadcrumb-mode)
;;(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'prog-mode-hook 'indent-guide-mode)
(add-hook 'python-mode-hook 'eglot-ensure)


;;(when window-system
;;  (set-frame-position (selected-frame) 0 0)
;;  (set-frame-size (selected-frame) 200 60)
;;  )

(when (eq system-type 'gnu/linux)
  ;;(set-frame-font "Source Code Pro 18" nil t)
  (set-frame-font "IBM Plex Mono 18" nil t)
  )
(when (eq system-type 'darwin)
  (set-frame-font "Menlo 16" nil t)
  )

;;(set-frame-font "WenQuanYi Micro Hei Mono 18")

(when (eq system-type 'windows-nt)
  (set-frame-font "YaHei Monaco Hybird 14" nil t)
  (tool-bar-mode -1)
  )

;;(add-to-list 'tramp-remote-path 'tramp-own-remote-path)


;;custom function
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



;;package configure
;;base
(use-package evil
  :ensure t
  :hook (after-init . evil-mode)
  :bind ("<f6>" . evil-mode)
  )

(use-package which-key
  :diminish
  :ensure t
  :config
  (which-key-mode t)
  )

(use-package vertico
  :init
  (vertico-mode)
  )

(use-package orderless
  :init
 (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion))))
 )

(use-package marginalia
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode)
  )

(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  )

(use-package smartparens
  :diminish
  :ensure t
  :config
  (smartparens-global-mode)
  )

(use-package rainbow-delimiters
  :defer t
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode)
  )

;;(use-package projectile
;;  :ensure t
;;  :config
;;  (setq projectile-completion-system 'corfu)
;;  )

(use-package savehist
  :init
  (savehist-mode)
  )

(use-package all-the-icons
  :if (display-graphic-p))

(use-package restart-emacs
  )

;;completion
(use-package corfu
  :init
  (setq corfu-auto t)
  (setq corfu-quit-at-boundary t)
  (global-corfu-mode)
  )

(use-package corfu-terminal
  :init
  (unless (display-graphic-p)
    (corfu-terminal-mode +1))
  )

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  )

;;
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  )

(use-package magit
  )

(use-package diff-hl
  :ensure t
  :hook (after-init . global-diff-hl-mode)
  :config
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  )

(use-package breadcrumb
  )

(use-package treemacs
  :ensure t)
(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package modus-themes
  :ensure t
  :config
  (setq modus-themes-italic-constructs t
	modus-themes-bold-constructs nil)
  ;;(load-theme 'modus-operandi-tritanopia t)
  )

;;(use-package ef-themes
;;  :ensure t)
;;
;;;;; CATPPUCCIN THEME
;;;; The `catppuccin-theme' package provides a visually pleasing color theme
;;;; for Emacs that is inspired by the popular Catppuccin color palette.
;;;; This theme aims to create a comfortable and aesthetic coding environment
;;;; with soft colors that are easy on the eyes.
(use-package catppuccin-theme
  :ensure t
  :config
;;  (custom-set-faces
;;   ;; Set the color for changes in the diff highlighting to blue.
;;   `(diff-hl-change ((t (:background unspecified :foreground ,(catppuccin-get-color 'blue))))))
;;
;;  (custom-set-faces
;;   ;; Set the color for deletions in the diff highlighting to red.
;;   `(diff-hl-delete ((t (:background unspecified :foreground ,(catppuccin-get-color 'red))))))
;;
;;  (custom-set-faces
;;   ;; Set the color for insertions in the diff highlighting to green.
;;   `(diff-hl-insert ((t (:background unspecified :foreground ,(catppuccin-get-color 'green))))))
;;
;;  ;; Load the Catppuccin theme without prompting for confirmation.
  (setq catppuccin-italic-comments t)
  (setq catppuccin-highlight-matches t)
  (setq catppuccin-flavor 'latte)
  (load-theme 'catppuccin :no-confirm))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package tramp
  :config
  (setq tramp-verbose 3)
  (setq enable-remote-dir-locals t)
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  ;;(setq tramp-use-ssh-controlmaster-options nil)
  (when (eq system-type 'windows-nt)
    (setq tramp-use-ssh-controlmaster-options nil)
    (add-to-list 'tramp-connection-properties
	       (list (regexp-quote "/ssh:")
		     "login-args"
		     '(("-tt") ("-l" "%u") ("-p" "%p") ("%c")
		       ("-e" "none") ("%h"))))
    )
  )

(use-package emacs
  :custom
  (auto-save-default nil)
  (make-backup-files nil)
  (recentf-mode t)
  (column-number-mode t)
  (show-paren-mode t)
  (show-trailing-whitespace t)
  ;;(setq highlight-indent-guides-method 'character)
  (setq frame-resize-pixelwise t)
  :bind
  (
   ("C-x k" . volatile-kill-buffer)
   ("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("M-g i" . consult-imenu)
  )
  )

;;(use-package geiser-guile
;; :ensure t)

;;(use-package rime
;;  :custom
;;  (default-input-method "rime")
;;  )

(setq ConTeXt-Mark-version "IV")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(hl-todo indent-guide catppuccin-theme rainbow-delimiters pyim-basedict treemacs-evil pyim treemacs highlight-indent-guides doom-modeline breadcrumb ef-themes modus-themes org-modern auctex magit devdocs geiser-guile pyvenv eglot corfu consult evil vertico marginalia sr-speedbar smartparens restart-emacs use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
