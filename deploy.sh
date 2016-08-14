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
git clone git@github.com:CreativeKids/creativekids.github.io.git && \
./gulp dist && \
cp -r build/* creativekids.github.io && \
cd creativekids.github.io && \
git add --all . && \
git commit -m "$COMMIT_MSG" && \
git push && \
cd .. && \
rm -rf creativekids.github.io/
