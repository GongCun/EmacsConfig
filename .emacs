;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)

(define-key global-map (kbd "RET") 'newline-and-indent)

(setq default-major-mode 'text-mode)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (add-hook 'text-mode-hook (lambda() (abbrev-mode 1)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-modes
   (quote
    (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode nim-mode c-mode cc-mode c++-mode objc-mode swift-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js-jsx-mode js2-mode js2-jsx-mode coffee-mode php-mode css-mode scss-mode less-css-mode elixir-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode web-mode ts-mode sclang-mode verilog-mode qml-mode apples-mode text-mode evil-mode org-mode shell-script-mode)))
 '(c-electric-pound-behavior (quote (alignleft)))
 '(c-hanging-semi&comma-criteria (quote set-from-style))
 '(c-offsets-alist (quote ((statement-cont . +))))
 '(c-syntactic-indentation-in-macros nil)
 '(comment-column 34)
 '(compile-command "make ")
 '(org-edit-src-content-indentation 8)
 '(org-export-with-sub-superscripts (quote {}))
 '(org-src-fontify-natively t)
 '(org-src-preserve-indentation t)
 '(org-src-tab-acts-natively t)
 '(org-src-window-setup (quote reorganize-frame))
 '(org-startup-folded nil)
 '(package-selected-packages (quote (flymd markdown-mode evil auto-complete)))
 '(vc-handled-backends (quote (Git))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Courier"))))
 '(mode-line ((t (:background "gray30" :box (:line-width 1 :color "Red") :family "DejaVu Sans Mono-10")))))

(show-paren-mode)
(setq show-paren-delay 0)

(ac-config-default)
(global-auto-complete-mode t)

(setq-default file-column 78)

(setq column-number-mode t)
(setq line-number-mode t)
(global-set-key "\C-xp" 'picture-mode)
(global-set-key "\C-ci" 'string-insert-rectangle)
(global-set-key "\C-xt" 'visit-tags-table)
(global-set-key [f8] 'compile)

(defun set-c-toggle-hungry-state()
  (c-toggle-hungry-state 1))

(defun set-c-toggle-auto-state()
  (c-toggle-auto-state 1))

(add-hook 'c-mode-hook
	  (lambda ()
	    (c-set-style "linux")
	    (flyspell-prog-mode)
	    (turn-on-auto-fill)
	    (setq indent-tabs-mode nil)
	    ))
(add-hook 'c-mode-hook 'set-c-toggle-hungry-state)
(add-hook 'c-mode-hook 'set-c-toggle-auto-state)

(add-hook 'c++-mode-hook
	  (lambda ()
	    (c-set-style "Stroustrup")
	    (flyspell-prog-mode)
	    (turn-on-auto-fill)
	    (setq indent-tabs-mode nil)
	    ))
(add-hook 'c++-mode-hook 'set-c-toggle-hungry-state)
(add-hook 'c++-mode-hook 'set-c-toggle-auto-state)

;; (defun my-c-mode-hook ()
   ;; (c-set-offset' statement-cont))
;; (add-hook 'c-mode-hook 'my-c-mode-hook)

;;;; indent the wrap newline on the right side of equal sign
(c-add-style "linux"
	     '((c-basic-offset . 8)
	       (c-offsets-alist
		(statement-cont . c-lineup-assignments)
		(arglist-close . 0)
		)))

(c-add-style "Stroustrup"
	     '((c-basic-offset . 4)
	       (c-offsets-alist
		(statement-cont . c-lineup-assignments)
		(arglist-close . 0)
		)))


(add-hook 'shell-script-mode-hook
	  (lambda ()
	    (flyspell-prog-mode)
	    (setq indent-tabs-mode nil)
	    ))

(global-linum-mode t)
(setq linum-format "%5d ")
(global-set-key "\M-*" 'pop-tag-mark)

(setq lazy-highlight-cleanup nil)
(setq save-interprogram-paste-before-kill t)
(setq yank-pop-change-selection t)


;;disable backup
(setq backup-inhibited t)

;;disable auto-save
(setq auto-save-default nil)

;;cflow setup
(autoload 'cflow-mode "cflow-mode")
(setq auto-mode-alist (append auto-mode-alist
			      '(("\\.cflow$" . cflow-mode))))

(global-auto-revert-mode 1)

;; Load Evil
;; (setq evil-toggle-key "")
(setq evil-shift-width 8)
(require 'evil)

;; disabled \C-a, \C-e, \C-d, \C-k, ... in evil-mode
(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-insert-state-map
		 evil-normal-state-map
		 evil-visual-state-map
                 evil-emacs-state-map))
    (define-key (eval map) "\C-e" nil)))

(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-insert-state-map
		 evil-normal-state-map
		 evil-visual-state-map
                 evil-emacs-state-map))
    (define-key (eval map) "\C-a" nil)))

(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-insert-state-map
		 evil-normal-state-map
		 evil-visual-state-map
                 evil-emacs-state-map))
    (define-key (eval map) "\C-d" nil)))

(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-insert-state-map
		 evil-normal-state-map
		 evil-visual-state-map
                 evil-emacs-state-map))
    (define-key (eval map) "\C-k" nil)))

