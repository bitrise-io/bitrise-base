#!/bin/bash

echo
echo "=== Pre-installed tool versions ========"
echo "* Go: $(go version)"
echo "* Ruby: $(ruby --version)"
echo "========================================"
echo

echo
echo "=== Other sys infos ===================="
echo "* Free disk space: $( df -kh / | grep '/' )"
echo "========================================"
echo
