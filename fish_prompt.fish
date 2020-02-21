function fish_prompt
  # Cache exit status
  set -l last_status $status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end
  
  # Setup colors
  set -l normal (set_color normal)
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l bpurple (set_color -o purple)
  set -l bred (set_color -o red)
  set -l bcyan (set_color -o cyan)
  set -l bwhite (set_color -o white)

  # Configure __fish_git_prompt
  set -g __fish_git_prompt_show_informative_status true
  set -g __fish_git_prompt_char_dirtystate "+"
  set -g __fish_git_prompt_char_untrackedfiles ".."
  set -g __fish_git_prompt_char_invalidstate "x"
  set -g __fish_git_prompt_char_cleanstate "clean"
  set -g __fish_git_prompt_char_upstream_ahead "|up+"
  set -g __fish_git_prompt_char_upstream_behind "|up-"

  set -g __fish_git_prompt_showcolorhints true

  # Color prompt char red for non-zero exit status


  if [ $last_status -ne 0 ]
    set -g __fish_prompt_char [$last_status]»
    set pcolor $bred
  else
    set -g __fish_prompt_char »
    set pcolor $cyan
  end
    

  # Top
  echo -n $cyan$USER$normal at $yellow$__fish_prompt_hostname$normal in $bred(prompt_pwd)$normal
  __fish_git_prompt

  echo

  # Bottom
  echo -n $pcolor$__fish_prompt_char $normal
end
