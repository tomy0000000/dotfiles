#!/bin/bash
set -euo pipefail

# Install cling CLI if not installed yet
exist cling || brew install cling
