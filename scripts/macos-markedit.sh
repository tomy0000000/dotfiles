#!/bin/bash
set -euo pipefail

###############################################################################
# Editor                                                                      #
###############################################################################

# Light Theme: GitHub (Light)
defaults write app.cyan.markedit editor.light-theme -data 226769746875622d6c6967687422

# Dark Theme: Dracula
defaults write app.cyan.markedit editor.dark-theme -data 2264726163756c6122

###############################################################################
# Assistant                                                                   #
###############################################################################

# Format Files -> Insert final newline: On
defaults write app.cyan.markedit assistant.insert-final-newline -data 74727565

# Format Files -> Trim trailing whitespace: On
defaults write app.cyan.markedit assistant.trim-trailing-whitespace -data 74727565

###############################################################################
# General                                                                     #
###############################################################################

# New Window Behavior: New Document
defaults write app.cyan.markedit general.new-window-behavior -data 7b226e6577446f63756d656e74223a7b7d7d
