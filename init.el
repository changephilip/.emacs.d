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
(context-menu-mode)
;;(auto-save-mode nil)
(scroll-bar-mode nil)
(global-hl-line-mode nil)

(setq ring-bell-function 'ignore)
(setq large-file-warning-threshold 100000000)

(setq tab-width 4)

;; from emacs-29 , linum-mode is deprecated
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook 'breadcrumb-mode)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'python-mode-hook 'eglot-ensure)
;;(add-to-list 'tramp-remote-path 'tramp-own-remote-path)


(when window-system
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 200 60)
  )

;; select fonts for different os
(when (eq system-type 'gnu/linux)
  ;;(set-frame-font "Source Code Pro 18")
  (set-frame-font "YaHei Monaco Hybird 20")
  )
(when (eq system-type 'darwin)
  (set-frame-font "Menlo 16")
  )
;;(set-frame-font "WenQuanYi Micro Hei Mono 18")


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

(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'corfu)
  )

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
  :ensure t
  )

(use-package diff-hl
  :ensure t
)  

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package geiser-guile
  :ensure t)

(use-package posframe
  :ensure t
  )

(use-package emacs
  :custom
  (ConTeXt-Mark-version "IV")
  (auto-save-default nil)
  (make-backup-files nil)
  (recentf-mode t)
  (column-number-mode t)
  (show-paren-mode t)
  (show-trailing-whitespace t)
  :bind
   ("C-x k" . volatile-kill-buffer)
   ("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("M-g i" . consult-imenu)
  :config
  (setq modus-themes-italic-constructs t
	 modus-themes-bold-constructs nil)
   (load-theme 'modus-operandi-tritanopia t)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Zathura")
     (output-html "xdg-open")))
 '(package-selected-packages
   '(doom-modeline highlight-indent-guides treemacs breadcrumb modus-themes org-modern auctex geiser-guile pyvenv eglot corfu projectile consult evil vertico marginalia sr-speedbar all-the-icons smartparens restart-emacs use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

