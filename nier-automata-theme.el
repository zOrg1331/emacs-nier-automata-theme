;;; nier-automata-theme.el --- An Emacs color theme inspired by Nier Automata
;;; video game interface.

;; Author: Pavel Nakonechnyi <zorg1331@gmail.com>
;; URL: https://github.com/zOrg1331/emacs-nier-automata-theme

;;; Credits:

;; Bozhidar Batsov for his Zenburn theme which I have been using for years and
;; which I used as a template for this theme :-)

;; https://github.com/shelune/vscode-nier-automata-light/ and
;; https://github.com/Darius-Stone/vscode-nier-automata-tweaked/ as an example
;; of how such color scheme can look like.

;; https://github.com/merrittlj/automata-theme/ for initial inspiration

;;;; Note on colors:

;; They are not exactly the same as in Nier's interface. See merrittlj's repo
;; for more or less identical colors. Personally, they look too dull in text
;; editor. Inside the game you have this additional black net over the
;; background which makes things easier for eyes. Here I tried to make
;; comfortable colors, which follow the orginal pattern.

(deftheme nier-automata
  "Nier Automata inspired theme")

(defgroup nier-automata-theme nil
  "Nier Automata theme."
  :group 'faces
  :prefix "nier-automata-"
  :link '(url-link :tag "GitHub" "https://github.com/zOrg1331/emacs-nier-automata-theme")
  :tag "Nier Automata theme")

;;;###autoload
(defcustom nier-automata-override-colors-alist '()
  "Place to override default theme colors.

You can override a subset of the theme's default colors by
defining them in this alist."
  :group 'nier-automata-theme
  :type '(alist
          :key-type (string :tag "Name")
          :value-type (string :tag " Hex")))

(defvar nier-automata-use-variable-pitch nil
  "When non-nil, use variable pitch face for some headings and titles.")

(defvar nier-automata-scale-org-headlines nil
  "Whether `org-mode' headlines should be scaled.")

(defvar nier-automata-scale-outline-headlines nil
  "Whether `outline-mode' headlines should be scaled.")

(defcustom nier-automata-height-minus-1 0.8
  "Font size -1."
  :type 'number
  :group 'nier-automata-theme
  :package-version '(nier-automata . "2.6"))

(defcustom nier-automata-height-plus-1 1.1
  "Font size +1."
  :type 'number
  :group 'nier-automata-theme
  :package-version '(nier-automata . "2.6"))

(defcustom nier-automata-height-plus-2 1.15
  "Font size +2."
  :type 'number
  :group 'nier-automata-theme
  :package-version '(nier-automata . "2.6"))

(defcustom nier-automata-height-plus-3 1.2
  "Font size +3."
  :type 'number
  :group 'nier-automata-theme
  :package-version '(nier-automata . "2.6"))

(defcustom nier-automata-height-plus-4 1.3
  "Font size +4."
  :type 'number
  :group 'nier-automata-theme
  :package-version '(nier-automata . "2.6"))

;;; Color Palette

(defvar nier-automata-default-colors-alist
  '(("nier-fg-1"     . "#423f37")
    ("nier-fg-05"    . "#46443c")
    ("nier-fg"       . "#4A473E") ;;
    ("nier-fg+1"     . "#5c5951")
    ("nier-fg+2"     . "#6e6b64")
    ("nier-bg-2"     . "#b7b196")
    ("nier-bg-1"     . "#cec7a9")
    ("nier-bg-08"    . "#dbd1a4")
    ("nier-bg-05"    . "#ded5a9")
    ("nier-bg"       . "#E5DEBC") ;;
    ("nier-bg+05"    . "#e7e0c0")
    ("nier-bg+1"     . "#e7e1c2")
    ("nier-bg+2"     . "#eae4c9")
    ("nier-bg+3"     . "#ece7d0")
    ("nier-red-6"    . "#4a201a")
    ("nier-red-5"    . "#5d2821")
    ("nier-red-4"    . "#6f3028")
    ("nier-red-3"    . "#82382e")
    ("nier-red-2"    . "#944035")
    ("nier-red-1"    . "#a7483c")
    ("nier-red"      . "#ba5143") ;;
    ("nier-red+1"    . "#c06255")
    ("nier-red+2"    . "#c77368")
    ("nier-orange"   . "#e26252")
    ("nier-yellow-2" . "#775a2a")
    ("nier-yellow-1" . "#86652f")
    ("nier-yellow"   . "#957135") ;;
    ("nier-green-5"  . "#1a401c")
    ("nier-green-4"  . "#1f4d21")
    ("nier-green-3"  . "#255a27")
    ("nier-green-2"  . "#2a672c")
    ("nier-green-1"  . "#2f7432")
    ("nier-green"    . "#358138") ;;
    ("nier-green+1"  . "#498d4b")
    ("nier-green+2"  . "#5d9a5f")
    ("nier-green+3"  . "#71a673")
    ("nier-green+4"  . "#85b387")
    ("nier-cyan"     . "#a1d0c5")
    ("nier-blue+3"   . "#857bce")
    ("nier-blue+2"   . "#7368c7")
    ("nier-blue+1"   . "#6255c0")
    ("nier-blue"     . "#5143ba") ;;
    ("nier-blue-1"   . "#483ca7")
    ("nier-blue-2"   . "#403594")
    ("nier-blue-3"   . "#382e82")
    ("nier-blue-4"   . "#30286f")
    ("nier-blue-5"   . "#28215d")
    ("nier-purple+1" . "#1985bb")
    ("nier-purple"   . "#0078B4")
    ("nier-black"    . "#3e3b35")
    ("nier-white"    . "#dad6d2")
    ("powerline-act1"   . "#6c6b62")
    ("powerline-act2"   . "#67665d")
    ("powerline-inact1" . "#867a63")
    ("powerline-inact2" . "#8b7f68")
    )
  "List of Nier Automata colors.
Each element has the form (NAME . HEX).

`+N' suffixes indicate a color is lighter.
`-N' suffixes indicate a color is darker.")

(defmacro nier-automata-with-color-variables (&rest body)
  "`let' bind all colors defined in `nier-automata-colors-alist'
around BODY.
Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   (append nier-automata-default-colors-alist
                           nier-automata-override-colors-alist))
         (z-variable-pitch (if nier-automata-use-variable-pitch
                               'variable-pitch 'default)))
     ,@body))

;;; Theme Faces
(nier-automata-with-color-variables
  (custom-theme-set-faces
   'nier-automata

;;;; Built-in packages

;;;;; basic coloring
   '(button ((t (:underline t))))
   `(link ((t (:foreground ,nier-yellow :underline t :weight bold))))
   `(link-visited ((t (:foreground ,nier-yellow-2 :underline t :weight normal))))
   `(default ((t (:foreground ,nier-fg :background ,nier-bg))))
   `(cursor ((t (:foreground ,nier-fg :background ,nier-fg+1))))
   `(widget-field ((t (:foreground ,nier-fg :background ,nier-bg+3))))
   `(escape-glyph ((t (:foreground ,nier-yellow :weight bold))))
   `(fringe ((t (:foreground ,nier-fg :background ,nier-bg+1))))
   `(header-line ((t (:foreground ,nier-yellow
                                  :background ,nier-bg-1
                                  :box (:line-width -1 :style released-button)
                                  :extend t))))
   `(highlight ((t (:background ,nier-bg-05))))
   `(success ((t (:foreground ,nier-green :weight bold))))
   `(warning ((t (:foreground ,nier-orange :weight bold))))
   `(tooltip ((t (:foreground ,nier-fg :background ,nier-bg+1))))
;;;;; ansi-colors
   `(ansi-color-black ((t (:foreground ,nier-bg
                                       :background ,nier-bg-1))))
   `(ansi-color-red ((t (:foreground ,nier-red-2
                                     :background ,nier-red-4))))
   `(ansi-color-green ((t (:foreground ,nier-green
                                       :background ,nier-green+2))))
   `(ansi-color-yellow ((t (:foreground ,nier-yellow
                                        :background ,nier-yellow))))
   `(ansi-color-blue ((t (:foreground ,nier-blue-1
                                      :background ,nier-blue-4))))
   `(ansi-color-magenta ((t (:foreground ,nier-purple
                                         :background ,nier-red))))
   `(ansi-color-cyan ((t (:foreground ,nier-cyan
                                      :background ,nier-blue))))
   `(ansi-color-white ((t (:foreground ,nier-fg
                                       :background ,nier-fg-1))))
;;;;; compilation
   `(compilation-column-face ((t (:foreground ,nier-yellow))))
   `(compilation-enter-directory-face ((t (:foreground ,nier-green))))
   `(compilation-error-face ((t (:foreground ,nier-red-1 :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,nier-fg))))
   `(compilation-info-face ((t (:foreground ,nier-blue))))
   `(compilation-info ((t (:foreground ,nier-green+4 :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,nier-green))))
   `(compilation-line-face ((t (:foreground ,nier-yellow))))
   `(compilation-line-number ((t (:foreground ,nier-yellow))))
   `(compilation-message-face ((t (:foreground ,nier-blue))))
   `(compilation-warning-face ((t (:foreground ,nier-orange :weight bold :underline t))))
   `(compilation-mode-line-exit ((t (:foreground ,nier-green+2 :weight bold))))
   `(compilation-mode-line-fail ((t (:foreground ,nier-red :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,nier-yellow :weight bold))))
;;;;; completions
   `(completions-annotations ((t (:foreground ,nier-fg-1))))
   `(completions-common-part ((t (:foreground ,nier-blue))))
   `(completions-first-difference ((t (:foreground ,nier-fg+1))))
;;;;; customize
   `(custom-variable-tag ((t (:foreground ,nier-blue :weight bold))))
   `(custom-group-tag ((t (:foreground ,nier-blue :weight bold :height 1.2))))
   `(custom-state ((t (:foreground ,nier-green+4))))
;;;;; display-fill-column-indicator
   `(fill-column-indicator ((,class :foreground ,nier-bg-05 :weight semilight)))
;;;;; eww
   '(eww-invalid-certificate ((t (:inherit error))))
   '(eww-valid-certificate   ((t (:inherit success))))
;;;;; grep
   `(grep-context-face ((t (:foreground ,nier-fg))))
   `(grep-error-face ((t (:foreground ,nier-red-1 :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,nier-blue))))
   `(grep-match-face ((t (:foreground ,nier-orange :weight bold))))
   `(match ((t (:background ,nier-bg-1 :foreground ,nier-orange :weight bold))))
;;;;; hi-lock
   `(hi-blue    ((t (:background ,nier-blue    :foreground ,nier-bg-1))))
   `(hi-green   ((t (:background ,nier-green+4 :foreground ,nier-bg-1))))
   `(hi-pink    ((t (:background ,nier-purple :foreground ,nier-bg-1))))
   `(hi-yellow  ((t (:background ,nier-yellow  :foreground ,nier-bg-1))))
   `(hi-blue-b  ((t (:foreground ,nier-blue    :weight     bold))))
   `(hi-green-b ((t (:foreground ,nier-green+2 :weight     bold))))
   `(hi-red-b   ((t (:foreground ,nier-red     :weight     bold))))
;;;;; info
   `(Info-quoted ((t (:inherit font-lock-constant-face))))
;;;;; isearch
   `(isearch ((t (:foreground ,nier-yellow-2 :weight bold :background ,nier-bg+2))))
   `(isearch-fail ((t (:foreground ,nier-red-2 :background ,nier-bg+2))))
   `(lazy-highlight ((t (:foreground ,nier-yellow-2 :weight bold :background ,nier-bg-05))))

   `(menu ((t (:foreground ,nier-fg :background ,nier-bg))))
   `(minibuffer-prompt ((t (:foreground ,nier-yellow))))
   `(mode-line
     ((,class (:foreground ,nier-white
                           :background ,powerline-act1
                           :box (:line-width -1 :style released-button)))
      (t :inverse-video t)))
   `(mode-line-buffer-id ((t (:foreground ,nier-bg+1 :weight bold))))
   `(mode-line-inactive
     ((t (:foreground ,nier-white
                      :background ,powerline-inact1
                      :box (:line-width -1 :style released-button)))))
   `(region ((,class (:background ,nier-bg-1 :extend t))
             (t :inverse-video t)))
   `(secondary-selection ((t (:background ,nier-bg+2))))
   `(trailing-whitespace ((t (:background ,nier-red))))
   `(vertical-border ((t (:foreground ,nier-fg))))
;;;;; font lock
   `(font-lock-builtin-face ((t (:foreground ,nier-fg :weight bold))))
   `(font-lock-comment-face ((t (:foreground ,nier-green))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,nier-green-2))))
   `(font-lock-constant-face ((t (:foreground ,nier-black))))
   `(font-lock-doc-face ((t (:foreground ,nier-green+2))))
   `(font-lock-function-name-face ((t (:foreground ,nier-blue-3))))
   `(font-lock-keyword-face ((t (:foreground ,nier-purple :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,nier-yellow :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,nier-purple+1))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,nier-yellow :weight bold))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,nier-green :weight bold))))
   `(font-lock-string-face ((t (:foreground ,nier-red))))
   `(font-lock-type-face ((t (:foreground ,nier-blue-1))))
   `(font-lock-variable-name-face ((t (:foreground ,nier-black))))
   `(font-lock-warning-face ((t (:foreground ,nier-yellow-2 :weight bold))))

   `(c-annotation-face ((t (:inherit font-lock-constant-face))))
;;;;; line numbers (Emacs 26.1 and above)
   `(line-number ((t (:inherit default :foreground ,nier-bg+3 :background ,nier-bg-05))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,nier-yellow-2))))
;;;;; man
   '(Man-overstrike ((t (:inherit font-lock-keyword-face))))
   '(Man-underline  ((t (:inherit (font-lock-string-face underline)))))
