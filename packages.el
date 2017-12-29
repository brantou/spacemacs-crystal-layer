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
    (play-crystal :location (recipe :fetcher github :repo "veelenga/play-crystal.el"))
    ))

(defun crystal/post-init-company()
  (spacemacs|add-company-backends
    :backends company-capf
    :modes crystal-mode
    :variables company-tooltip-align-annotations t))

(defun crystal/post-init-flycheck()
  (spacemacs/enable-flycheck 'crystal-mode))

(defun crystal/init-flycheck-crystal ()
  (use-package flycheck-crystal
    :init (add-hook 'crystal-mode-hook 'flycheck-mode)))

(defun crystal/init-crystal-mode()
  (use-package crystal-mode
    :defer t
    :config
    (progn
      (add-hook 'before-save-hook 'crystal-tool-format)

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
    :config
    (progn
      (spacemacs/declare-prefix-for-mode 'crystal-mode "me" "play")
      (spacemacs/set-leader-keys-for-major-mode 'crystal-mode
        "eb" 'play-crystal-submit-buffer
        "er" 'play-crystal-submit-region
        "ee" 'play-crystal-browse
        "ei" 'play-crystal-insert))))

;;; packages.el ends here
