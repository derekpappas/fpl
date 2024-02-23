(defface font-lock-dbg-face
  '((((class color) (background light)) (:foreground "White"))
    (((class color) (background dark)) (:foreground "White"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for OOo Debug messages."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-dbg-face		'font-lock-dbg-face
  "Face name to use for OOo Debug messages.")

(defface font-lock-throws-face
  '((((class color) (background light)) (:foreground "White"))
    (((class color) (background dark)) (:bold t :foreground "yellow" :weight bold))
    (t (:bold t :italic t)))
  "Font Lock mode face used for OOo THROWS statements."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-throws-face		'font-lock-throws-face
  "Face name to use for OOo THROWS statements.")

(defface font-lock-bugid-face
  '((((class color) (background light)) (:foreground "DarkRed"))
    (((class color) (background dark)) (:bold t :foreground "Red" :weight bold))
    (t (:bold t :italic t)))
  "Font Lock mode face used for OOo BugIDs."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-bugid-face		'font-lock-bugid-face
  "Face name to use for OOo BugIDs.")

(defface font-lock-sid-face
  '((((class color) (background light)) (:foreground "Aquamarine4"))
    (((class color) (background dark)) (:bold t :foreground "SteelBlue1" :weight bold))
    (t (:bold t :italic t)))
  "Font Lock mode face used for OOo Slot IDs."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-sid-face		'font-lock-sid-face
  "Face name to use for OOo Slot IDs.")

(defface font-lock-brace-face
  '((((class color) (background light)) (:foreground "Red2"))
    (((class color) (background dark)) (:foreground "White"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for braces ()[]{} and the comma."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-brace-face		'font-lock-brace-face
  "Face name to use for braces.")

(defface font-lock-bool-face
  '((((class color) (background light)) (:foreground "forest green"))
    (((class color) (background dark)) (:foreground "lime green"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for boolean operators."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-bool-face		'font-lock-bool-face
  "Face name to use for boolean operators.")

(defface font-lock-exit-face
  '((((class color) (background light)) (:background "ivory1" :foreground "blue3"))
    (((class color) (background dark)) (:bold t :foreground "green4" :weight bold))
    (t (:bold t)))
  "Font Lock mode face used for exit operations like return, break and exit."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-exit-face		'font-lock-exit-face
  "Face name to use for exit operations like return, break and exit.")

(defface font-lock-tag-face
  '((t (:foreground "dodger blue")))
  "Font Lock mode face used for tags in IDL files."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-tag-face		'font-lock-tag-face
  "Face name to use for tags in IDL files.")

(defconst bm-throw-face-keywords
  (cons
   (concat "\\b"
	(regexp-opt
	 (list
	  "m_"
	  ))
	"\\sw+\\b")
   font-lock-dbg-face
  ))

(defconst bm-additional-constant-keywords
  (cons
   (regexp-opt
	(list
	 "TRUE" "FALSE" "ASSERT" "DCERR" "DCOUT" "true" "false" "assert" "dcerr" "dcout"
	 ) 'words)
   font-lock-throws-face
  ))
(defconst bm-strparam-keywords
  (cons
   (concat ""
   (regexp-opt
	(list
	 "// TODO" "todo" "//TODO"
	 ))
   "\\sw+")
   font-lock-throws-face
  ))
(defconst bm-exit-keywords
  (cons
   (regexp-opt
	(list
	 "void"
	 ) 'words)
   font-lock-exit-face
  ))
(defconst bm-assert-keywords
  (cons
   (concat "\\b"
	(regexp-opt
	 (list
	  "E" "T"
	  ))
	"\\sw+\\b")
   font-lock-exit-face
  ))
(defconst bm-assert1-keywords
  (cons
   (concat "\\b"
	(regexp-opt
	 (list
	  "Ref"
	  ))
	"\\sw+\\b")
   font-lock-exit-face
  ))

(defconst bm-assert2-keywords
  (cons
   (concat "\\b"
	(regexp-opt
	 (list
	  "Weak"
	  ))
	"\\sw+\\b")
   font-lock-exit-face
  ))

(defconst bm-enum-or-constints-keywords
  (cons
   (concat "\\b\\([A-Z0-9]+_\\)*[A-Z0-9]+"
	(regexp-opt
	 (list
	  ""
	  ))
	"\\b")
   font-lock-sid-face
  ))

(defconst bm-const-keywords
  (list
   "\\<\\(\\(S\\|W\\)ID\\)_\\(\\sw+\\)"
   '(1 font-lock-sid-face)
   '(3 font-lock-constant-face)
  ))
(defconst bm-brace-keywords
  (cons
   "[][(){}]"
   font-lock-brace-face
  ))
(defconst bm-operator-keywords
  (cons
   "[|&]+"
   font-lock-bool-face
  ))

(defconst bm-idl-property-flags
  (cons
   (regexp-opt
	(list
	 "cerr" "cout" "goto" "continue" "todo" "TODO" 
	 ) 'words)
   font-lock-bugid-face
  ))

(font-lock-add-keywords
 'global-font-lock-mode
 (list
  bm-idl-property-flags
  bm-additional-constant-keywords
  bm-enum-or-constints-keywords
  bm-brace-keywords
  bm-operator-keywords
  bm-exit-keywords
  bm-const-keywords
  bm-throw-face-keywords
  bm-assert-keywords
  bm-assert1-keywords
  bm-assert2-keywords
  bm-strparam-keywords
  ))

(font-lock-add-keywords
 'c++-mode
 (list
  bm-idl-property-flags
  bm-additional-constant-keywords
  bm-enum-or-constints-keywords
  bm-brace-keywords
  bm-operator-keywords
  bm-exit-keywords
  bm-const-keywords
  bm-throw-face-keywords
  bm-assert-keywords
  bm-assert1-keywords
  bm-assert2-keywords
  bm-strparam-keywords
  ))


(defconst bm-idl-keywords
  (cons
   (concat "\\b"
	(regexp-opt
	 (list
	  "m_"
	  ))
	"\\sw+\\b")
   font-lock-dbg-face
  ))

(defconst bm-idl-unused-keywords
  (cons
   (regexp-opt
	(list
     "e" "se"
	 ) 'words)
   font-lock-throws-face
  ))
(defconst bm-idl-types
  (cons
   (regexp-opt
	(list
	 ""
	 ) 'words) font-lock-type-face ) )
(defconst bm-idl-builtin
  (cons
   (regexp-opt
	(list
	 "ifndef" "include" "endif" "define"
	 ) 'words)
   font-lock-builtin-face
  ))

;; Add the keyword groups you want to show
(font-lock-add-keywords
 'idl-mode
 (list
  bm-idl-keywords
  bm-idl-types
  bm-idl-builtin
  bm-brace-keywords
  bm-idl-unused-keywords
))

(font-lock-add-keywords
 'idl-mode
 '(( "\\(</?\\)\\(atom\\|type\\|member\\|const\\|listing\\)\\(>\\)"
	 (1 font-lock-tag-face)
	 (2 font-lock-constant-face)
	 (3 font-lock-tag-face))
   ( "\\(@\\)\\(author\\|see\\|param\\|throws\\|returns?\\|version\\)"
	 (1 font-lock-tag-face)
	 (2 font-lock-constant-face))
 ))