;;;;; newsticker
   `(newsticker-date-face ((t (:foreground ,nier-fg))))
   `(newsticker-default-face ((t (:foreground ,nier-fg))))
   `(newsticker-enclosure-face ((t (:foreground ,nier-green+3))))
   `(newsticker-extra-face ((t (:foreground ,nier-bg+2 :height 0.8))))
   `(newsticker-feed-face ((t (:foreground ,nier-fg))))
   `(newsticker-immortal-item-face ((t (:foreground ,nier-green))))
   `(newsticker-new-item-face ((t (:foreground ,nier-blue))))
   `(newsticker-obsolete-item-face ((t (:foreground ,nier-red))))
   `(newsticker-old-item-face ((t (:foreground ,nier-bg+3))))
   `(newsticker-statistics-face ((t (:foreground ,nier-fg))))
   `(newsticker-treeview-face ((t (:foreground ,nier-fg))))
   `(newsticker-treeview-immortal-face ((t (:foreground ,nier-green))))
   `(newsticker-treeview-listwindow-face ((t (:foreground ,nier-fg))))
   `(newsticker-treeview-new-face ((t (:foreground ,nier-blue :weight bold))))
   `(newsticker-treeview-obsolete-face ((t (:foreground ,nier-red))))
   `(newsticker-treeview-old-face ((t (:foreground ,nier-bg+3))))
   `(newsticker-treeview-selection-face ((t (:background ,nier-bg-1 :foreground ,nier-yellow))))
;;;;; woman
   '(woman-bold   ((t (:inherit font-lock-keyword-face))))
   '(woman-italic ((t (:inherit (font-lock-string-face italic)))))

;;;; Third-party packages

;;;;; ace-jump
   `(ace-jump-face-background
     ((t (:foreground ,nier-fg-1 :background ,nier-bg :inverse-video nil))))
   `(ace-jump-face-foreground
     ((t (:foreground ,nier-green+2 :background ,nier-bg :inverse-video nil))))
;;;;; ace-window
   `(aw-background-face
     ((t (:foreground ,nier-fg-1 :background ,nier-bg :inverse-video nil))))
   `(aw-leading-char-face ((t (:inherit aw-mode-line-face))))
;;;;; adoc-mode
   `(adoc-anchor-face ((t (:foreground ,nier-blue+1))))
   `(adoc-code-face ((t (:inherit font-lock-constant-face))))
   `(adoc-command-face ((t (:foreground ,nier-yellow))))
   `(adoc-emphasis-face ((t (:inherit bold))))
   `(adoc-internal-reference-face ((t (:foreground ,nier-yellow-2 :underline t))))
   `(adoc-list-face ((t (:foreground ,nier-fg+1))))
   `(adoc-meta-face ((t (:foreground ,nier-yellow))))
   `(adoc-meta-hide-face ((t (:foreground ,nier-yellow))))
   `(adoc-secondary-text-face ((t (:foreground ,nier-yellow-1))))
   `(adoc-title-0-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-title-1-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-title-2-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-title-3-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-title-4-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(adoc-typewriter-face ((t (:inherit font-lock-constant-face))))
   `(adoc-verbatim-face ((t (:inherit font-lock-constant-face))))
   `(adoc-value-face ((t (:foreground ,nier-yellow))))
;;;;; android mode
   `(android-mode-debug-face ((t (:foreground ,nier-green+1))))
   `(android-mode-error-face ((t (:foreground ,nier-orange :weight bold))))
   `(android-mode-info-face ((t (:foreground ,nier-fg))))
   `(android-mode-verbose-face ((t (:foreground ,nier-green))))
   `(android-mode-warning-face ((t (:foreground ,nier-yellow))))
;;;;; anzu
   `(anzu-mode-line ((t (:foreground ,nier-blue :weight bold))))
   `(anzu-mode-line-no-match ((t (:foreground ,nier-red :weight bold))))
   `(anzu-match-1 ((t (:foreground ,nier-bg :background ,nier-green))))
   `(anzu-match-2 ((t (:foreground ,nier-bg :background ,nier-orange))))
   `(anzu-match-3 ((t (:foreground ,nier-bg :background ,nier-blue))))
   `(anzu-replace-to ((t (:inherit anzu-replace-highlight :foreground ,nier-yellow))))
;;;;; auctex
   `(font-latex-bold-face ((t (:inherit bold))))
   `(font-latex-warning-face ((t (:foreground nil :inherit font-lock-warning-face))))
   `(font-latex-sectioning-5-face ((t (:foreground ,nier-red :weight bold ))))
   `(font-latex-sedate-face ((t (:foreground ,nier-yellow))))
   `(font-latex-italic-face ((t (:foreground ,nier-blue :slant italic))))
   `(font-latex-string-face ((t (:inherit ,font-lock-string-face))))
   `(font-latex-math-face ((t (:foreground ,nier-orange))))
   `(font-latex-script-char-face ((t (:foreground ,nier-orange))))
;;;;; agda-mode
   `(agda2-highlight-keyword-face ((t (:foreground ,nier-yellow :weight bold))))
   `(agda2-highlight-string-face ((t (:foreground ,nier-red))))
   `(agda2-highlight-symbol-face ((t (:foreground ,nier-orange))))
   `(agda2-highlight-primitive-type-face ((t (:foreground ,nier-blue-1))))
   `(agda2-highlight-inductive-constructor-face ((t (:foreground ,nier-fg))))
   `(agda2-highlight-coinductive-constructor-face ((t (:foreground ,nier-fg))))
   `(agda2-highlight-datatype-face ((t (:foreground ,nier-blue))))
   `(agda2-highlight-function-face ((t (:foreground ,nier-blue))))
   `(agda2-highlight-module-face ((t (:foreground ,nier-blue-1))))
   `(agda2-highlight-error-face ((t (:foreground ,nier-bg :background ,nier-purple))))
   `(agda2-highlight-unsolved-meta-face ((t (:foreground ,nier-bg :background ,nier-purple))))
   `(agda2-highlight-unsolved-constraint-face ((t (:foreground ,nier-bg :background ,nier-purple))))
   `(agda2-highlight-termination-problem-face ((t (:foreground ,nier-bg :background ,nier-purple))))
   `(agda2-highlight-incomplete-pattern-face ((t (:foreground ,nier-bg :background ,nier-purple))))
   `(agda2-highlight-typechecks-face ((t (:background ,nier-red-4))))
;;;;; auto-complete
   `(ac-candidate-face ((t (:background ,nier-bg+3 :foreground ,nier-bg-2))))
   `(ac-selection-face ((t (:background ,nier-blue-4 :foreground ,nier-fg))))
   `(popup-tip-face ((t (:background ,nier-yellow-2 :foreground ,nier-bg-2))))
   `(popup-menu-mouse-face ((t (:background ,nier-yellow-2 :foreground ,nier-bg-2))))
   `(popup-summary-face ((t (:background ,nier-bg+3 :foreground ,nier-bg-2))))
   `(popup-scroll-bar-foreground-face ((t (:background ,nier-blue-5))))
   `(popup-scroll-bar-background-face ((t (:background ,nier-bg-1))))
   `(popup-isearch-match ((t (:background ,nier-bg :foreground ,nier-fg))))
;;;;; avy
   `(avy-background-face
     ((t (:foreground ,nier-fg-1 :background ,nier-bg :inverse-video nil))))
   `(avy-lead-face-0
     ((t (:foreground ,nier-green+3 :background ,nier-bg :inverse-video nil :weight bold))))
   `(avy-lead-face-1
     ((t (:foreground ,nier-yellow :background ,nier-bg :inverse-video nil :weight bold))))
   `(avy-lead-face-2
     ((t (:foreground ,nier-red+1 :background ,nier-bg :inverse-video nil :weight bold))))
   `(avy-lead-face
     ((t (:foreground ,nier-blue :background ,nier-bg :inverse-video nil :weight bold))))
