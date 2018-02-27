;;; packages.el --- crystal layer packages file for Spacemacs.
;;
;; Copyright (C) 2017 Brantou
;;
;; Author: Brantou <brantou89@gmail.com>
;; URL: https://github.com/brantou/spacemacs-crystal-layer
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst crystal-packages
  '(
    company
    flycheck
    (flycheck-crystal :toggle (configuration-layer/package-usedp 'flycheck))
    crystal-mode
    play-crystal
    inf-crystal
    ob-crystal
    ))

(defun crystal/post-init-company()
  (spacemacs|add-company-hook crystal-mode))

(defun crystal/post-init-flycheck()
  (spacemacs/add-flycheck-hook 'crystal-mode))

(defun crystal/init-flycheck-crystal ()
  (use-package flycheck-crystal
    :init (add-hook 'crystal-mode-hook 'flycheck-mode)))

(defun crystal/init-crystal-mode()
  (use-package crystal-mode
    :defer t
    :config
    (progn
      (add-hook 'crystal-mode-hook
                (lambda () (add-hook 'before-save-hook 'crystal-tool-format nil 'local)))

      (defun spacemacs/crystal-run-main ()
        (interactive)
        (let ((default-directory (crystal-find-project-root)))
          (shell-command
           (format "crystal run %s"
                   (shell-quote-argument (buffer-file-name))))))

      (spacemacs/declare-prefix-for-mode 'crystal-mode "mg" "goto")
      (spacemacs/declare-prefix-for-mode 'crystal-mode "mt" "test")
      (spacemacs/declare-prefix-for-mode 'crystal-mode "mu" "tool")
      (spacemacs/declare-prefix-for-mode 'crystal-mode "mx" "execute")
      (spacemacs/set-leader-keys-for-major-mode 'crystal-mode
        "ga" 'crystal-spec-switch
        "xx" 'spacemacs/crystal-run-main
        "tb" 'crystal-spec-buffer
        "tp" 'crystal-spec-all
        "uc" 'crystal-tool-context
        "ue" 'crystal-tool-expand
        "uf" 'crystal-tool-format
        "ui" 'crystal-tool-imp))))

(defun crystal/init-play-crystal()
  (use-package play-crystal
    :defer t
    :config
    (progn
      (spacemacs/declare-prefix-for-mode 'crystal-mode "me" "play")
      (spacemacs/set-leader-keys-for-major-mode 'crystal-mode
        "eb" 'play-crystal-submit-buffer
        "er" 'play-crystal-submit-region
        "ee" 'play-crystal-browse
        "ei" 'play-crystal-insert))))

(defun crystal/init-inf-crystal()
  (use-package inf-crystal
    :init
    (progn
      (spacemacs/register-repl 'inf-crystal 'inf-crystal "inf-crystal")
      (add-hook 'crystal-mode-hook 'inf-crystal-minor-mode))
    :config
    (progn
      (spacemacs/declare-prefix-for-mode 'crystal-mode "ms" "repl")
      (spacemacs/set-leader-keys-for-major-mode 'crystal-mode
        "'" 'inf-crystal
        "sb" 'crystal-send-buffer
        "sB" 'crystal-send-buffer-and-go
        "sf" 'crystal-send-definition
        "sF" 'crystal-send-definition-and-go
        "si" 'inf-crystal
        "sr" 'crystal-send-region
        "sR" 'crystal-send-region-and-go
        "ss" 'crystal-switch-to-inf))))

(defun crystal/pre-init-ob-crystal ()
  (spacemacs|use-package-add-hook org
    :post-config
    (use-package ob-crystal
      :init (add-to-list 'org-babel-load-languages '(crystal . t)))))
(defun crystal/init-ob-crystal ())

;;; packages.el ends here
