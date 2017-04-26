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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compile-command "make ")
 '(package-selected-packages (quote (flymd markdown-mode evil auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default")))))

(show-paren-mode)
(setq show-paren-delay 0)

(ac-config-default)

(setq-default file-column 78)

(setq column-number-mode t)
(setq line-number-mode t)
(global-set-key "\C-xp" 'picture-mode)
(global-set-key "\C-ci" 'string-insert-rectangle)
(global-set-key "\C-xt" 'visit-tags-table)
(global-set-key [f8] 'compile)

(add-hook 'c-mode-hook
	  '(lambda ( )
	     (c-set-style "linux")))

(global-linum-mode t)
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

(setq evil-shift-width 8)
;; Load Evil
(require 'evil)
(setq evil-auto-indent t)
(setq evil-repeat-move-cursor t)
(setq evil-regexp-search t)


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
    (delete-indentation)))

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
(global-set-key (kbd "\e\ej") 'vi-join-line)
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

(abbrev-mode t)

(global-set-key [f12] 'linum-mode)