;;;;; company-mode
   `(company-tooltip ((t (:foreground ,nier-fg :background ,nier-bg+1))))
   `(company-tooltip-annotation ((t (:foreground ,nier-orange :background ,nier-bg+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,nier-orange :background ,nier-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,nier-fg :background ,nier-bg-1))))
   `(company-tooltip-mouse ((t (:background ,nier-bg-1))))
   `(company-tooltip-common ((t (:foreground ,nier-green+2))))
   `(company-tooltip-common-selection ((t (:foreground ,nier-green+2))))
   `(company-scrollbar-fg ((t (:background ,nier-bg-1))))
   `(company-scrollbar-bg ((t (:background ,nier-bg+2))))
   `(company-preview ((t (:background ,nier-green+2))))
   `(company-preview-common ((t (:foreground ,nier-green+2 :background ,nier-bg-1))))
;;;;; corfu
   `(corfu-default ((t (:foreground ,nier-fg :background ,nier-bg+1))))
   `(corfu-current ((t (:foreground ,nier-fg :background ,nier-bg-1))))
   `(corfu-bar ((t (:background ,nier-bg-1))))
   `(corfu-bar ((t (:background ,nier-bg-2))))
;;;;; bm
   `(bm-face ((t (:background ,nier-yellow-1 :foreground ,nier-bg))))
   `(bm-fringe-face ((t (:background ,nier-yellow-1 :foreground ,nier-bg))))
   `(bm-fringe-persistent-face ((t (:background ,nier-green-2 :foreground ,nier-bg))))
   `(bm-persistent-face ((t (:background ,nier-green-2 :foreground ,nier-bg))))
;;;;; calfw
   `(cfw:face-annotation ((t (:foreground ,nier-red :inherit cfw:face-day-title))))
   `(cfw:face-day-title ((t nil)))
   `(cfw:face-default-content ((t (:foreground ,nier-green))))
   `(cfw:face-default-day ((t (:weight bold))))
   `(cfw:face-disable ((t (:foreground ,nier-fg-1))))
   `(cfw:face-grid ((t (:inherit shadow))))
   `(cfw:face-header ((t (:inherit font-lock-keyword-face))))
   `(cfw:face-holiday ((t (:inherit cfw:face-sunday))))
   `(cfw:face-periods ((t (:foreground ,nier-blue))))
   `(cfw:face-saturday ((t (:foreground ,nier-blue :weight bold))))
   `(cfw:face-select ((t (:background ,nier-blue-5))))
   `(cfw:face-sunday ((t (:foreground ,nier-red :weight bold))))
   `(cfw:face-title ((t (:height 2.0 :inherit (variable-pitch font-lock-keyword-face)))))
   `(cfw:face-today ((t (:foreground ,nier-blue :weight bold))))
   `(cfw:face-today-title ((t (:inherit highlight bold))))
   `(cfw:face-toolbar ((t (:background ,nier-blue-5))))
   `(cfw:face-toolbar-button-off ((t (:underline nil :inherit link))))
   `(cfw:face-toolbar-button-on ((t (:underline nil :inherit link-visited))))
;;;;; centaur-tabs
   `(centaur-tabs-default ((t (:background ,nier-bg :foreground ,nier-fg :box nil))))
   `(centaur-tabs-selected ((t (:background ,nier-bg :foreground ,nier-fg+2 :box nil))))
   `(centaur-tabs-unselected ((t (:background ,nier-bg-1 :foreground ,nier-fg-05 :box nil))))
   `(centaur-tabs-selected-modified ((t (:background ,nier-bg :foreground ,nier-orange :box nil))))
   `(centaur-tabs-unselected-modified ((t (:background ,nier-bg-1 :foreground ,nier-orange :box nil))))
   `(centaur-tabs-active-bar-face ((t (:background ,nier-yellow :box nil))))
   `(centaur-tabs-modified-marker-selected ((t (:inherit 'centaur-tabs-selected-modified :foreground ,nier-yellow :box nil))))
   `(centaur-tabs-modified-marker-unselected ((t (:inherit 'centaur-tabs-unselected-modified :foreground ,nier-yellow :box nil))))
;;;;; cider
   `(cider-result-overlay-face ((t (:background unspecified))))
   `(cider-enlightened-face ((t (:box (:color ,nier-orange :line-width -1)))))
   `(cider-enlightened-local-face ((t (:weight bold :foreground ,nier-green+1))))
   `(cider-deprecated-face ((t (:background ,nier-yellow-2))))
   `(cider-instrumented-face ((t (:box (:color ,nier-red :line-width -1)))))
   `(cider-traced-face ((t (:box (:color ,nier-blue :line-width -1)))))
   `(cider-test-failure-face ((t (:background ,nier-red-4))))
   `(cider-test-error-face ((t (:background ,nier-purple))))
   `(cider-test-success-face ((t (:background ,nier-green-2))))
   `(cider-fringe-good-face ((t (:foreground ,nier-green+4))))
;;;;; circe
   `(circe-highlight-nick-face ((t (:foreground ,nier-blue))))
   `(circe-my-message-face ((t (:foreground ,nier-fg))))
   `(circe-fool-face ((t (:foreground ,nier-red+1))))
   `(circe-topic-diff-removed-face ((t (:foreground ,nier-red :weight bold))))
   `(circe-originator-face ((t (:foreground ,nier-fg))))
   `(circe-server-face ((t (:foreground ,nier-green))))
   `(circe-topic-diff-new-face ((t (:foreground ,nier-orange :weight bold))))
   `(circe-prompt-face ((t (:foreground ,nier-orange :background ,nier-bg :weight bold))))
;;;;; context-coloring
   `(context-coloring-level-0-face ((t :foreground ,nier-fg)))
   `(context-coloring-level-1-face ((t :foreground ,nier-blue)))
   `(context-coloring-level-2-face ((t :foreground ,nier-green+4)))
   `(context-coloring-level-3-face ((t :foreground ,nier-yellow)))
   `(context-coloring-level-4-face ((t :foreground ,nier-orange)))
   `(context-coloring-level-5-face ((t :foreground ,nier-purple)))
   `(context-coloring-level-6-face ((t :foreground ,nier-blue+1)))
   `(context-coloring-level-7-face ((t :foreground ,nier-green+2)))
   `(context-coloring-level-8-face ((t :foreground ,nier-yellow-2)))
   `(context-coloring-level-9-face ((t :foreground ,nier-red+1)))
;;;;; coq
   `(coq-solve-tactics-face ((t (:foreground nil :inherit font-lock-constant-face))))
;;;;; ctable
   `(ctbl:face-cell-select ((t (:background ,nier-blue :foreground ,nier-bg))))
   `(ctbl:face-continue-bar ((t (:background ,nier-bg-05 :foreground ,nier-bg))))
   `(ctbl:face-row-select ((t (:background ,nier-blue :foreground ,nier-bg))))
;;;;; debbugs
   `(debbugs-gnu-done ((t (:foreground ,nier-fg-1))))
   `(debbugs-gnu-handled ((t (:foreground ,nier-green))))
   `(debbugs-gnu-new ((t (:foreground ,nier-red))))
   `(debbugs-gnu-pending ((t (:foreground ,nier-blue))))
   `(debbugs-gnu-stale ((t (:foreground ,nier-orange))))
   `(debbugs-gnu-tagged ((t (:foreground ,nier-red))))
;;;;; diff
   ;; Please read (info "(magit)Theming Faces") before changing this.
   `(diff-added          ((t (:background "#335533" :foreground ,nier-green))))
   `(diff-changed        ((t (:background "#555511" :foreground ,nier-yellow-1))))
   `(diff-removed        ((t (:background "#553333" :foreground ,nier-red-2))))
   `(diff-refine-added   ((t (:background "#338833" :foreground ,nier-green+4))))
   `(diff-refine-changed ((t (:background "#888811" :foreground ,nier-yellow))))
   `(diff-refine-removed ((t (:background "#883333" :foreground ,nier-red))))
   `(diff-header ((,class (:background ,nier-bg+2))
                  (t (:background ,nier-fg :foreground ,nier-bg))))
   `(diff-file-header
     ((,class (:background ,nier-bg+2 :foreground ,nier-fg :weight bold))
      (t (:background ,nier-fg :foreground ,nier-bg :weight bold))))
;;;;; diff-hl
   `(diff-hl-change ((,class (:foreground ,nier-blue :background ,nier-blue-2))))
   `(diff-hl-delete ((,class (:foreground ,nier-red+1 :background ,nier-red-1))))
   `(diff-hl-insert ((,class (:foreground ,nier-green+1 :background ,nier-green-2))))
;;;;; dim-autoload
   `(dim-autoload-cookie-line ((t :foreground ,nier-bg+1)))
;;;;; dired+
   `(diredp-display-msg ((t (:foreground ,nier-blue))))
   `(diredp-compressed-file-suffix ((t (:foreground ,nier-orange))))
   `(diredp-date-time ((t (:foreground ,nier-purple))))
   `(diredp-deletion ((t (:foreground ,nier-yellow))))
   `(diredp-deletion-file-name ((t (:foreground ,nier-red))))
   `(diredp-dir-heading ((t (:foreground ,nier-blue :background ,nier-bg-1))))
   `(diredp-dir-priv ((t (:foreground ,nier-blue))))
   `(diredp-exec-priv ((t (:foreground ,nier-red))))
   `(diredp-executable-tag ((t (:foreground ,nier-green+1))))
   `(diredp-file-name ((t (:foreground ,nier-blue))))
   `(diredp-file-suffix ((t (:foreground ,nier-green))))
   `(diredp-flag-mark ((t (:foreground ,nier-yellow))))
   `(diredp-flag-mark-line ((t (:foreground ,nier-orange))))
   `(diredp-ignored-file-name ((t (:foreground ,nier-red))))
   `(diredp-link-priv ((t (:foreground ,nier-yellow))))
   `(diredp-mode-line-flagged ((t (:foreground ,nier-yellow))))
   `(diredp-mode-line-marked ((t (:foreground ,nier-orange))))
   `(diredp-no-priv ((t (:foreground ,nier-fg))))
   `(diredp-number ((t (:foreground ,nier-green+1))))
   `(diredp-other-priv ((t (:foreground ,nier-yellow-1))))
   `(diredp-rare-priv ((t (:foreground ,nier-red-1))))
   `(diredp-read-priv ((t (:foreground ,nier-green-2))))
   `(diredp-symlink ((t (:foreground ,nier-yellow))))
   `(diredp-write-priv ((t (:foreground ,nier-purple))))
;;;;; dired-async
   `(dired-async-failures ((t (:foreground ,nier-red :weight bold))))
   `(dired-async-message ((t (:foreground ,nier-yellow :weight bold))))
   `(dired-async-mode-message ((t (:foreground ,nier-yellow))))
;;;;; diredfl
   `(diredfl-compressed-file-suffix ((t (:foreground ,nier-orange))))
   `(diredfl-date-time ((t (:foreground ,nier-purple))))
   `(diredfl-deletion ((t (:foreground ,nier-yellow))))
   `(diredfl-deletion-file-name ((t (:foreground ,nier-red))))
   `(diredfl-dir-heading ((t (:foreground ,nier-blue :background ,nier-bg-1))))
   `(diredfl-dir-priv ((t (:foreground ,nier-blue))))
   `(diredfl-exec-priv ((t (:foreground ,nier-red))))
   `(diredfl-executable-tag ((t (:foreground ,nier-green+1))))
   `(diredfl-file-name ((t (:foreground ,nier-blue))))
   `(diredfl-file-suffix ((t (:foreground ,nier-green))))
   `(diredfl-flag-mark ((t (:foreground ,nier-yellow))))
   `(diredfl-flag-mark-line ((t (:foreground ,nier-orange))))
   `(diredfl-ignored-file-name ((t (:foreground ,nier-red))))
   `(diredfl-link-priv ((t (:foreground ,nier-yellow))))
   `(diredfl-no-priv ((t (:foreground ,nier-fg))))
   `(diredfl-number ((t (:foreground ,nier-green+1))))
   `(diredfl-other-priv ((t (:foreground ,nier-yellow-1))))
   `(diredfl-rare-priv ((t (:foreground ,nier-red-1))))
   `(diredfl-read-priv ((t (:foreground ,nier-green-1))))
   `(diredfl-symlink ((t (:foreground ,nier-yellow))))
   `(diredfl-write-priv ((t (:foreground ,nier-purple))))
;;;;; doom-modeline
   `(doom-modeline-bar  ((t (:background ,nier-yellow))))
   `(doom-modeline-inactive-bar  ((t (:background nil))))
;;;;; ediff
   `(ediff-current-diff-A ((t (:foreground ,nier-fg :background ,nier-red-4))))
   `(ediff-current-diff-Ancestor ((t (:foreground ,nier-fg :background ,nier-red-4))))
   `(ediff-current-diff-B ((t (:foreground ,nier-fg :background ,nier-green-2))))
   `(ediff-current-diff-C ((t (:foreground ,nier-fg :background ,nier-blue-5))))
   `(ediff-even-diff-A ((t (:background ,nier-bg+1))))
   `(ediff-even-diff-Ancestor ((t (:background ,nier-bg+1))))
   `(ediff-even-diff-B ((t (:background ,nier-bg+1))))
   `(ediff-even-diff-C ((t (:background ,nier-bg+1))))
   `(ediff-fine-diff-A ((t (:foreground ,nier-fg :background ,nier-red-2 :weight bold))))
   `(ediff-fine-diff-Ancestor ((t (:foreground ,nier-fg :background ,nier-red-2 weight bold))))
   `(ediff-fine-diff-B ((t (:foreground ,nier-fg :background ,nier-green :weight bold))))
   `(ediff-fine-diff-C ((t (:foreground ,nier-fg :background ,nier-blue-3 :weight bold ))))
   `(ediff-odd-diff-A ((t (:background ,nier-bg+2))))
   `(ediff-odd-diff-Ancestor ((t (:background ,nier-bg+2))))
   `(ediff-odd-diff-B ((t (:background ,nier-bg+2))))
   `(ediff-odd-diff-C ((t (:background ,nier-bg+2))))
;;;;; egg
   `(egg-text-base ((t (:foreground ,nier-fg))))
   `(egg-help-header-1 ((t (:foreground ,nier-yellow))))
   `(egg-help-header-2 ((t (:foreground ,nier-green+3))))
   `(egg-branch ((t (:foreground ,nier-yellow))))
   `(egg-branch-mono ((t (:foreground ,nier-yellow))))
   `(egg-term ((t (:foreground ,nier-yellow))))
   `(egg-diff-add ((t (:foreground ,nier-green+4))))
   `(egg-diff-del ((t (:foreground ,nier-red+1))))
   `(egg-diff-file-header ((t (:foreground ,nier-yellow-2))))
   `(egg-section-title ((t (:foreground ,nier-yellow))))
   `(egg-stash-mono ((t (:foreground ,nier-green+4))))
;;;;; elfeed
   `(elfeed-log-error-level-face ((t (:foreground ,nier-red))))
   `(elfeed-log-info-level-face ((t (:foreground ,nier-blue))))
   `(elfeed-log-warn-level-face ((t (:foreground ,nier-yellow))))
   `(elfeed-search-date-face ((t (:foreground ,nier-yellow-1 :underline t
                                              :weight bold))))
   `(elfeed-search-tag-face ((t (:foreground ,nier-green))))
   `(elfeed-search-feed-face ((t (:foreground ,nier-blue))))
   `(elfeed-search-title-face ((t (:foreground ,nier-fg-05))))
   `(elfeed-search-unread-title-face ((t (:foreground ,nier-fg :weight bold))))
;;;;; emacs-w3m
   `(w3m-anchor ((t (:foreground ,nier-yellow :underline t
                                 :weight bold))))
   `(w3m-arrived-anchor ((t (:foreground ,nier-yellow-2
                                         :underline t :weight normal))))
   `(w3m-form ((t (:foreground ,nier-red-1 :underline t))))
   `(w3m-header-line-location-title ((t (:foreground ,nier-yellow
                                                     :underline t :weight bold))))
   '(w3m-history-current-url ((t (:inherit match))))
   `(w3m-lnum ((t (:foreground ,nier-green+2 :background ,nier-bg))))
   `(w3m-lnum-match ((t (:background ,nier-bg-1
                                     :foreground ,nier-orange
                                     :weight bold))))
   `(w3m-lnum-minibuffer-prompt ((t (:foreground ,nier-yellow))))
;;;;; erc
   `(erc-action-face ((t (:inherit erc-default-face))))
   `(erc-bold-face ((t (:weight bold))))
   `(erc-current-nick-face ((t (:foreground ,nier-blue :weight bold))))
   `(erc-dangerous-host-face ((t (:inherit font-lock-warning-face))))
   `(erc-default-face ((t (:foreground ,nier-fg))))
   `(erc-direct-msg-face ((t (:inherit erc-default-face))))
   `(erc-error-face ((t (:inherit font-lock-warning-face))))
   `(erc-fool-face ((t (:inherit erc-default-face))))
   `(erc-highlight-face ((t (:inherit hover-highlight))))
   `(erc-input-face ((t (:foreground ,nier-yellow))))
   `(erc-keyword-face ((t (:foreground ,nier-blue :weight bold))))
   `(erc-nick-default-face ((t (:foreground ,nier-yellow :weight bold))))
   `(erc-my-nick-face ((t (:foreground ,nier-red :weight bold))))
   `(erc-nick-msg-face ((t (:inherit erc-default-face))))
   `(erc-notice-face ((t (:foreground ,nier-green))))
   `(erc-pal-face ((t (:foreground ,nier-orange :weight bold))))
   `(erc-prompt-face ((t (:foreground ,nier-orange :background ,nier-bg :weight bold))))
   `(erc-timestamp-face ((t (:foreground ,nier-green+4))))
   `(erc-underline-face ((t (:underline t))))
;;;;; eros
   `(eros-result-overlay-face ((t (:background unspecified))))
;;;;; ert
   `(ert-test-result-expected ((t (:foreground ,nier-green+4 :background ,nier-bg))))
   `(ert-test-result-unexpected ((t (:foreground ,nier-red :background ,nier-bg))))
;;;;; eshell
   `(eshell-prompt ((t (:foreground ,nier-yellow :weight bold))))
   `(eshell-ls-archive ((t (:foreground ,nier-red-1 :weight bold))))
   `(eshell-ls-backup ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-clutter ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-directory ((t (:foreground ,nier-blue+1 :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,nier-red+1 :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,nier-fg))))
   `(eshell-ls-missing ((t (:inherit font-lock-warning-face))))
   `(eshell-ls-product ((t (:inherit font-lock-doc-face))))
   `(eshell-ls-special ((t (:foreground ,nier-yellow :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,nier-blue :weight bold))))
;;;;; flx
   `(flx-highlight-face ((t (:foreground ,nier-green+2 :weight bold))))
;;;;; flycheck
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-red-1) :inherit unspecified))
      (t (:foreground ,nier-red-1 :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-yellow) :inherit unspecified))
      (t (:foreground ,nier-yellow :weight bold :underline t))))
   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-blue) :inherit unspecified))
      (t (:foreground ,nier-blue :weight bold :underline t))))
   `(flycheck-fringe-error ((t (:foreground ,nier-red-1 :weight bold))))
   `(flycheck-fringe-warning ((t (:foreground ,nier-yellow :weight bold))))
   `(flycheck-fringe-info ((t (:foreground ,nier-blue :weight bold))))
;;;;; flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-red)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nier-red-1 :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-orange)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nier-orange :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-green)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nier-green-2 :weight bold :underline t))))
   `(flymake-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-red)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nier-red-1 :weight bold :underline t))))
   `(flymake-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-orange)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nier-orange :weight bold :underline t))))
   `(flymake-note
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-green)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,nier-green-2 :weight bold :underline t))))
;;;;; flyspell
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-orange) :inherit unspecified))
      (t (:foreground ,nier-orange :weight bold :underline t))))
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-red) :inherit unspecified))
      (t (:foreground ,nier-red-1 :weight bold :underline t))))
;;;;; full-ack
   `(ack-separator ((t (:foreground ,nier-fg))))
   `(ack-file ((t (:foreground ,nier-blue))))
   `(ack-line ((t (:foreground ,nier-yellow))))
   `(ack-match ((t (:foreground ,nier-orange :background ,nier-bg-1 :weight bold))))
;;;;; git-annex
   '(git-annex-dired-annexed-available ((t (:inherit success :weight normal))))
   '(git-annex-dired-annexed-unavailable ((t (:inherit error :weight normal))))
