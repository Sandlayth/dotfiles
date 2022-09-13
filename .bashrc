# ~/.bashrc
#

# Variables
if [ -f ./.bash_variables ]; then
    . ~/.bash_variables
fi


# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Functions
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

# FuzzyFinder
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi

# Completion scripts
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

