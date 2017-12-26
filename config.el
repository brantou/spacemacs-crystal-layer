;;; config.el --- Go Layer config File for Spacemacs
;;
;; Copyright (C) 2017 Brantou
;;
;; Author: Brantou <brantou89@gmail.com>
;; URL: https://github.com/brantou/spacemacs-crystal-layer
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; variables

(spacemacs|defvar-company-backends crystal-mode)

(spacemacs|define-jump-handlers crystal-mode crystal-def-jump)