(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-insert-state-map
		 evil-normal-state-map
		 evil-visual-state-map
                 evil-emacs-state-map))
    (define-key (eval map) "\C-n" nil)))

(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-insert-state-map
		 evil-normal-state-map
		 evil-visual-state-map
                 evil-emacs-state-map))
    (define-key (eval map) "\C-p" nil)))

;; don't use vim 'window only' command
(eval-after-load "evil-maps"
  (define-key evil-motion-state-map "\C-wo" nil))

;;;;;;


(setq evil-auto-indent t)
(setq evil-repeat-move-cursor t)
(setq evil-regexp-search t)
(global-set-key [f7] 'evil-mode)
(evil-mode 1)
;; (setq case-fold-search nil)
;; (setq evil-ex-search-case 'sensitive)

(global-set-key [f9] 'ispell-word)
(global-set-key [f10] 'flyspell-mode)

(setq-default tab-width 8)
(setq-default c-tab-always-indent t)


;; Enter flyspell mode automatically
(setq-default flyspell-mode t)


;; Hide the welcome screen and startup message
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)


(add-hook 'emacs-list-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'turn-on-font-lock)

(defun vi-open-line-above ()
  "Insert a newline above the current line and restore the point"
  (interactive)
  (save-excursion
    (unless (bolp)
      (beginning-of-line))
    (newline)
    (forward-line -1)
    (indent-according-to-mode)))

(defun vi-open-line-below ()
  "Insert a newline below the current line and restore the point"
  (interactive)
  (save-excursion 
    (unless (eolp)
      (end-of-line))
    (newline-and-indent)))

(defun kill-current-line (&optional n)
  "Delete the current line"
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (let ((kill-whole-line t))
      (kill-line n))))

(defun kill-to-char (ch)
  "Kill up to and including first occurrence of ch.
Case-sensitive, Goes backward if ARG is negative; error if ch not
found."
  (interactive "cCharacter: ")
  (let ((case-fold-search nil))  
    (zap-to-char 1 ch)
    (indent-for-tab-command)))

(defun kill-to-pre-char (ch)
  "Kill up to and including first previous occurrence of ch.
Case-sensitive."
  (interactive "cPrevious Character: ")
  (let ((case-fold-search nil))
    (zap-to-char -1 ch)))

(defun vi-join-line ()
  (interactive)
  (save-excursion
    (forward-line 1)
    (join-line)))

(defun vi-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-end-position arg))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(defun vi-remove-to-begin ()
  "Remove from begin of line to current point"
  (interactive)
  (let ((beg (line-beginning-position))
	(end (point)))
    (kill-region beg end)))

(defun vi-paste-line ()
  "Paste lines in newline"
  (interactive)
  (end-of-line)
  (newline)
  (yank))


(defun vi-remove-range(string)
  "Remove lines from start to end, if start > end, switch the two values."
  (interactive "sRemove lines region: ")
  (save-excursion
    (let* ((list (split-string string "," t))
           (start (string-to-number (nth 0 list)))
           (end (string-to-number (nth 1 list))))
      (if (> start end)
          (progn
            (setq tmp start)
            (setq start end)
            (setq end tmp)))
      (goto-line start)
      (setq BEG (point))
      (goto-line end)
      (setq END (line-end-position))
      (kill-region BEG END)
      (setq lines (+ (- end start) 1))
      (message "%d line%s removed" lines (if (= 1 lines) "" "s")))))

(defun vi-yank-range(string)
  "Yank lines from start to end, if start > end, switch the two values."
  (interactive "sYank lines region: ")
  (save-excursion
    (let* ((list (split-string string "," t))
           (start (string-to-number (nth 0 list)))
           (end (string-to-number (nth 1 list))))
      (if (> start end)
          (progn
            (setq tmp start)
            (setq start end)
            (setq end tmp)))
      (goto-line start)
      (setq BEG (point))
      (goto-line end)
      (setq END (line-end-position))
      (kill-ring-save BEG END)
      (setq lines (+ (- end start) 1))
      (message "%d line%s copied" lines (if (= 1 lines) "" "s")))))


(defun vi-remove-to-end-of-buffer ()
  "Remove from current line to the end of buffer"
  (interactive)
  (let ((beg (line-beginning-position))
        (end (point-max)))
    (kill-region beg end)))

(defun vi-remove-to-begin-of-buffer ()
  "Remove from begin of buffer to current line"
  (interactive)
  (let ((beg (point-min))
        (end (line-end-position)))
    (kill-region beg end)))

;; Move to dipalyed line functions
(defun move-to-window-bottom ()
  (interactive)
  (move-to-window-line -1))

(defun move-to-window-top ()
  (interactive)
  (move-to-window-line 0))

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun move-to-window-middle ()
  (interactive)
  (move-to-window-line (window-half-height)))


