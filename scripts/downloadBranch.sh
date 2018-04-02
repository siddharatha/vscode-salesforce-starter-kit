branchname=$(cat 'build.properties' | grep 'branchname' | cut -d'=' -f2)
repourl=$(cat 'build.properties' | grep 'repourl' | cut -d'=' -f2)
echo 'my branch name is '$branchname
echo 'my repo url is '$repourl
echo 'am gonna clone only this branch , alone.'
git clone $repourl repo --single-branch --branch $branchname --depth=1 -v
echo 'done'