#!C:\Program Files\Git\bin\sh.exe

cat > .git/hooks/prepare-commit-msg <<- "EOF"
#!C:\Program Files\Git\bin\sh.exe
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2> /dev/null | grep -oE "[a-z]+[/]")

if [[ $BRANCH_NAME =~ feature ]]; then
sed -i.bak -e "1s/$/[+semver: minor] /" $1
elif [[ $BRANCH_NAME =~ patch|bug|hotfix ]]; then
sed -i.bak -e "1s/$/[+semver: patch] /" $1
else
        echo "Aborting commit due to empty commit message."
        exit 1
fi
EOF