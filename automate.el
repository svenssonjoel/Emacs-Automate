;; automate.el --- Automate tasks

;; Copyright (C) 2018 
;; Author: Joel Svensson <svenssonjoel@yahoo.se> 

;; This file is part of Emacs-Automate.

;; Emacs-Automate is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; Emacs-Automate is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Emacs-Automate.  If not, see <https://www.gnu.org/licenses/>.

(require 'cl)


;; ------------------------------------------------------------
;; Structs

(cl-defstruct automate-machine-info
  name        ;; Name of the machine
  description ;;
  ip          ;;
  arch)       ;; Architecture descriptions

(cl-defstruct automate-job-info
  name           ;; Name of the job
  machine-filter ;; Filter for deciding what machine to use (Arch . x86) (Arch . ARM) (Name . "name") etc
  periodic       ;; 'Hourly, 'Daily, 'Weekly, etc
  command        ;; Task to perform
  status)        ;; 'Waiting, 'Running, 'Finished-success, 'Finished-failure
  
  
;; ------------------------------------------------------------
;; State

(defvar automate-machines-list      '())
(defvar automate-machines-idle-list '())
(defvar automate-machines-busy-list '())

(defvar automate-jobs-list '())

(defvar automate-login "automate") ;; username used by automate when loging into remote machine
                                   ;; Set this in .emacs file?


;; ------------------------------------------------------------
;; CODE

(defun automate-machine-info-string (machine-info)
  "Convert an automate-machine-info object to a string"
  (format "Name: %s\nDesc: %s\nIP: %s\nArch: %s\n"
	  (automate-machine-info-name machine-info)
	  (automate-machine-info-description machine-info)
	  (automate-machine-info-ip machine-info)
	  (automate-machine-info-arch machine-info)))

;; ------------------------------------------------------------
;; Interface
