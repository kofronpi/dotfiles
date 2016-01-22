#!/bin/bash
# AUTHOR:
#   Pierre-Alexandre Kofron
source ~/.bash_colors

function is_ruby_folder {
  [[ -f 'Gemfile' || -f 'config.rb' ]]
}

function is_node_folder {
  [ -f 'package.json' ]
}

function is_elixir_folder {
  [ -f 'mix.exs' ]
}

function is_git_repository {
  git branch > /dev/null 2>&1
}

function parse_ruby_version {
  ruby -v | cut -d" " -f2
}

# Determine the branch/state information for this git repository.
#   Based on work by Scott Woods <scott@westarete.com>
#   http://gist.github.com/657287
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${Green}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${IYellow}"
  else
    state="${IRed}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # Get the name of the branch.
  # branch_pattern="^# On branch ([^${IFS}]*)"
  # if [[ ${git_status} =~ ${branch_pattern} ]]; then
  #   branch=${BASH_REMATCH[1]}
  # fi

  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch_pattern='detached*'
    fi
    branch_pattern="($branch)"
    if [[ "$(git rev-parse --git-dir)" == "$HOME/.git" ]]; then
      branch_pattern=""
    fi
  else
    branch_pattern=""
  fi

  # Set the final branch string.
  BRANCH="${state}(${branch})${remote}${Color_Off}"
}

# Set the full bash prompt.
function set_bash_prompt () {

  # Set the node version
  if is_node_folder ; then
    NODE=`node -v`
  else
    NODE=""
  fi

  # Set the elixir version
  if is_elixir_folder ; then
    ELIXIR="$ELIXIR_VERSION"
  else
    ELIXIR=""
  fi

  # Set the ruby version
  if is_ruby_folder ; then
    RUBY="$(parse_ruby_version)";
  else
    RUBY=""
  fi

  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi

  # Set the bash prompt variable.
  PS1="\u@\h \[${Green}\]${RUBY}${NODE} \[${Yellow}\]λ \[${Green}\]${ELIXIR} \[${Yellow}\]\W \[${BRANCH}\] \[${White}\]$ "

}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
