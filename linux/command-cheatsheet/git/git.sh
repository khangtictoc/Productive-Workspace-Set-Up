git config --global user.name "username"
git config --global user.email "user@gmail.com"

git rebase -r <some commit before all of your bad commits> \
    --exec 'git commit --amend --no-edit --reset-author'