# Change all commits to a specific author name and email
git filter-repo  --name-callback '\nreturn b"<AUTHOR_NAME>"\n' --email-callback '\nreturn b"<AUTHOR_EMAIL>"\n'

# Change filtered commits to a specific email address
git filter-repo --force \
    --email-callback '
if email == b"khang.tran@mercatus.com":
    return b"tranhoangkhang09112001@gmail.com"
return email
'

git filter-repo --commit-callback '
if commit.hexsha == "425800aae9a787064cc777b6c35f2a4f2f2d095a":
    commit.skip()'