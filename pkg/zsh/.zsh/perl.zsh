#!/bin/zsh

# System Perl environment variables
export PERL5LIB="${HOME}/.perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="${HOME}/.perl5"
export PERL_MB_OPT="--install_base ${HOME}/.perl5"
export PERL_MM_OPT="INSTALL_BASE=${HOME}/.perl5"

# Perlbrew environment variables
export PERLBREW_ROOT="/opt/perl5"
export PATH="${PERLBREW_ROOT}/bin:${PATH}"
if command -v perlbrew &>/dev/null; then
    source "${PERLBREW_ROOT}/etc/bashrc"
fi