;;;;; git-commit
   `(git-commit-comment-action  ((,class (:foreground ,nier-green+1 :weight bold))))
   `(git-commit-comment-branch  ((,class (:foreground ,nier-blue+1  :weight bold)))) ; obsolete
   `(git-commit-comment-branch-local  ((,class (:foreground ,nier-blue+1  :weight bold))))
   `(git-commit-comment-branch-remote ((,class (:foreground ,nier-green  :weight bold))))
   `(git-commit-comment-heading ((,class (:foreground ,nier-yellow  :weight bold))))
;;;;; git-gutter
   `(git-gutter:added ((t (:foreground ,nier-green :weight bold :inverse-video t))))
   `(git-gutter:deleted ((t (:foreground ,nier-red :weight bold :inverse-video t))))
   `(git-gutter:modified ((t (:foreground ,nier-purple :weight bold :inverse-video t))))
   `(git-gutter:unchanged ((t (:foreground ,nier-fg :weight bold :inverse-video t))))
;;;;; git-gutter-fr
   `(git-gutter-fr:added ((t (:foreground ,nier-green  :weight bold))))
   `(git-gutter-fr:deleted ((t (:foreground ,nier-red :weight bold))))
   `(git-gutter-fr:modified ((t (:foreground ,nier-purple :weight bold))))
;;;;; git-rebase
   `(git-rebase-hash ((t (:foreground, nier-orange))))
;;;;; gnus
   `(gnus-group-mail-1 ((t (:weight bold :inherit gnus-group-mail-1-empty))))
   `(gnus-group-mail-1-empty ((t (:inherit gnus-group-news-1-empty))))
   `(gnus-group-mail-2 ((t (:weight bold :inherit gnus-group-mail-2-empty))))
   `(gnus-group-mail-2-empty ((t (:inherit gnus-group-news-2-empty))))
   `(gnus-group-mail-3 ((t (:weight bold :inherit gnus-group-mail-3-empty))))
   `(gnus-group-mail-3-empty ((t (:inherit gnus-group-news-3-empty))))
   `(gnus-group-mail-4 ((t (:weight bold :inherit gnus-group-mail-4-empty))))
   `(gnus-group-mail-4-empty ((t (:inherit gnus-group-news-4-empty))))
   `(gnus-group-mail-5 ((t (:weight bold :inherit gnus-group-mail-5-empty))))
   `(gnus-group-mail-5-empty ((t (:inherit gnus-group-news-5-empty))))
   `(gnus-group-mail-6 ((t (:weight bold :inherit gnus-group-mail-6-empty))))
   `(gnus-group-mail-6-empty ((t (:inherit gnus-group-news-6-empty))))
   `(gnus-group-mail-low ((t (:weight bold :inherit gnus-group-mail-low-empty))))
   `(gnus-group-mail-low-empty ((t (:inherit gnus-group-news-low-empty))))
   `(gnus-group-news-1 ((t (:weight bold :inherit gnus-group-news-1-empty))))
   `(gnus-group-news-2 ((t (:weight bold :inherit gnus-group-news-2-empty))))
   `(gnus-group-news-3 ((t (:weight bold :inherit gnus-group-news-3-empty))))
   `(gnus-group-news-4 ((t (:weight bold :inherit gnus-group-news-4-empty))))
   `(gnus-group-news-5 ((t (:weight bold :inherit gnus-group-news-5-empty))))
   `(gnus-group-news-6 ((t (:weight bold :inherit gnus-group-news-6-empty))))
   `(gnus-group-news-low ((t (:weight bold :inherit gnus-group-news-low-empty))))
   `(gnus-header-content ((t (:inherit message-header-other))))
   `(gnus-header-from ((t (:inherit message-header-to))))
   `(gnus-header-name ((t (:inherit message-header-name))))
   `(gnus-header-newsgroups ((t (:inherit message-header-other))))
   `(gnus-header-subject ((t (:inherit message-header-subject))))
   `(gnus-server-opened ((t (:foreground ,nier-green+2 :weight bold))))
   `(gnus-server-denied ((t (:foreground ,nier-red+1 :weight bold))))
   `(gnus-server-closed ((t (:foreground ,nier-blue :slant italic))))
   `(gnus-server-offline ((t (:foreground ,nier-yellow :weight bold))))
   `(gnus-server-agent ((t (:foreground ,nier-blue :weight bold))))
   `(gnus-summary-cancelled ((t (:foreground ,nier-orange))))
   `(gnus-summary-high-ancient ((t (:foreground ,nier-blue))))
   `(gnus-summary-high-read ((t (:foreground ,nier-green :weight bold))))
   `(gnus-summary-high-ticked ((t (:foreground ,nier-orange :weight bold))))
   `(gnus-summary-high-unread ((t (:foreground ,nier-fg :weight bold))))
   `(gnus-summary-low-ancient ((t (:foreground ,nier-blue))))
   `(gnus-summary-low-read ((t (:foreground ,nier-green))))
   `(gnus-summary-low-ticked ((t (:foreground ,nier-orange :weight bold))))
   `(gnus-summary-low-unread ((t (:foreground ,nier-fg))))
   `(gnus-summary-normal-ancient ((t (:foreground ,nier-blue))))
   `(gnus-summary-normal-read ((t (:foreground ,nier-green))))
   `(gnus-summary-normal-ticked ((t (:foreground ,nier-orange :weight bold))))
   `(gnus-summary-normal-unread ((t (:foreground ,nier-fg))))
   `(gnus-summary-selected ((t (:foreground ,nier-yellow :weight bold))))
   `(gnus-cite-1 ((t (:foreground ,nier-blue))))
   `(gnus-cite-10 ((t (:foreground ,nier-yellow-1))))
   `(gnus-cite-11 ((t (:foreground ,nier-yellow))))
   `(gnus-cite-2 ((t (:foreground ,nier-blue-1))))
   `(gnus-cite-3 ((t (:foreground ,nier-blue-2))))
   `(gnus-cite-4 ((t (:foreground ,nier-green+2))))
   `(gnus-cite-5 ((t (:foreground ,nier-green+1))))
   `(gnus-cite-6 ((t (:foreground ,nier-green))))
   `(gnus-cite-7 ((t (:foreground ,nier-red))))
   `(gnus-cite-8 ((t (:foreground ,nier-red-1))))
   `(gnus-cite-9 ((t (:foreground ,nier-red-2))))
   `(gnus-group-news-1-empty ((t (:foreground ,nier-yellow))))
   `(gnus-group-news-2-empty ((t (:foreground ,nier-green+3))))
   `(gnus-group-news-3-empty ((t (:foreground ,nier-green+1))))
   `(gnus-group-news-4-empty ((t (:foreground ,nier-blue-2))))
   `(gnus-group-news-5-empty ((t (:foreground ,nier-blue-3))))
   `(gnus-group-news-6-empty ((t (:foreground ,nier-bg+2))))
   `(gnus-group-news-low-empty ((t (:foreground ,nier-bg+2))))
   `(gnus-signature ((t (:foreground ,nier-yellow))))
   `(gnus-x ((t (:background ,nier-fg :foreground ,nier-bg))))
   `(mm-uu-extract ((t (:background ,nier-bg-05 :foreground ,nier-green+1))))
;;;;; go-guru
   `(go-guru-hl-identifier-face ((t (:foreground ,nier-bg-1 :background ,nier-green+1))))
;;;;; guide-key
   `(guide-key/highlight-command-face ((t (:foreground ,nier-blue))))
   `(guide-key/key-face ((t (:foreground ,nier-green))))
   `(guide-key/prefix-command-face ((t (:foreground ,nier-green+1))))
;;;;; hackernews
   '(hackernews-comment-count ((t (:inherit link-visited :underline nil))))
   '(hackernews-link          ((t (:inherit link         :underline nil))))
;;;;; helm
   `(helm-header
     ((t (:foreground ,nier-green
                      :background ,nier-bg
                      :underline nil
                      :box nil
                      :extend t))))
   `(helm-source-header
     ((t (:foreground ,nier-yellow
                      :background ,nier-bg-1
                      :underline nil
                      :weight bold
                      :box (:line-width -1 :style released-button)
                      :extend t))))
   `(helm-selection ((t (:background ,nier-bg-05 :underline nil))))
   `(helm-selection-line ((t (:background ,nier-bg-05))))
   `(helm-visible-mark ((t (:foreground ,nier-bg :background ,nier-yellow-2))))
   `(helm-candidate-number ((t (:foreground ,nier-green+4 :background ,nier-bg-1))))
   `(helm-separator ((t (:foreground ,nier-red :background ,nier-bg))))
   `(helm-time-zone-current ((t (:foreground ,nier-green+2 :background ,nier-bg))))
   `(helm-time-zone-home ((t (:foreground ,nier-red :background ,nier-bg))))
   `(helm-bookmark-addressbook ((t (:foreground ,nier-orange :background ,nier-bg))))
   `(helm-bookmark-directory ((t (:foreground nil :background nil :inherit helm-ff-directory))))
   `(helm-bookmark-file ((t (:foreground nil :background nil :inherit helm-ff-file))))
   `(helm-bookmark-gnus ((t (:foreground ,nier-purple :background ,nier-bg))))
   `(helm-bookmark-info ((t (:foreground ,nier-green+2 :background ,nier-bg))))
   `(helm-bookmark-man ((t (:foreground ,nier-yellow :background ,nier-bg))))
   `(helm-bookmark-w3m ((t (:foreground ,nier-purple :background ,nier-bg))))
   `(helm-buffer-not-saved ((t (:foreground ,nier-red :background ,nier-bg))))
   `(helm-buffer-process ((t (:foreground ,nier-blue :background ,nier-bg))))
   `(helm-buffer-saved-out ((t (:foreground ,nier-fg :background ,nier-bg))))
   `(helm-buffer-size ((t (:foreground ,nier-fg-1 :background ,nier-bg))))
   `(helm-ff-directory ((t (:foreground ,nier-blue :background ,nier-bg :weight bold))))
   `(helm-ff-file ((t (:foreground ,nier-fg :background ,nier-bg :weight normal))))
   `(helm-ff-file-extension ((t (:foreground ,nier-fg :background ,nier-bg :weight normal))))
   `(helm-ff-executable ((t (:foreground ,nier-green+2 :background ,nier-bg :weight normal))))
   `(helm-ff-invalid-symlink ((t (:foreground ,nier-red :background ,nier-bg :weight bold))))
   `(helm-ff-symlink ((t (:foreground ,nier-yellow :background ,nier-bg :weight bold))))
   `(helm-ff-prefix ((t (:foreground ,nier-bg :background ,nier-yellow :weight normal))))
   `(helm-grep-cmd-line ((t (:foreground ,nier-blue :background ,nier-bg))))
   `(helm-grep-file ((t (:foreground ,nier-fg :background ,nier-bg))))
   `(helm-grep-finish ((t (:foreground ,nier-green+2 :background ,nier-bg))))
   `(helm-grep-lineno ((t (:foreground ,nier-fg-1 :background ,nier-bg))))
   `(helm-grep-match ((t (:foreground nil :background nil :inherit helm-match))))
   `(helm-grep-running ((t (:foreground ,nier-red :background ,nier-bg))))
   `(helm-match ((t (:foreground ,nier-orange :background ,nier-bg-1 :weight bold))))
   `(helm-moccur-buffer ((t (:foreground ,nier-blue :background ,nier-bg))))
   `(helm-mu-contacts-address-face ((t (:foreground ,nier-fg-1 :background ,nier-bg))))
   `(helm-mu-contacts-name-face ((t (:foreground ,nier-fg :background ,nier-bg))))
;;;;; helm-lxc
   `(helm-lxc-face-frozen ((t (:foreground ,nier-blue :background ,nier-bg))))
   `(helm-lxc-face-running ((t (:foreground ,nier-green :background ,nier-bg))))
   `(helm-lxc-face-stopped ((t (:foreground ,nier-red :background ,nier-bg))))
;;;;; helm-swoop
   `(helm-swoop-target-line-face ((t (:foreground ,nier-fg :background ,nier-bg+1))))
   `(helm-swoop-target-word-face ((t (:foreground ,nier-yellow :background ,nier-bg+2 :weight bold))))
;;;;; highlight-numbers
   `(highlight-numbers-number ((t (:foreground ,nier-green))))
;;;;; highlight-symbol
   `(highlight-symbol-face ((t (:background ,nier-bg+2))))
;;;;; highlight-thing
   `(highlight-thing ((t (:background ,nier-bg+2))))
;;;;; hl-line-mode
   `(hl-line-face ((,class (:background ,nier-bg-05))
                   (t :weight bold)))
   `(hl-line ((,class (:background ,nier-bg-05 :extend t)) ; old emacsen
              (t :weight bold)))
;;;;; hl-sexp
   `(hl-sexp-face ((,class (:background ,nier-bg+1))
                   (t :weight bold)))
;;;;; hydra
   `(hydra-face-red ((t (:foreground ,nier-red-1 :background ,nier-bg))))
   `(hydra-face-amaranth ((t (:foreground ,nier-red-3 :background ,nier-bg))))
   `(hydra-face-blue ((t (:foreground ,nier-blue :background ,nier-bg))))
   `(hydra-face-pink ((t (:foreground ,nier-purple :background ,nier-bg))))
   `(hydra-face-teal ((t (:foreground ,nier-blue :background ,nier-bg))))
;;;;; info+
   `(info-command-ref-item ((t (:background ,nier-bg-1 :foreground ,nier-orange))))
   `(info-constant-ref-item ((t (:background ,nier-bg-1 :foreground ,nier-purple))))
   `(info-double-quoted-name ((t (:inherit font-lock-comment-face))))
   `(info-file ((t (:background ,nier-bg-1 :foreground ,nier-yellow))))
   `(info-function-ref-item ((t (:background ,nier-bg-1 :inherit font-lock-function-name-face))))
   `(info-macro-ref-item ((t (:background ,nier-bg-1 :foreground ,nier-yellow))))
   `(info-menu ((t (:foreground ,nier-yellow))))
   `(info-quoted-name ((t (:inherit font-lock-constant-face))))
   `(info-reference-item ((t (:background ,nier-bg-1))))
   `(info-single-quote ((t (:inherit font-lock-keyword-face))))
   `(info-special-form-ref-item ((t (:background ,nier-bg-1 :foreground ,nier-yellow))))
   `(info-string ((t (:inherit font-lock-string-face))))
   `(info-syntax-class-item ((t (:background ,nier-bg-1 :foreground ,nier-blue+1))))
   `(info-user-option-ref-item ((t (:background ,nier-bg-1 :foreground ,nier-red))))
   `(info-variable-ref-item ((t (:background ,nier-bg-1 :foreground ,nier-orange))))
;;;;; irfc
   `(irfc-head-name-face ((t (:foreground ,nier-red :weight bold))))
   `(irfc-head-number-face ((t (:foreground ,nier-red :weight bold))))
   `(irfc-reference-face ((t (:foreground ,nier-blue-1 :weight bold))))
   `(irfc-requirement-keyword-face ((t (:inherit font-lock-keyword-face))))
   `(irfc-rfc-link-face ((t (:inherit link))))
   `(irfc-rfc-number-face ((t (:foreground ,nier-blue :weight bold))))
   `(irfc-std-number-face ((t (:foreground ,nier-green+4 :weight bold))))
   `(irfc-table-item-face ((t (:foreground ,nier-green+3))))
   `(irfc-title-face ((t (:foreground ,nier-yellow
                                      :underline t :weight bold))))
