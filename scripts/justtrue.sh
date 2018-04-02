echo 'deleting previous backups, I know I have an OCD'
rm -rf repo/profiles/*.bak repo/permissionsets/*.bak repo/labels/*.bak repo/objects/*.bak
echo 'starting to compress the xml files, it saves space and reduces conflict for others'
echo 'Fair warning before I begin, its gonna take atleast 40-50 seconds on a mac, may be around 3 minutes on windows'
echo 'compressing files first to be able to remove lines easily later'
perl -i.bak -p scripts/profileCompress.pl repo/profiles/*.profile repo/permissionsets/*.permissionset repo/objects/*.object repo/labels/*.labels
echo 'removing the backup files generated'
rm -rf repo/profiles/*.bak repo/permissionsets/*.bak repo/labels/*.bak repo/objects/*.bak repo/labels/*.bak
echo 'Now just retaining true values'
perl -i.bak -p scripts/removeFalseValues.pl repo/profiles/*.profile repo/permissionsets/*.permissionset
echo 'we finished generating compressed files, lets delete the .bak files, you wont need them'
rm -rf repo/profiles/*.bak repo/permissionsets/*.bak repo/labels/*.bak
echo 'done'