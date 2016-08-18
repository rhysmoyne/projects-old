#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILDER="$DIR/codeclub_lesson_builder"
# add reference to repo in commit message
REPLACE="Merge pull request "
REPLACE_WITH="CreativeKids/projects"

echo "pulling changes"
# do not pull changes while in dir
#cd $DIR/.. && \
#git -C $DIR pull && \
#git -C $BUILDER fetch origin master && \
#git -C $BUILDER merge --no-edit FETCH_HEAD && \
MESSAGE="$(git -C $DIR log -1 --pretty=%B)" && \
COMMIT_MSG="${MESSAGE/$REPLACE/$REPLACE_WITH}" && \
#cd $BUILDER && \
#npm install

echo "build and push"
cd $DIR && \
git clone git@github.com:CreativeKids/creativekidssa.com.au.git && \
./gulp dist && \
cp -r build/* creativekidssa.com.au/projects && \
cd creativekidssa.com.au && \
echo "# Creative Kids Projects" > projects/README.md && \
echo "Note: Do NOT edit the files in this subdirectory." >> projects/README.md && \
echo "This directory is synced with the projects at https://github.com/CreativeKids/projects" >> projects/README.md && \
git add --all . && \
git commit -m "$COMMIT_MSG" && \
git push && \
cd .. && \
rm -rf creativekidssa.com.au
