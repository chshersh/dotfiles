#!/bin/bash

SESSION_NAME="tui"
WORKING_DIR="ocaml/github-tui"

# Check if the session exists
if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
  # Create new session with window 'git'
  tmux new-session -d -s $SESSION_NAME -n git
  tmux send-keys -t $SESSION_NAME "cd $WORKING_DIR && eval \$(opam env)" C-m

  # Create new window named 'dune'
  tmux new-window -t $SESSION_NAME -n dune
  tmux send-keys -t $SESSION_NAME:dune "cd $WORKING_DIR && eval \$(opam env)" C-m
  tmux send-keys -t $SESSION_NAME:dune "dune exec bin/main.exe -- chshersh/github-tui --directory=../github-tui"
fi

tmux select-window -t $SESSION_NAME:git
tmux attach-session -t $SESSION_NAME
