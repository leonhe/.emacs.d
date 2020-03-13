((magit-branch nil)
 (magit-cherry-pick
  ("--ff"))
 (magit-commit nil
	       ("--signoff"))
 (magit-diff
  ("--no-ext-diff" "--stat"))
 (magit-dispatch nil)
 (magit-fetch nil)
 (magit-gitignore nil)
 (magit-log
  ("-n256" "--graph" "--decorate")
  ("-n256" "--graph" "--color" "--decorate")
  ("-n256" "--graph" "--color" "--decorate" "--show-signature")
  ("-n256" "--graph" "--color" "--decorate" "--show-signature" "++header")
  ("-n256" "--follow" "--graph" "--color" "--decorate" "--show-signature")
  ("-n256" "--graph" "--decorate" "--show-signature")
  ("-n256" "--graph" "--decorate" "--show-signature" "--stat"))
 (magit-merge nil)
 (magit-push nil)
 (magit-rebase nil)
 (magit-stash nil)
 (magit-svn nil))
