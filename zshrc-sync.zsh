# zshrc-sync.zsh

# Check if ZSHRC_REPO_URL and ZSHRC_FILE_PATH are set
if [[ -z "${ZSHRC_REPO_URL}" || -z "${ZSHRC_FILE_PATH}" ]]; then
    echo "Please set the ZSHRC_REPO_URL and ZSHRC_FILE_PATH variables in your .zshrc file."
    return 1
fi

# Sync .zshrc file to the GitHub repository
function sync_zshrc() {
    # Check if the Git repository has been initialized
    if [ ! -d "$HOME/.zshrc-sync" ]; then
        git clone ${ZSHRC_REPO_URL} "$HOME/.zshrc-sync"

        # Backup the current .zshrc file
        cp "${ZSHRC_FILE_PATH}" "$HOME/.zshrc-bak"

        # Copy the current .zshrc file to the Git repository
        cp "${ZSHRC_FILE_PATH}" "$HOME/.zshrc-sync/.zshrc"

        # Create a symlink to the .zshrc file in the Git repository
        ln -sf "$HOME/.zshrc-sync/.zshrc" "${ZSHRC_FILE_PATH}"
    fi

    # Check if there are any changes between the local and remote .zshrc files
    cd "$HOME/.zshrc-sync"
    git fetch
    if ! git diff HEAD origin/main -- .zshrc &>/dev/null; then
        # Remote .zshrc is different, overwrite the local file
        git checkout origin/main -- .zshrc
        cp "$HOME/.zshrc-sync/.zshrc" "${ZSHRC_FILE_PATH}"
        echo "Local .zshrc file has been updated from the remote repository."
    else
        # Local .zshrc is different or the same, push the local changes
        if [ -n "$(git status --porcelain)" ]; then
            # Add the changes to the Git repository
            git add .zshrc
            timestamp=$(date +"%Y-%m-%d %H:%M:%S")
            git commit -m "Update .zshrc (${timestamp})"
            git push
            echo "Local .zshrc file has been pushed to the remote repository."
        else
            echo "No changes to .zshrc, skipping commit and push."
        fi
    fi
}

# Automatically sync the .zshrc file when it's modified
function zshrc_modified() {
    sync_zshrc
    sleep 1
}
autoload -Uz add-zsh-hook
add-zsh-hook zshexit zshrc_modified