;;;;; ivy
   `(ivy-confirm-face ((t (:foreground ,nier-green :background ,nier-bg))))
   `(ivy-current-match ((t (:foreground ,nier-yellow :weight bold :underline t))))
   `(ivy-cursor ((t (:foreground ,nier-bg :background ,nier-fg))))
   `(ivy-match-required-face ((t (:foreground ,nier-red :background ,nier-bg))))
   `(ivy-minibuffer-match-face-1 ((t (:background ,nier-bg+1))))
   `(ivy-minibuffer-match-face-2 ((t (:background ,nier-green-2))))
   `(ivy-minibuffer-match-face-3 ((t (:background ,nier-green))))
   `(ivy-minibuffer-match-face-4 ((t (:background ,nier-green+1))))
   `(ivy-remote ((t (:foreground ,nier-blue :background ,nier-bg))))
   `(ivy-subdir ((t (:foreground ,nier-yellow :background ,nier-bg))))
;;;;; ido-mode
   `(ido-first-match ((t (:foreground ,nier-yellow :weight bold))))
   `(ido-only-match ((t (:foreground ,nier-orange :weight bold))))
   `(ido-subdir ((t (:foreground ,nier-yellow))))
   `(ido-indicator ((t (:foreground ,nier-yellow :background ,nier-red-4))))
;;;;; iedit-mode
   `(iedit-occurrence ((t (:background ,nier-bg+2 :weight bold))))
;;;;; jabber-mode
   `(jabber-roster-user-away ((t (:foreground ,nier-green+2))))
   `(jabber-roster-user-online ((t (:foreground ,nier-blue-1))))
   `(jabber-roster-user-dnd ((t (:foreground ,nier-red+1))))
   `(jabber-roster-user-xa ((t (:foreground ,nier-purple))))
   `(jabber-roster-user-chatty ((t (:foreground ,nier-orange))))
   `(jabber-roster-user-error ((t (:foreground ,nier-red+1))))
   `(jabber-rare-time-face ((t (:foreground ,nier-green+1))))
   `(jabber-chat-prompt-local ((t (:foreground ,nier-blue-1))))
   `(jabber-chat-prompt-foreign ((t (:foreground ,nier-red+1))))
   `(jabber-chat-prompt-system ((t (:foreground ,nier-green+3))))
   `(jabber-activity-face((t (:foreground ,nier-red+1))))
   `(jabber-activity-personal-face ((t (:foreground ,nier-blue+1))))
   `(jabber-title-small ((t (:height 1.1 :weight bold))))
   `(jabber-title-medium ((t (:height 1.2 :weight bold))))
   `(jabber-title-large ((t (:height 1.3 :weight bold))))
;;;;; js2-mode
   `(js2-warning ((t (:underline ,nier-orange))))
   `(js2-error ((t (:foreground ,nier-red :weight bold))))
   `(js2-jsdoc-tag ((t (:foreground ,nier-green-2))))
   `(js2-jsdoc-type ((t (:foreground ,nier-green+2))))
   `(js2-jsdoc-value ((t (:foreground ,nier-green+3))))
   `(js2-function-param ((t (:foreground, nier-orange))))
   `(js2-external-variable ((t (:foreground ,nier-orange))))
;;;;; additional js2 mode attributes for better syntax highlighting
   `(js2-instance-member ((t (:foreground ,nier-green-2))))
   `(js2-jsdoc-html-tag-delimiter ((t (:foreground ,nier-orange))))
   `(js2-jsdoc-html-tag-name ((t (:foreground ,nier-red-1))))
   `(js2-object-property ((t (:foreground ,nier-blue+1))))
   `(js2-magic-paren ((t (:foreground ,nier-blue-5))))
   `(js2-private-function-call ((t (:foreground ,nier-blue))))
   `(js2-function-call ((t (:foreground ,nier-blue))))
   `(js2-private-member ((t (:foreground ,nier-blue-1))))
   `(js2-keywords ((t (:foreground ,nier-purple))))
;;;;; ledger-mode
   `(ledger-font-payee-uncleared-face ((t (:foreground ,nier-red-1 :weight bold))))
   `(ledger-font-payee-cleared-face ((t (:foreground ,nier-fg :weight normal))))
   `(ledger-font-payee-pending-face ((t (:foreground ,nier-red :weight normal))))
   `(ledger-font-xact-highlight-face ((t (:background ,nier-bg+1))))
   `(ledger-font-auto-xact-face ((t (:foreground ,nier-yellow-1 :weight normal))))
   `(ledger-font-periodic-xact-face ((t (:foreground ,nier-green :weight normal))))
   `(ledger-font-pending-face ((t (:foreground ,nier-orange weight: normal))))
   `(ledger-font-other-face ((t (:foreground ,nier-fg))))
   `(ledger-font-posting-date-face ((t (:foreground ,nier-orange :weight normal))))
   `(ledger-font-posting-account-face ((t (:foreground ,nier-blue-1))))
   `(ledger-font-posting-account-cleared-face ((t (:foreground ,nier-fg))))
   `(ledger-font-posting-account-pending-face ((t (:foreground ,nier-orange))))
   `(ledger-font-posting-amount-face ((t (:foreground ,nier-orange))))
   `(ledger-occur-narrowed-face ((t (:foreground ,nier-fg-1 :invisible t))))
   `(ledger-occur-xact-face ((t (:background ,nier-bg+1))))
   `(ledger-font-comment-face ((t (:foreground ,nier-green))))
   `(ledger-font-reconciler-uncleared-face ((t (:foreground ,nier-red-1 :weight bold))))
   `(ledger-font-reconciler-cleared-face ((t (:foreground ,nier-fg :weight normal))))
   `(ledger-font-reconciler-pending-face ((t (:foreground ,nier-orange :weight normal))))
   `(ledger-font-report-clickable-face ((t (:foreground ,nier-orange :weight normal))))
;;;;; linum-mode
   `(linum ((t (:foreground ,nier-green+2 :background ,nier-bg))))
;;;;; lispy
   `(lispy-command-name-face ((t (:background ,nier-bg-05 :inherit font-lock-function-name-face))))
   `(lispy-cursor-face ((t (:foreground ,nier-bg :background ,nier-fg))))
   `(lispy-face-hint ((t (:inherit highlight :foreground ,nier-yellow))))
;;;;; ruler-mode
   `(ruler-mode-column-number ((t (:inherit 'ruler-mode-default :foreground ,nier-fg))))
   `(ruler-mode-fill-column ((t (:inherit 'ruler-mode-default :foreground ,nier-yellow))))
   `(ruler-mode-goal-column ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-comment-column ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-tab-stop ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-current-column ((t (:foreground ,nier-yellow :box t))))
   `(ruler-mode-default ((t (:foreground ,nier-green+2 :background ,nier-bg))))

;;;;; lui
   `(lui-time-stamp-face ((t (:foreground ,nier-blue-1))))
   `(lui-hilight-face ((t (:foreground ,nier-green+2 :background ,nier-bg))))
   `(lui-button-face ((t (:inherit hover-highlight))))
;;;;; macrostep
   `(macrostep-gensym-1
     ((t (:foreground ,nier-green+2 :background ,nier-bg-1))))
   `(macrostep-gensym-2
     ((t (:foreground ,nier-red+1 :background ,nier-bg-1))))
   `(macrostep-gensym-3
     ((t (:foreground ,nier-blue+1 :background ,nier-bg-1))))
   `(macrostep-gensym-4
     ((t (:foreground ,nier-purple :background ,nier-bg-1))))
   `(macrostep-gensym-5
     ((t (:foreground ,nier-yellow :background ,nier-bg-1))))
   `(macrostep-expansion-highlight-face
     ((t (:inherit highlight))))
   `(macrostep-macro-face
     ((t (:underline t))))
;;;;; magit
;;;;;; headings and diffs
   ;; Please read (info "(magit)Theming Faces") before changing this.
   `(magit-section-highlight           ((t (:background ,nier-bg+05))))
   `(magit-section-heading             ((t (:foreground ,nier-yellow :weight bold))))
   `(magit-section-heading-selection   ((t (:foreground ,nier-orange :weight bold))))
   `(magit-diff-file-heading           ((t (:weight bold))))
   `(magit-diff-file-heading-highlight ((t (:background ,nier-bg+05 :weight bold))))
   `(magit-diff-file-heading-selection ((t (:background ,nier-bg+05 :weight bold
                                                        :foreground ,nier-orange))))
   `(magit-diff-added                  ((t (:background ,nier-green-2))))
   `(magit-diff-added-highlight        ((t (:background ,nier-green))))
   `(magit-diff-removed                ((t (:background ,nier-red-4))))
   `(magit-diff-removed-highlight      ((t (:background ,nier-red-3))))
   `(magit-diff-hunk-heading           ((t (:background ,nier-bg+1))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,nier-bg+2))))
   `(magit-diff-hunk-heading-selection ((t (:background ,nier-bg+2
                                                        :foreground ,nier-orange))))
   `(magit-diff-lines-heading          ((t (:background ,nier-orange
                                                        :foreground ,nier-bg+2))))
   `(magit-diff-context-highlight      ((t (:background ,nier-bg+05
                                                        :foreground "grey70"))))
   `(magit-diffstat-added              ((t (:foreground ,nier-green+4))))
   `(magit-diffstat-removed            ((t (:foreground ,nier-red))))
;;;;;; popup
   `(magit-popup-heading             ((t (:foreground ,nier-yellow  :weight bold))))
   `(magit-popup-key                 ((t (:foreground ,nier-green-2 :weight bold))))
   `(magit-popup-argument            ((t (:foreground ,nier-green   :weight bold))))
   `(magit-popup-disabled-argument   ((t (:foreground ,nier-fg-1    :weight normal))))
   `(magit-popup-option-value        ((t (:foreground ,nier-blue-2  :weight bold))))
;;;;;; process
   `(magit-process-ok    ((t (:foreground ,nier-green  :weight bold))))
   `(magit-process-ng    ((t (:foreground ,nier-red    :weight bold))))
;;;;;; log
   `(magit-log-author    ((t (:foreground ,nier-orange))))
   `(magit-log-date      ((t (:foreground ,nier-fg-1))))
   `(magit-log-graph     ((t (:foreground ,nier-fg+1))))
;;;;;; sequence
   `(magit-sequence-pick ((t (:foreground ,nier-yellow-2))))
   `(magit-sequence-stop ((t (:foreground ,nier-green))))
   `(magit-sequence-part ((t (:foreground ,nier-yellow))))
   `(magit-sequence-head ((t (:foreground ,nier-blue))))
   `(magit-sequence-drop ((t (:foreground ,nier-red))))
   `(magit-sequence-done ((t (:foreground ,nier-fg-1))))
   `(magit-sequence-onto ((t (:foreground ,nier-fg-1))))
;;;;;; bisect
   `(magit-bisect-good ((t (:foreground ,nier-green))))
   `(magit-bisect-skip ((t (:foreground ,nier-yellow))))
   `(magit-bisect-bad  ((t (:foreground ,nier-red))))
;;;;;; blame
   `(magit-blame-heading ((t (:background ,nier-bg-1 :foreground ,nier-blue-2))))
   `(magit-blame-hash    ((t (:background ,nier-bg-1 :foreground ,nier-blue-2))))
   `(magit-blame-name    ((t (:background ,nier-bg-1 :foreground ,nier-orange))))
   `(magit-blame-date    ((t (:background ,nier-bg-1 :foreground ,nier-orange))))
   `(magit-blame-summary ((t (:background ,nier-bg-1 :foreground ,nier-blue-2
                                          :weight bold))))
;;;;;; references etc
   `(magit-dimmed         ((t (:foreground ,nier-bg+3))))
   `(magit-hash           ((t (:foreground ,nier-bg+3))))
   `(magit-tag            ((t (:foreground ,nier-orange :weight bold))))
   `(magit-branch-remote  ((t (:foreground ,nier-green  :weight bold))))
   `(magit-branch-local   ((t (:foreground ,nier-blue   :weight bold))))
   `(magit-branch-current ((t (:foreground ,nier-blue   :weight bold :box t))))
   `(magit-head           ((t (:foreground ,nier-blue   :weight bold))))
   `(magit-refname        ((t (:background ,nier-bg+2 :foreground ,nier-fg :weight bold))))
   `(magit-refname-stash  ((t (:background ,nier-bg+2 :foreground ,nier-fg :weight bold))))
   `(magit-refname-wip    ((t (:background ,nier-bg+2 :foreground ,nier-fg :weight bold))))
   `(magit-signature-good      ((t (:foreground ,nier-green))))
   `(magit-signature-bad       ((t (:foreground ,nier-red))))
   `(magit-signature-untrusted ((t (:foreground ,nier-yellow))))
   `(magit-signature-expired   ((t (:foreground ,nier-orange))))
   `(magit-signature-revoked   ((t (:foreground ,nier-purple))))
   '(magit-signature-error     ((t (:inherit    magit-signature-bad))))
   `(magit-cherry-unmatched    ((t (:foreground ,nier-blue))))
   `(magit-cherry-equivalent   ((t (:foreground ,nier-purple))))
   `(magit-reflog-commit       ((t (:foreground ,nier-green))))
   `(magit-reflog-amend        ((t (:foreground ,nier-purple))))
   `(magit-reflog-merge        ((t (:foreground ,nier-green))))
   `(magit-reflog-checkout     ((t (:foreground ,nier-blue))))
   `(magit-reflog-reset        ((t (:foreground ,nier-red))))
   `(magit-reflog-rebase       ((t (:foreground ,nier-purple))))
   `(magit-reflog-cherry-pick  ((t (:foreground ,nier-green))))
   `(magit-reflog-remote       ((t (:foreground ,nier-blue))))
   `(magit-reflog-other        ((t (:foreground ,nier-blue))))
;;;;; markup-faces
   `(markup-anchor-face ((t (:foreground ,nier-blue+1))))
   `(markup-code-face ((t (:inherit font-lock-constant-face))))
   `(markup-command-face ((t (:foreground ,nier-yellow))))
   `(markup-emphasis-face ((t (:inherit bold))))
   `(markup-internal-reference-face ((t (:foreground ,nier-yellow-2 :underline t))))
   `(markup-list-face ((t (:foreground ,nier-fg+1))))
   `(markup-meta-face ((t (:foreground ,nier-yellow))))
   `(markup-meta-hide-face ((t (:foreground ,nier-yellow))))
   `(markup-secondary-text-face ((t (:foreground ,nier-yellow-1))))
   `(markup-title-0-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-title-1-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-title-2-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-title-3-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-title-4-face ((t (:inherit font-lock-function-name-face :weight bold))))
   `(markup-typewriter-face ((t (:inherit font-lock-constant-face))))
   `(markup-verbatim-face ((t (:inherit font-lock-constant-face))))
   `(markup-value-face ((t (:foreground ,nier-yellow))))
;;;;; message-mode
   `(message-cited-text ((t (:inherit font-lock-comment-face))))
   `(message-header-name ((t (:foreground ,nier-green+1))))
   `(message-header-other ((t (:foreground ,nier-green))))
   `(message-header-to ((t (:foreground ,nier-yellow :weight bold))))
   `(message-header-cc ((t (:foreground ,nier-yellow :weight bold))))
   `(message-header-newsgroups ((t (:foreground ,nier-yellow :weight bold))))
   `(message-header-subject ((t (:foreground ,nier-orange :weight bold))))
   `(message-header-xheader ((t (:foreground ,nier-green))))
   `(message-mml ((t (:foreground ,nier-yellow :weight bold))))
   `(message-separator ((t (:inherit font-lock-comment-face))))
;;;;; mew
   `(mew-face-header-subject ((t (:foreground ,nier-orange))))
   `(mew-face-header-from ((t (:foreground ,nier-yellow))))
   `(mew-face-header-date ((t (:foreground ,nier-green))))
   `(mew-face-header-to ((t (:foreground ,nier-red))))
   `(mew-face-header-key ((t (:foreground ,nier-green))))
   `(mew-face-header-private ((t (:foreground ,nier-green))))
   `(mew-face-header-important ((t (:foreground ,nier-blue))))
   `(mew-face-header-marginal ((t (:foreground ,nier-fg :weight bold))))
   `(mew-face-header-warning ((t (:foreground ,nier-red))))
   `(mew-face-header-xmew ((t (:foreground ,nier-green))))
   `(mew-face-header-xmew-bad ((t (:foreground ,nier-red))))
   `(mew-face-body-url ((t (:foreground ,nier-orange))))
   `(mew-face-body-comment ((t (:foreground ,nier-fg :slant italic))))
   `(mew-face-body-cite1 ((t (:foreground ,nier-green))))
   `(mew-face-body-cite2 ((t (:foreground ,nier-blue))))
   `(mew-face-body-cite3 ((t (:foreground ,nier-orange))))
   `(mew-face-body-cite4 ((t (:foreground ,nier-yellow))))
   `(mew-face-body-cite5 ((t (:foreground ,nier-red))))
   `(mew-face-mark-review ((t (:foreground ,nier-blue))))
   `(mew-face-mark-escape ((t (:foreground ,nier-green))))
   `(mew-face-mark-delete ((t (:foreground ,nier-red))))
   `(mew-face-mark-unlink ((t (:foreground ,nier-yellow))))
   `(mew-face-mark-refile ((t (:foreground ,nier-green))))
   `(mew-face-mark-unread ((t (:foreground ,nier-red-2))))
   `(mew-face-eof-message ((t (:foreground ,nier-green))))
   `(mew-face-eof-part ((t (:foreground ,nier-yellow))))
;;;;; mic-paren
   `(paren-face-match ((t (:foreground ,nier-blue :background ,nier-bg :weight bold))))
   `(paren-face-mismatch ((t (:foreground ,nier-bg :background ,nier-purple :weight bold))))
   `(paren-face-no-match ((t (:foreground ,nier-bg :background ,nier-red :weight bold))))
;;;;; mingus
   `(mingus-directory-face ((t (:foreground ,nier-blue))))
   `(mingus-pausing-face ((t (:foreground ,nier-purple))))
   `(mingus-playing-face ((t (:foreground ,nier-blue))))
   `(mingus-playlist-face ((t (:foreground ,nier-blue ))))
   `(mingus-mark-face ((t (:bold t :foreground ,nier-purple))))
   `(mingus-song-file-face ((t (:foreground ,nier-yellow))))
   `(mingus-artist-face ((t (:foreground ,nier-blue))))
   `(mingus-album-face ((t (:underline t :foreground ,nier-red+1))))
   `(mingus-album-stale-face ((t (:foreground ,nier-red+1))))
   `(mingus-stopped-face ((t (:foreground ,nier-red))))
;;;;; nav
   `(nav-face-heading ((t (:foreground ,nier-yellow))))
   `(nav-face-button-num ((t (:foreground ,nier-blue))))
   `(nav-face-dir ((t (:foreground ,nier-green))))
   `(nav-face-hdir ((t (:foreground ,nier-red))))
   `(nav-face-file ((t (:foreground ,nier-fg))))
   `(nav-face-hfile ((t (:foreground ,nier-red-4))))
;;;;; merlin
   `(merlin-type-face ((t (:inherit highlight))))
   `(merlin-compilation-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-orange)))
      (t
       (:underline ,nier-orange))))
   `(merlin-compilation-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-red)))
      (t
       (:underline ,nier-red))))