(defun vi-move-to-char(ch)
  "Move to the certain character"
  (interactive "cchar: ")
  (setq savep (point))
  (forward-char) ;; Don't include the starting position
  (while (and (not (eq (point) (line-end-position)))
	      (not (eq ch (char-after))))
    (forward-char))
  (if (eq (point) (line-end-position))
      (progn
	(goto-char savep)
	(message "can't find the character!"))))
    
(defun vi-move-to-previous-char(ch)
  "Move to the previous certain character"
  (interactive "cchar: ")
  (setq savep (point))
  (backward-char) ;; Don't include the starting position
  (while (and (not (eq (point) (line-beginning-position)))
	      (not (eq ch (char-after))))
    (backward-char))
  (if (eq (point) (line-beginning-position))
      (progn
	(goto-char savep)
	(message "can't find the character!"))))

(global-set-key "\C-\M-o" 'vi-open-line-above)
(global-set-key "\C-o" 'vi-open-line-below)
(global-set-key (kbd "\e\ed0") 'vi-remove-to-begin)
(global-set-key (kbd "\e\eD") 'kill-line)
(global-set-key (kbd "\e\edG") 'vi-remove-to-end-of-buffer)
(global-set-key (kbd "\e\edg") 'vi-remove-to-begin-of-buffer)
(global-set-key (kbd "\e\edd") 'kill-current-line)
(global-set-key (kbd "\e\edf") 'kill-to-char)
(global-set-key (kbd "\e\edt") 'kill-to-pre-char)
;; (global-set-key (kbd "\e\ej") 'vi-join-line)
(global-unset-key "\C-x\C-j")
(global-set-key "\C-x\C-j" 'vi-join-line)
(global-set-key (kbd "\e\eyy") 'vi-copy-line)
(global-set-key (kbd "\e\ery") 'vi-yank-range)
(global-set-key (kbd "\e\erd") 'vi-remove-range)
(global-set-key (kbd "\e\ep") 'vi-paste-line)
(global-set-key (kbd "\e\eg") 'goto-line)
(global-set-key (kbd "\e\e.") 'repeat)
;;(global-set-key "\C-cm" 'point-to-register)
(global-set-key (kbd "\e\em") 'bookmark-set)
;;(global-set-key "\C-c`" 'jump-to-register)
(global-set-key (kbd "\e\e`") 'bookmark-jump)
(global-set-key (kbd "\e\eH") 'move-to-window-top)
(global-set-key (kbd "\e\eL") 'move-to-window-bottom)
(global-set-key (kbd "\e\eM") 'move-to-window-middle)
(global-set-key (kbd "\e\ef") 'vi-move-to-char)
(global-set-key (kbd "\e\et") 'vi-move-to-previous-char)
(global-set-key (kbd "\e\e!") 'shell-command)



(load-theme 'tsdh-dark t)

;; Move to beginning or end of buffer (Mac OS X)
(global-set-key (kbd "\C-c <up>") 'beginning-of-buffer)
(global-set-key (kbd "\C-c <down>") 'end-of-buffer)
(global-set-key (kbd "\C-c <left>") 'move-beginning-of-line)
(global-set-key (kbd "\C-c <right>") 'move-end-of-line)

;; Markdown
(setq markdown-command "multimarkdown")

;; Copy from stack-overflow -- Full-line completion
(defun vi-full-line-completion()
  (interactive)
  (let ((hippie-expand-try-functions-list
         '(try-expand-line)))
    (call-interactively 'hippie-expand)))

(global-set-key "\C-x\C-l" 'vi-full-line-completion)


;; Using firefox for flymd-flyit
(defun my-flymd-browser-function (url)
  (let ((process-environment (browse-url-process-environment)))
    (apply 'start-process
           (concat "firefox " url)
           nil
           "/usr/bin/open"
           (list "-a" "firefox" url))))
(setq flymd-browser-open-function 'my-flymd-browser-function)

(defun vi-yank-to-begin ()
  "Yank from begin of line to current point"
  (interactive)
  (let ((beg (line-beginning-position))
	(end (point)))
    (kill-ring-save beg end)))

(defun vi-yank-to-end ()
  "Yank from begin of line to current point"
  (interactive)
  (let ((beg (point))
	(end (line-end-position)))
    (kill-ring-save beg end)))

(global-set-key (kbd "\e\ey0") 'vi-yank-to-begin)
(global-set-key (kbd "\e\ey$") 'vi-yank-to-end)

(setq default-abbrev-mode t)

(global-set-key [f12] 'linum-mode)
(defun disable-linum-mode()
    (linum-mode 0))
(add-hook 'shell-mode-hook 'disable-linum-mode)

(global-unset-key [f11])
(global-set-key [f11] 'auto-complete-mode)

;; initial window
(setq initial-frame-alist
      '(
        (width . 102) ; character
        (height . 54) ; lines
        ))

;; default/sebsequent window
(setq default-frame-alist
      '(
        (width . 100) ; character
        (height . 52) ; lines
        ))

;; (tool-bar-mode -1)
(menu-bar-mode -1)

(require 'org)

;; make org mode allow eval of soma langs
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)))
   
;; Change from 'normal' to 'emacs' using 'i' 
;; (define-key evil-normal-state-map "i" 'evil-emacs-state)
;; (define-key evil-normal-state-map "\C-c\C-i" 'evil-insert-state)
;; (define-key evil-emacs-state-map "\C-i" 'evil-normal-state)
;; (setq evil-default-state 'emacs)


(defun untabify-whole()
  (interactive)
  (save-excursion
    (untabify (point-min) (point-max))))
(global-set-key "\C-x\C-h" 'untabify-whole)

(require 'org)
(setq org-startup-indented t)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/.emacs.d/org/work.org"
			     "~/.emacs.d/org/life.org"
			     "~/.emacs.d/org/home.org"))


;; (set-face-attribute 'default (selected-frame) :height 150)

(require 'dired)
(define-key dired-mode-map "c" 'find-file)

(global-set-key (kbd "\C-xI") 'insert-buffer)
(global-unset-key (kbd "\C-xz"))
(global-set-key (kbd "\C-xzz") 'kill-emacs)

;; (desktop-save-mode 1)

(defun my-bind-clb ()
  (define-key c-mode-base-map "\C-m"
    'c-context-line-break))
(add-hook 'c-initialization-hook 'my-bind-clb)

(defun scroll-up-one () "Scroll up 1 line." (interactive)
       (scroll-up (prefix-numeric-value current-prefix-arg)))
(defun scroll-down-one () "Scroll down 1 line." (interactive)
       (scroll-down (prefix-numeric-value current-prefix-arg)))

(global-unset-key "\C-x\C-l")
(global-set-key "\C-x\C-l" 'recenter-top-bottom)
(global-unset-key "\C-l")
(global-set-key "\C-l" 'scroll-up-one)
(global-unset-key "\M-l")
(global-set-key "\M-l" 'scroll-down-one)

(global-unset-key "\C-x;")
(global-set-key "\C-x/" 'comment-set-column)

;;;;;;

(defun my-comment-line ()
  "comment the current line"
  (interactive)
  (let ((beg (line-beginning-position))
        (end (line-end-position)))
    (comment-region beg end))
  (next-line)
  (move-beginning-of-line))

(defun my-uncomment-line ()
  "uncomment the current line"
  (interactive)
  (let ((beg (line-beginning-position))
        (end (line-end-position)))
    (uncomment-region beg end))
  (next-line)
  (move-beginning-of-line))

(global-unset-key "\C-x\C-m")
(global-unset-key "\C-x\M-m")
(global-set-key "\C-x\C-m" 'my-comment-line)
(global-set-key "\C-x\M-m" 'my-uncomment-line)

;; (add-to-list 'load-path "~/.emacs.d/git")
;; (require 'git)
;; (require 'git-blame)
