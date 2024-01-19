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

(xterm-mouse-mode)
(show-paren-mode t)
;;(auto-save-mode nil)
(scroll-bar-mode nil)
(global-hl-line-mode nil)

(setq ring-bell-function 'ignore)
(setq large-file-warning-threshold 100000000)

(setq tab-width 4)


(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'python-mode-hook 'eglot-ensure)


(when window-system
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 128 51)
  )

(when (eq system-type 'gnu/linux)
  (set-frame-font "Source Code Pro 18")
  )
(when (eq system-type 'darwin)
  (set-frame-font "Menlo 16")
  )

(when (eq system-type 'windows-nt)
  (set-frame-font "YaHei Monaco Hybird 14")
  (tool-bar-mode -1)
  ;; tramp configure for windows-nt
  (require 'tramp)
  (setq tramp-use-ssh-controlmaster-options nil)
  (add-to-list 'tramp-connection-properties
	       (list (regexp-quote "/ssh:")
		     "login-args"
		     '(("-tt") ("-l" "%u") ("-p" "%p") ("%c")
		       ("-e" "none") ("%h"))))
  )


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
  :if (display-graphic-p)
  )

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
  :ensure t
  )

(use-package diff-hl
  :ensure t
  :hook (after-init . global-diff-hl-mode)
  :config
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  )

(use-package posframe
  :ensure t
  )

;;(use-package rime
;;  :custom
;;  (rime-librime-root "~/.emacs.d/librime")
;;  (default-input-method "rime")
;;  (rime-show-candidate 'posframe)
;;  )

(use-package modus-themes
  :ensure t
  :config
  (setq modus-themes-italic-constructs t
	modus-themes-bold-constructs nil)
  (load-theme 'modus-operandi-tritanopia t)
  )

(use-package emacs
  :custom
  ;;(ConTeXt-Mark-version "IV")
  (auto-save-default nil)
  (make-backup-files nil)
  :bind
  ("C-x k" . volatile-kill-buffer)
  ("C-s" . consult-line)
  ("C-x b" . consult-buffer)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a0997c8cd72b848c675e66531265b68845cfdb222b32762ac8773c1dc957d10a" default))
 '(package-selected-packages
   '(modus-themes pyvenv eglot corfu consult evil vertico marginalia sr-speedbar all-the-icons smartparens restart-emacs use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

