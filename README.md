# zshrc-sync

A zsh plugin that automatically detects changes to the `.zshrc` file and syncs it to the GitHub repository when zsh exits.

## Features

- Automatically detects changes to the `.zshrc` file and syncs it to the GitHub repository.
- Automatically syncs the `.zshrc` file when zsh exits.
- Backs up the current `.zshrc` file to `$HOME/.zshrc-bak`.
- Uses a symbolic link to link the `.zshrc` file to the copy in the GitHub repository.

## Installation

1. Ensure that Git is installed.
2. Set the following variables in your `.zshrc` file:
   - `ZSHRC_REPO_URL`: The URL of your GitHub repository.
   - `ZSHRC_FILE_PATH`: The full path to your `.zshrc` file.

    For example:
    ```zsh
    export ZSHRC_REPO_URL='git@github.com:usename/myzshrc.git'
    export ZSHRC_FILE_PATH="$HOME/.zshrc"
    ```

3. Install the plugin using `zplug`:

   ```zsh
   zplug "Skylor-Tang/zshrc-sync", use:zshrc-sync.zsh
   ```

4. Reload the zsh configuration file:

   ```zsh
   source ~/.zshrc
   ```

## Usage

The plugin will automatically detects changes to the `.zshrc` file and syncs it to the GitHub repository when zsh exits.

You can manually call the `sync_zshrc()` function to immediately sync the `.zshrc` file.

## Notes

- Ensure that the `ZSHRC_REPO_URL` and `ZSHRC_FILE_PATH` variables are set correctly.
- The plugin will create a Git repository in the `$HOME/.zshrc-sync` directory, so make sure this directory is writable.
- The plugin will back up the current `.zshrc` file to `$HOME/.zshrc-bak`.

## License

This project is licensed under the MIT License.