;;;;; mu4e
   `(mu4e-cited-1-face ((t (:foreground ,nier-blue    :slant italic))))
   `(mu4e-cited-2-face ((t (:foreground ,nier-green+2 :slant italic))))
   `(mu4e-cited-3-face ((t (:foreground ,nier-blue-2  :slant italic))))
   `(mu4e-cited-4-face ((t (:foreground ,nier-green   :slant italic))))
   `(mu4e-cited-5-face ((t (:foreground ,nier-blue-4  :slant italic))))
   `(mu4e-cited-6-face ((t (:foreground ,nier-green-2 :slant italic))))
   `(mu4e-cited-7-face ((t (:foreground ,nier-blue    :slant italic))))
   `(mu4e-replied-face ((t (:foreground ,nier-bg+3))))
   `(mu4e-trashed-face ((t (:foreground ,nier-bg+3 :strike-through t))))
;;;;; mumamo
   `(mumamo-background-chunk-major ((t (:background nil))))
   `(mumamo-background-chunk-submode1 ((t (:background ,nier-bg-1))))
   `(mumamo-background-chunk-submode2 ((t (:background ,nier-bg+2))))
   `(mumamo-background-chunk-submode3 ((t (:background ,nier-bg+3))))
   `(mumamo-background-chunk-submode4 ((t (:background ,nier-bg+1))))
;;;;; neotree
   `(neo-banner-face ((t (:foreground ,nier-blue+1 :weight bold))))
   `(neo-header-face ((t (:foreground ,nier-fg))))
   `(neo-root-dir-face ((t (:foreground ,nier-blue+1 :weight bold))))
   `(neo-dir-link-face ((t (:foreground ,nier-blue))))
   `(neo-file-link-face ((t (:foreground ,nier-fg))))
   `(neo-expand-btn-face ((t (:foreground ,nier-blue))))
   `(neo-vc-default-face ((t (:foreground ,nier-fg+1))))
   `(neo-vc-user-face ((t (:foreground ,nier-red :slant italic))))
   `(neo-vc-up-to-date-face ((t (:foreground ,nier-fg))))
   `(neo-vc-edited-face ((t (:foreground ,nier-purple))))
   `(neo-vc-needs-merge-face ((t (:foreground ,nier-red+1))))
   `(neo-vc-unlocked-changes-face ((t (:foreground ,nier-red :background ,nier-blue-5))))
   `(neo-vc-added-face ((t (:foreground ,nier-green+1))))
   `(neo-vc-conflict-face ((t (:foreground ,nier-red+1))))
   `(neo-vc-missing-face ((t (:foreground ,nier-red+1))))
   `(neo-vc-ignored-face ((t (:foreground ,nier-fg-1))))
