#! /usr/bin/env bash
set -euo pipefail

# Helper commands (@TODO make them look better)
print_error() { echo -e "\e[1;91m[Error]\e[0m" $@; }
print_info() { echo -e $@; }

assert_exist() {
    local path=$1
    local name=$2
    if [ -z $path ]; then
        print_error "❌ $name is not installed."
        exit 1
    fi 
}

print_info "Setting up Git..."
GIT=$(which git)
assert_exist $GIT "Git"
git config --global core.autocrlf false

print_info "Setting up Mise-en-place..."
MISE=$(which mise);
assert_exist $MISE "Mise-en-Place"
$MISE trust .
$MISE install
echo "eval \"\$($MISE activate bash --shims)\"" >> ~/.bashrc

print_info "Setting up UV (Dependencies)..."
$MISE run Sync
echo "source $ACTIVATE_PATH" >> ~/.bashrc