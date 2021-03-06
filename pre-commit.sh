#!/bin/bash

cat > .git/hooks/prepare-commit-msg <<- "EOF"
#!/usr/bin/env bash

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2> /dev/null | grep -oE "[a-z]+[/]")

if [ "$BRANCH_NAME" = "feature/" ]; then
sed -i.bak -e "1s/^/feat(): /" $1
elif [ "$BRANCH_NAME" = "patch/" ] || [ "$BRANCH_NAME" = "hotfix/" ] || [ "$BRANCH_NAME" = "bug/" ]; then
sed -i.bak -e "1s/^/fix(): /" $1
elif [ "$BRANCH_NAME" = "breaking/" ]; then
sed -i.bak -e "1s/^/perf(): /" $1
sed -i.bak -e "s/$/\n BREAKING CHANGE: /" $1
else
        echo "Aborting commit due to improper commit message structure."
        exit 1
fi

EOF