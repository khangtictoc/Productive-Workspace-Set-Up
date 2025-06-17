git config --global user.name "<your name>"
git config --global user.email "<your email>"

git rebase -r <some commit before all of your bad commits> \
    --exec 'git commit --amend --no-edit --reset-author'

# View all changed files in a specific commit
git show --name-only <commit-hash>