;;;;; notmuch
   `(notmuch-crypto-decryption ((t (:foreground ,nier-bg :background ,nier-purple))))
   `(notmuch-crypto-part-header ((t (:foreground ,nier-blue+1))))
   `(notmuch-crypto-signature-bad ((t (:foreground ,nier-bg :background ,nier-red))))
   `(notmuch-crypto-signature-good ((t (:foreground ,nier-bg :background ,nier-green+1))))
   `(notmuch-crypto-signature-good-key ((t (:foreground ,nier-bg :background ,nier-orange))))
   `(notmuch-crypto-signature-unknown ((t (:foreground ,nier-bg :background ,nier-red))))
   `(notmuch-hello-logo-background ((t (:background ,nier-bg+2))))
   `(notmuch-message-summary-face ((t (:background ,nier-bg-08))))
   `(notmuch-search-flagged-face ((t (:foreground ,nier-blue+1))))
   `(notmuch-search-non-matching-authors ((t (:foreground ,nier-fg-1))))
   `(notmuch-tag-added ((t (:underline ,nier-green+1))))
   `(notmuch-tag-deleted ((t (:strike-through ,nier-red))))
   `(notmuch-tag-face ((t (:foreground ,nier-green+1))))
   `(notmuch-tag-flagged ((t (:foreground ,nier-blue+1))))
   `(notmuch-tag-unread ((t (:foreground ,nier-red))))
   `(notmuch-tree-match-author-face ((t (:foreground ,nier-green+1))))
   `(notmuch-tree-match-tag-face ((t (:foreground ,nier-green+1))))
;;;;; orderless
   `(orderless-match-face-0 ((t (:foreground ,nier-green))))
   `(orderless-match-face-1 ((t (:foreground ,nier-purple))))
   `(orderless-match-face-2 ((t (:foreground ,nier-blue))))
   `(orderless-match-face-3 ((t (:foreground ,nier-orange))))
;;;;; org-mode
   `(org-agenda-date-today
     ((t (:foreground ,nier-fg+1 :slant italic :weight bold))) t)
   `(org-agenda-structure
     ((t (:inherit font-lock-comment-face))))
   `(org-archived ((t (:foreground ,nier-fg :weight bold))))
   `(org-block ((t (:background ,nier-bg+05 :extend t))))
   `(org-checkbox ((t (:background ,nier-bg+2 :foreground ,nier-fg+1
                                   :box (:line-width 1 :style released-button)))))
   `(org-date ((t (:foreground ,nier-blue :underline t))))
   `(org-deadline-announce ((t (:foreground ,nier-red-1))))
   `(org-done ((t (:weight bold :weight bold :foreground ,nier-green+3))))
   `(org-formula ((t (:foreground ,nier-yellow-2))))
   `(org-headline-done ((t (:foreground ,nier-green+3))))
   `(org-hide ((t (:foreground ,nier-bg))))
   `(org-level-1 ((t (:inherit ,z-variable-pitch :foreground ,nier-orange
                               ,@(when nier-automata-scale-org-headlines
                                   (list :height nier-height-plus-4))))))
   `(org-level-2 ((t (:inherit ,z-variable-pitch :foreground ,nier-green+4
                               ,@(when nier-automata-scale-org-headlines
                                   (list :height nier-height-plus-3))))))
   `(org-level-3 ((t (:inherit ,z-variable-pitch :foreground ,nier-blue-1
                               ,@(when nier-automata-scale-org-headlines
                                   (list :height nier-height-plus-2))))))
   `(org-level-4 ((t (:inherit ,z-variable-pitch :foreground ,nier-yellow-2
                               ,@(when nier-automata-scale-org-headlines
                                   (list :height nier-height-plus-1))))))
   `(org-level-5 ((t (:inherit ,z-variable-pitch :foreground ,nier-blue))))
   `(org-level-6 ((t (:inherit ,z-variable-pitch :foreground ,nier-green+2))))
   `(org-level-7 ((t (:inherit ,z-variable-pitch :foreground ,nier-red+2))))
   `(org-level-8 ((t (:inherit ,z-variable-pitch :foreground ,nier-purple))))
   `(org-link ((t (:foreground ,nier-yellow-2 :underline t))))
   `(org-quote ((t (:background ,nier-bg+05 :extend t))))
   `(org-scheduled ((t (:foreground ,nier-green+4))))
   `(org-scheduled-previously ((t (:foreground ,nier-red))))
   `(org-scheduled-today ((t (:foreground ,nier-blue+1))))
   `(org-sexp-date ((t (:foreground ,nier-blue+1 :underline t))))
   `(org-special-keyword ((t (:inherit font-lock-comment-face))))
   `(org-table ((t (:foreground ,nier-green+2))))
   `(org-tag ((t (:weight bold :weight bold))))
   `(org-time-grid ((t (:foreground ,nier-orange))))
   `(org-todo ((t (:weight bold :foreground ,nier-red :weight bold))))
   `(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
   `(org-warning ((t (:weight bold :foreground ,nier-red :weight bold :underline nil))))
   `(org-column ((t (:background ,nier-bg-1))))
   `(org-column-title ((t (:background ,nier-bg-1 :underline t :weight bold))))
   `(org-mode-line-clock ((t (:foreground ,nier-fg :background ,nier-bg-1))))
   `(org-mode-line-clock-overrun ((t (:foreground ,nier-bg :background ,nier-red-1))))
   `(org-ellipsis ((t (:foreground ,nier-yellow-1 :underline t))))
   `(org-footnote ((t (:foreground ,nier-blue :underline t))))
   `(org-document-title ((t (:inherit ,z-variable-pitch :foreground ,nier-blue
                                      :weight bold
                                      ,@(when nier-automata-scale-org-headlines
                                          (list :height nier-height-plus-4))))))
   `(org-document-info ((t (:foreground ,nier-blue))))
   `(org-habit-ready-face ((t :background ,nier-green)))
   `(org-habit-alert-face ((t :background ,nier-yellow-1 :foreground ,nier-bg)))
   `(org-habit-clear-face ((t :background ,nier-blue-3)))
   `(org-habit-overdue-face ((t :background ,nier-red-3)))
   `(org-habit-clear-future-face ((t :background ,nier-blue-4)))
   `(org-habit-ready-future-face ((t :background ,nier-green-2)))
   `(org-habit-alert-future-face ((t :background ,nier-yellow-2 :foreground ,nier-bg)))
   `(org-habit-overdue-future-face ((t :background ,nier-red-4)))
;;;;; org-ref
   `(org-ref-ref-face ((t :underline t)))
   `(org-ref-label-face ((t :underline t)))
   `(org-ref-cite-face ((t :underline t)))
   `(org-ref-glossary-face ((t :underline t)))
   `(org-ref-acronym-face ((t :underline t)))
;;;;; outline
   `(outline-1 ((t (:inherit ,z-variable-pitch :foreground ,nier-orange
                             ,@(when nier-automata-scale-outline-headlines
                                 (list :height nier-height-plus-4))))))
   `(outline-2 ((t (:inherit ,z-variable-pitch :foreground ,nier-green+4
                             ,@(when nier-automata-scale-outline-headlines
                                 (list :height nier-height-plus-3))))))
   `(outline-3 ((t (:inherit ,z-variable-pitch :foreground ,nier-blue-1
                             ,@(when nier-automata-scale-outline-headlines
                                 (list :height nier-height-plus-2))))))
   `(outline-4 ((t (:inherit ,z-variable-pitch :foreground ,nier-yellow-2
                             ,@(when nier-automata-scale-outline-headlines
                                 (list :height nier-height-plus-1))))))
   `(outline-5 ((t (:inherit ,z-variable-pitch :foreground ,nier-blue))))
   `(outline-6 ((t (:inherit ,z-variable-pitch :foreground ,nier-green+2))))
   `(outline-7 ((t (:inherit ,z-variable-pitch :foreground ,nier-red-4))))
   `(outline-8 ((t (:inherit ,z-variable-pitch :foreground ,nier-blue-4))))
;;;;; p4
   `(p4-depot-added-face ((t :inherit diff-added)))
   `(p4-depot-branch-op-face ((t :inherit diff-changed)))
   `(p4-depot-deleted-face ((t :inherit diff-removed)))
   `(p4-depot-unmapped-face ((t :inherit diff-changed)))
   `(p4-diff-change-face ((t :inherit diff-changed)))
   `(p4-diff-del-face ((t :inherit diff-removed)))
   `(p4-diff-file-face ((t :inherit diff-file-header)))
   `(p4-diff-head-face ((t :inherit diff-header)))
   `(p4-diff-ins-face ((t :inherit diff-added)))
;;;;; c/perl
   `(cperl-nonoverridable-face ((t (:foreground ,nier-purple))))
   `(cperl-array-face ((t (:foreground ,nier-yellow, :background ,nier-bg))))
   `(cperl-hash-face ((t (:foreground ,nier-yellow-1, :background ,nier-bg))))
;;;;; paren-face
   `(parenthesis ((t (:foreground ,nier-fg-1))))
;;;;; perspective
   `(persp-selected-face ((t (:foreground ,nier-yellow-2))))
;;;;; powerline
   `(powerline-active1 ((t (:background ,powerline-act1 :inherit mode-line))))
   `(powerline-active2 ((t (:background ,powerline-act2 :inherit mode-line))))
   `(powerline-inactive1 ((t (:background ,powerline-inact1 :inherit mode-line-inactive))))
   `(powerline-inactive2 ((t (:background ,powerline-inact2 :inherit mode-line-inactive))))
;;;;; proofgeneral
   `(proof-active-area-face ((t (:underline t))))
   `(proof-boring-face ((t (:foreground ,nier-fg :background ,nier-bg+2))))
   `(proof-command-mouse-highlight-face ((t (:inherit proof-mouse-highlight-face))))
   `(proof-debug-message-face ((t (:inherit proof-boring-face))))
   `(proof-declaration-name-face ((t (:inherit font-lock-keyword-face :foreground nil))))
   `(proof-eager-annotation-face ((t (:foreground ,nier-bg :background ,nier-orange))))
   `(proof-error-face ((t (:foreground ,nier-fg :background ,nier-red-4))))
   `(proof-highlight-dependency-face ((t (:foreground ,nier-bg :background ,nier-yellow-1))))
   `(proof-highlight-dependent-face ((t (:foreground ,nier-bg :background ,nier-orange))))
   `(proof-locked-face ((t (:background ,nier-blue-5))))
   `(proof-mouse-highlight-face ((t (:foreground ,nier-bg :background ,nier-orange))))
   `(proof-queue-face ((t (:background ,nier-red-4))))
   `(proof-region-mouse-highlight-face ((t (:inherit proof-mouse-highlight-face))))
   `(proof-script-highlight-error-face ((t (:background ,nier-red-2))))
   `(proof-tacticals-name-face ((t (:inherit font-lock-constant-face :foreground nil :background ,nier-bg))))
   `(proof-tactics-name-face ((t (:inherit font-lock-constant-face :foreground nil :background ,nier-bg))))
   `(proof-warning-face ((t (:foreground ,nier-bg :background ,nier-yellow-1))))
;;;;; racket-mode
   `(racket-keyword-argument-face ((t (:inherit font-lock-constant-face))))
   `(racket-selfeval-face ((t (:inherit font-lock-type-face))))
;;;;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,nier-fg))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,nier-green+4))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,nier-yellow-2))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,nier-blue))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,nier-green+2))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,nier-blue+1))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,nier-yellow-1))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,nier-green+1))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,nier-blue-2))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,nier-orange))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,nier-green))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground ,nier-blue-5))))
;;;;; rcirc
   `(rcirc-my-nick ((t (:foreground ,nier-blue))))
   `(rcirc-other-nick ((t (:foreground ,nier-orange))))
   `(rcirc-bright-nick ((t (:foreground ,nier-blue+1))))
   `(rcirc-dim-nick ((t (:foreground ,nier-blue-2))))
   `(rcirc-server ((t (:foreground ,nier-green))))
   `(rcirc-server-prefix ((t (:foreground ,nier-green+1))))
   `(rcirc-timestamp ((t (:foreground ,nier-green+2))))
   `(rcirc-nick-in-message ((t (:foreground ,nier-yellow))))
   `(rcirc-nick-in-message-full-line ((t (:weight bold))))
   `(rcirc-prompt ((t (:foreground ,nier-yellow :weight bold))))
   `(rcirc-track-nick ((t (:inverse-video t))))
   `(rcirc-track-keyword ((t (:weight bold))))
   `(rcirc-url ((t (:weight bold))))
   `(rcirc-keyword ((t (:foreground ,nier-yellow :weight bold))))
;;;;; re-builder
   `(reb-match-0 ((t (:foreground ,nier-bg :background ,nier-purple))))
   `(reb-match-1 ((t (:foreground ,nier-bg :background ,nier-blue))))
   `(reb-match-2 ((t (:foreground ,nier-bg :background ,nier-orange))))
   `(reb-match-3 ((t (:foreground ,nier-bg :background ,nier-red))))
;;;;; realgud
   `(realgud-overlay-arrow1 ((t (:foreground ,nier-green))))
   `(realgud-overlay-arrow2 ((t (:foreground ,nier-yellow))))
   `(realgud-overlay-arrow3 ((t (:foreground ,nier-orange))))
   `(realgud-bp-enabled-face ((t (:inherit error))))
   `(realgud-bp-disabled-face ((t (:inherit secondary-selection))))
   `(realgud-bp-line-enabled-face ((t (:box (:color ,nier-red :style nil)))))
   `(realgud-bp-line-disabled-face ((t (:box (:color "grey70" :style nil)))))
   `(realgud-line-number ((t (:foreground ,nier-yellow))))
   `(realgud-backtrace-number ((t (:foreground ,nier-yellow, :weight bold))))
;;;;; regex-tool
   `(regex-tool-matched-face ((t (:background ,nier-blue-4 :weight bold))))
;;;;; rmail
   `(rmail-highlight ((t (:foreground ,nier-yellow :weight bold))))
   `(rmail-header-name ((t (:foreground ,nier-blue))))
;;;;; rpm-mode
   `(rpm-spec-dir-face ((t (:foreground ,nier-green))))
   `(rpm-spec-doc-face ((t (:foreground ,nier-green))))
   `(rpm-spec-ghost-face ((t (:foreground ,nier-red))))
   `(rpm-spec-macro-face ((t (:foreground ,nier-yellow))))
   `(rpm-spec-obsolete-tag-face ((t (:foreground ,nier-red))))
   `(rpm-spec-package-face ((t (:foreground ,nier-red))))
   `(rpm-spec-section-face ((t (:foreground ,nier-yellow))))
   `(rpm-spec-tag-face ((t (:foreground ,nier-blue))))
   `(rpm-spec-var-face ((t (:foreground ,nier-red))))
;;;;; rst-mode
   `(rst-level-1-face ((t (:foreground ,nier-orange))))
   `(rst-level-2-face ((t (:foreground ,nier-green+1))))
   `(rst-level-3-face ((t (:foreground ,nier-blue-1))))
   `(rst-level-4-face ((t (:foreground ,nier-yellow-2))))
   `(rst-level-5-face ((t (:foreground ,nier-blue))))
   `(rst-level-6-face ((t (:foreground ,nier-green-2))))
;;;;; selectrum
   `(selectrum-current-candidate ((t (:foreground ,nier-yellow :weight bold :underline t))))
   `(selectrum-primary-highlight ((t (:background ,nier-green-2))))
   `(selectrum-secondary-highlight ((t (:background ,nier-green))))
;;;;; sh-mode
   `(sh-heredoc     ((t (:foreground ,nier-yellow :weight bold))))
   `(sh-quoted-exec ((t (:foreground ,nier-red))))
;;;;; show-paren
   `(show-paren-mismatch ((t (:foreground ,nier-red+1 :background ,nier-bg+3 :weight bold))))
   `(show-paren-match ((t (:foreground ,nier-fg :background ,nier-bg+3 :weight bold))))
;;;;; smart-mode-line
   ;; use (setq sml/theme nil) to enable color scheme for sml
   `(sml/global ((,class (:foreground ,nier-fg :weight bold))))
   `(sml/modes ((,class (:foreground ,nier-yellow :weight bold))))
   `(sml/minor-modes ((,class (:foreground ,nier-fg-1 :weight bold))))
   `(sml/filename ((,class (:foreground ,nier-yellow :weight bold))))
   `(sml/line-number ((,class (:foreground ,nier-blue :weight bold))))
   `(sml/col-number ((,class (:foreground ,nier-blue+1 :weight bold))))
   `(sml/position-percentage ((,class (:foreground ,nier-blue-1 :weight bold))))
   `(sml/prefix ((,class (:foreground ,nier-orange))))
   `(sml/git ((,class (:foreground ,nier-green+3))))
   `(sml/process ((,class (:weight bold))))
   `(sml/sudo ((,class  (:foreground ,nier-orange :weight bold))))
   `(sml/read-only ((,class (:foreground ,nier-red-2))))
   `(sml/outside-modified ((,class (:foreground ,nier-orange))))
   `(sml/modified ((,class (:foreground ,nier-red))))
   `(sml/vc-edited ((,class (:foreground ,nier-green+2))))
   `(sml/charging ((,class (:foreground ,nier-green+4))))
   `(sml/discharging ((,class (:foreground ,nier-red+1))))
;;;;; smartparens
   `(sp-show-pair-mismatch-face ((t (:foreground ,nier-red+1 :background ,nier-bg+3 :weight bold))))
   `(sp-show-pair-match-face ((t (:background ,nier-bg+3 :weight bold))))
;;;;; sml-mode-line
   '(sml-modeline-end-face ((t :inherit default :width condensed)))
;;;;; SLIME
   `(slime-repl-output-face ((t (:foreground ,nier-red))))
   `(slime-repl-inputed-output-face ((t (:foreground ,nier-green))))
   `(slime-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-red)))
      (t
       (:underline ,nier-red))))
   `(slime-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-orange)))
      (t
       (:underline ,nier-orange))))
   `(slime-style-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-yellow)))
      (t
       (:underline ,nier-yellow))))
   `(slime-note-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-green)))
      (t
       (:underline ,nier-green))))
   `(slime-highlight-face ((t (:inherit highlight))))
;;;;; SLY
   `(sly-mrepl-output-face ((t (:foreground ,nier-red))))
   `(sly-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-red)))
      (t
       (:underline ,nier-red))))
   `(sly-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-orange)))
      (t
       (:underline ,nier-orange))))
   `(sly-style-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-yellow)))
      (t
       (:underline ,nier-yellow))))
   `(sly-note-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,nier-green)))
      (t
       (:underline ,nier-green))))
   `(sly-stickers-placed-face ((t (:foreground ,nier-fg :background ,nier-bg+3))))
;;;;; solaire
   `(solaire-default-face ((t (:inherit default :background ,nier-bg-08))))
   `(solaire-minibuffer-face ((t (:inherit default :background ,nier-bg-08))))
   `(solaire-hl-line-face ((t (:inherit hl-line :background ,nier-bg))))
   `(solaire-org-hide-face ((t (:inherit org-hide :background ,nier-bg-08))))
;;;;; speedbar
   `(speedbar-button-face ((t (:foreground ,nier-green+2))))
   `(speedbar-directory-face ((t (:foreground ,nier-blue))))
   `(speedbar-file-face ((t (:foreground ,nier-fg))))
   `(speedbar-highlight-face ((t (:foreground ,nier-bg :background ,nier-green+2))))
   `(speedbar-selected-face ((t (:foreground ,nier-red))))
   `(speedbar-separator-face ((t (:foreground ,nier-bg :background ,nier-blue-1))))
   `(speedbar-tag-face ((t (:foreground ,nier-yellow))))
