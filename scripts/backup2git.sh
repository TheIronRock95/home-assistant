# get the HA version and set ha version, current date and custom message. 
HA_VERSION=`cat .HA_VERSION`
COMMIT_DATE=$(date +'%d-%m-%Y %H:%M:%S')
COMMIT_MESSAGE="Autocommit from HA - [$HA_VERSION]: $COMMIT_DATE"

echo "$COMMIT_MESSAGE"

git add .
git commit -m "$COMMIT_MESSAGE"
git push