;;;;; swiper
   `(swiper-line-face ((t (:underline t))))
;;;;; sx
   `(sx-custom-button
     ((t (:background ,nier-fg :foreground ,nier-bg-1
                      :box (:line-width 3 :style released-button) :height 0.9))))
   `(sx-question-list-answers
     ((t (:foreground ,nier-green+3
                      :height 1.0 :inherit sx-question-list-parent))))
   `(sx-question-mode-accepted
     ((t (:foreground ,nier-green+3
                      :height 1.3 :inherit sx-question-mode-title))))
   '(sx-question-mode-content-face ((t (:inherit highlight))))
   `(sx-question-mode-kbd-tag
     ((t (:box (:color ,nier-bg-1 :line-width 3 :style released-button)
               :height 0.9 :weight semi-bold))))
;;;;; tabbar
   `(tabbar-button ((t (:foreground ,nier-fg
                                    :background ,nier-bg))))
   `(tabbar-selected ((t (:foreground ,nier-fg
                                      :background ,nier-bg
                                      :box (:line-width -1 :style pressed-button)))))
   `(tabbar-unselected ((t (:foreground ,nier-fg
                                        :background ,nier-bg+1
                                        :box (:line-width -1 :style released-button)))))
;;;;; tab-bar
   `(tab-bar ((t (:background ,nier-bg+1))))
   `(tab-bar-tab ((t (:foreground ,nier-fg
                                  :background ,nier-bg
                                  :weight bold
                                  :box (:line-width -1 :style released-button)))))
   `(tab-bar-tab-inactive ((t (:foreground ,nier-fg
                                           :background ,nier-bg+1
                                           :box (:line-width -1 :style released-button)))))
;;;;; tab-line
   `(tab-line ((t (:background ,nier-bg+1))))
   `(tab-line-tab ((t (:foreground ,nier-fg
                                   :background ,nier-bg
                                   :weight bold
                                   :box (:line-width -1 :style released-button)))))
   `(tab-line-tab-inactive ((t (:foreground ,nier-fg
                                            :background ,nier-bg+1
                                            :box (:line-width -1 :style released-button)))))
   `(tab-line-tab-current ((t (:foreground ,nier-fg
                                           :background ,nier-bg+1
                                           :box (:line-width -1 :style pressed-button)))))
;;;;; term
   `(term-color-black ((t (:foreground ,nier-bg
                                       :background ,nier-bg-1))))
   `(term-color-red ((t (:foreground ,nier-red-2
                                     :background ,nier-red-4))))
   `(term-color-green ((t (:foreground ,nier-green
                                       :background ,nier-green+2))))
   `(term-color-yellow ((t (:foreground ,nier-orange
                                        :background ,nier-yellow))))
   `(term-color-blue ((t (:foreground ,nier-blue-1
                                      :background ,nier-blue-4))))
   `(term-color-magenta ((t (:foreground ,nier-purple
                                         :background ,nier-red))))
   `(term-color-cyan ((t (:foreground ,nier-cyan
                                      :background ,nier-blue))))
   `(term-color-white ((t (:foreground ,nier-fg
                                       :background ,nier-fg-1))))
   '(term-default-fg-color ((t (:inherit term-color-white))))
   '(term-default-bg-color ((t (:inherit term-color-black))))
;;;;; undo-tree
   `(undo-tree-visualizer-active-branch-face ((t (:foreground ,nier-fg+1 :weight bold))))
   `(undo-tree-visualizer-current-face ((t (:foreground ,nier-red-1 :weight bold))))
   `(undo-tree-visualizer-default-face ((t (:foreground ,nier-fg))))
   `(undo-tree-visualizer-register-face ((t (:foreground ,nier-yellow))))
   `(undo-tree-visualizer-unmodified-face ((t (:foreground ,nier-blue))))
;;;;; vertico
   `(vertico-current ((t (:foreground ,nier-yellow :weight bold :underline t))))
;;;;; visual-regexp
   `(vr/group-0 ((t (:foreground ,nier-bg :background ,nier-green :weight bold))))
   `(vr/group-1 ((t (:foreground ,nier-bg :background ,nier-orange :weight bold))))
   `(vr/group-2 ((t (:foreground ,nier-bg :background ,nier-blue :weight bold))))
   `(vr/match-0 ((t (:inherit isearch))))
   `(vr/match-1 ((t (:foreground ,nier-yellow-2 :background ,nier-bg-1 :weight bold))))
   `(vr/match-separator-face ((t (:foreground ,nier-red :weight bold))))
;;;;; volatile-highlights
   `(vhl/default-face ((t (:background ,nier-bg-05))))
;;;;; web-mode
   `(web-mode-builtin-face ((t (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((t (:inherit ,font-lock-constant-face))))
   `(web-mode-css-at-rule-face ((t (:foreground ,nier-orange ))))
   `(web-mode-css-prop-face ((t (:foreground ,nier-orange))))
   `(web-mode-css-pseudo-class-face ((t (:foreground ,nier-green+3 :weight bold))))
   `(web-mode-css-rule-face ((t (:foreground ,nier-blue))))
   `(web-mode-doctype-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-folded-face ((t (:underline t))))
   `(web-mode-function-name-face ((t (:foreground ,nier-blue))))
   `(web-mode-html-attr-name-face ((t (:foreground ,nier-orange))))
   `(web-mode-html-attr-value-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-html-tag-face ((t (:foreground ,nier-blue))))
   `(web-mode-keyword-face ((t (:inherit ,font-lock-keyword-face))))
   `(web-mode-preprocessor-face ((t (:inherit ,font-lock-preprocessor-face))))
   `(web-mode-string-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-type-face ((t (:inherit ,font-lock-type-face))))
   `(web-mode-variable-name-face ((t (:inherit ,font-lock-variable-name-face))))
   `(web-mode-server-background-face ((t (:background ,nier-bg))))
   `(web-mode-server-comment-face ((t (:inherit web-mode-comment-face))))
   `(web-mode-server-string-face ((t (:inherit web-mode-string-face))))
   `(web-mode-symbol-face ((t (:inherit font-lock-constant-face))))
   `(web-mode-warning-face ((t (:inherit font-lock-warning-face))))
   `(web-mode-whitespaces-face ((t (:background ,nier-red))))
;;;;; whitespace-mode
   `(whitespace-space ((t (:background ,nier-bg+1 :foreground ,nier-bg+1))))
   `(whitespace-hspace ((t (:background ,nier-bg+1 :foreground ,nier-bg+1))))
   `(whitespace-tab ((t (:background ,nier-red-1))))
   `(whitespace-newline ((t (:foreground ,nier-bg+1))))
   `(whitespace-trailing ((t (:background ,nier-red))))
   `(whitespace-line ((t (:background ,nier-bg :foreground ,nier-purple))))
   `(whitespace-space-before-tab ((t (:background ,nier-orange :foreground ,nier-orange))))
   `(whitespace-indentation ((t (:background ,nier-yellow :foreground ,nier-red))))
   `(whitespace-empty ((t (:background ,nier-yellow))))
   `(whitespace-space-after-tab ((t (:background ,nier-yellow :foreground ,nier-red))))
;;;;; wanderlust
   `(wl-highlight-folder-few-face ((t (:foreground ,nier-red-2))))
   `(wl-highlight-folder-many-face ((t (:foreground ,nier-red-1))))
   `(wl-highlight-folder-path-face ((t (:foreground ,nier-orange))))
   `(wl-highlight-folder-unread-face ((t (:foreground ,nier-blue))))
   `(wl-highlight-folder-zero-face ((t (:foreground ,nier-fg))))
   `(wl-highlight-folder-unknown-face ((t (:foreground ,nier-blue))))
   `(wl-highlight-message-citation-header ((t (:foreground ,nier-red-1))))
   `(wl-highlight-message-cited-text-1 ((t (:foreground ,nier-red))))
   `(wl-highlight-message-cited-text-2 ((t (:foreground ,nier-green+2))))
   `(wl-highlight-message-cited-text-3 ((t (:foreground ,nier-blue))))
   `(wl-highlight-message-cited-text-4 ((t (:foreground ,nier-blue+1))))
   `(wl-highlight-message-header-contents-face ((t (:foreground ,nier-green))))
   `(wl-highlight-message-headers-face ((t (:foreground ,nier-red+1))))
   `(wl-highlight-message-important-header-contents ((t (:foreground ,nier-green+2))))
   `(wl-highlight-message-header-contents ((t (:foreground ,nier-green+1))))
   `(wl-highlight-message-important-header-contents2 ((t (:foreground ,nier-green+2))))
   `(wl-highlight-message-signature ((t (:foreground ,nier-green))))
   `(wl-highlight-message-unimportant-header-contents ((t (:foreground ,nier-fg))))
   `(wl-highlight-summary-answered-face ((t (:foreground ,nier-blue))))
   `(wl-highlight-summary-disposed-face ((t (:foreground ,nier-fg
                                                         :slant italic))))
   `(wl-highlight-summary-new-face ((t (:foreground ,nier-blue))))
   `(wl-highlight-summary-normal-face ((t (:foreground ,nier-fg))))
   `(wl-highlight-summary-thread-top-face ((t (:foreground ,nier-yellow))))
   `(wl-highlight-thread-indent-face ((t (:foreground ,nier-purple))))
   `(wl-highlight-summary-refiled-face ((t (:foreground ,nier-fg))))
   `(wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))
;;;;; which-func-mode
   `(which-func ((t (:foreground ,nier-green+4))))
;;;;; window-tool-bar-mode
   `(window-tool-bar-button ((t (:foreground ,nier-fg
                                             :background ,nier-bg
                                             :box (:line-width -1 :style released-button)))))
   `(window-tool-bar-button-hover ((t (:foreground ,nier-fg
                                                   :background ,nier-bg+1
                                                   :box (:line-width -1 :style released-button)))))
   `(window-tool-bar-button-disabled ((t (:foreground ,nier-fg
                                                      :background ,nier-bg+3
                                                      :box (:line-width -1 :style released-button)))))
;;;;; xcscope
   `(cscope-file-face ((t (:foreground ,nier-yellow :weight bold))))
   `(cscope-function-face ((t (:foreground ,nier-blue :weight bold))))
   `(cscope-line-number-face ((t (:foreground ,nier-red :weight bold))))
   `(cscope-mouse-face ((t (:foreground ,nier-bg :background ,nier-blue+1))))
   `(cscope-separator-face ((t (:foreground ,nier-red :weight bold
                                            :underline t :overline t))))
;;;;; yascroll
   `(yascroll:thumb-text-area ((t (:background ,nier-bg-1))))
   `(yascroll:thumb-fringe ((t (:background ,nier-bg-1 :foreground ,nier-bg-1))))
   ))

;;; Theme Variables
(nier-automata-with-color-variables
  (custom-theme-set-variables
   'nier-automata
;;;;; ansi-color
   `(ansi-color-names-vector [,nier-bg ,nier-red ,nier-green ,nier-yellow
                                       ,nier-blue ,nier-purple ,nier-cyan ,nier-fg])
;;;;; company-quickhelp
   `(company-quickhelp-color-background ,nier-bg+1)
   `(company-quickhelp-color-foreground ,nier-fg)
;;;;; fill-column-indicator
   `(fci-rule-color ,nier-bg-05)
;;;;; nrepl-client
   `(nrepl-message-colors
     '(,nier-red ,nier-orange ,nier-yellow ,nier-green ,nier-green+4
                 ,nier-cyan ,nier-blue+1 ,nier-purple))
;;;;; pdf-tools
   `(pdf-view-midnight-colors '(,nier-fg . ,nier-bg-05))
;;;;; vc-annotate
   `(vc-annotate-color-map
     '(( 20. . ,nier-red-1)
       ( 40. . ,nier-red)
       ( 60. . ,nier-orange)
       ( 80. . ,nier-yellow-2)
       (100. . ,nier-yellow-1)
       (120. . ,nier-yellow)
       (140. . ,nier-green-2)
       (160. . ,nier-green)
       (180. . ,nier-green+1)
       (200. . ,nier-green+2)
       (220. . ,nier-green+3)
       (240. . ,nier-green+4)
       (260. . ,nier-cyan)
       (280. . ,nier-blue-2)
       (300. . ,nier-blue-1)
       (320. . ,nier-blue)
       (340. . ,nier-blue+1)
       (360. . ,nier-purple)))
   `(vc-annotate-very-old-color ,nier-purple)
   `(vc-annotate-background ,nier-bg-1)
   ))

;;; Rainbow Support

(declare-function rainbow-mode 'rainbow-mode)
(declare-function rainbow-colorize-by-assoc 'rainbow-mode)

(defcustom nier-automata-add-font-lock-keywords nil
  "Whether to add font-lock keywords for nier color names.

In buffers visiting library `nier-automata-theme.el' the nier
specific keywords are always added, provided that library has
been loaded (because that is where the code that does it is
defined).  If you visit this file and only enable the theme,
then you have to turn `rainbow-mode' off and on again for the
nier-specific font-lock keywords to be used.

In all other Emacs-Lisp buffers this variable controls whether
this should be done.  This requires library `rainbow-mode'."
  :type 'boolean
  :group 'nier-automata-theme)

(defvar nier-automata-colors-font-lock-keywords nil)

(defun nier-automata--rainbow-turn-on ()
  "Maybe also add font-lock keywords for nier colors."
  (when (and (derived-mode-p 'emacs-lisp-mode)
             (or nier-automata-add-font-lock-keywords
                 (and (buffer-file-name)
                      (equal (file-name-nondirectory (buffer-file-name))
                             "nier-automata-theme.el"))))
    (unless nier-automata-colors-font-lock-keywords
      (setq nier-automata-colors-font-lock-keywords
            `((,(regexp-opt (mapcar 'car nier-automata-default-colors-alist) 'words)
               (0 (rainbow-colorize-by-assoc nier-automata-default-colors-alist))))))
    (font-lock-add-keywords nil nier-automata-colors-font-lock-keywords 'end)))

(defun nier-automata--rainbow-turn-off ()
  "Also remove font-lock keywords for nier colors."
  (font-lock-remove-keywords nil nier-automata-colors-font-lock-keywords))

(when (fboundp 'advice-add)
  (advice-add 'rainbow-turn-on :after  #'nier-automata--rainbow-turn-on)
  (advice-add 'rainbow-turn-off :after #'nier-automata--rainbow-turn-off))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'nier-automata)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (require 'rainbow-mode nil t) (rainbow-mode 1))
;; End:
;;; nier-automata-theme.el ends here
