| Name| Expansion | Description
| ------------- |:-------------:| -------------:|
| GMC      | Get My Changes | Download the changes from a sandbox / production based on build.properties specified 
| DB      | Download Branch | Download the branch into the repo folder, reduce the overhead of pulling entire repo.
| M&S | Merge & Stage | Collect your changes, intelligently merge it with the same file inside your main repo. you dont have to worry about accidentally overriding files, it has logic built in.
| CS | Compress Single | Compress the profile/permissionset/object/label xml file in a way it represents 1 node per line. This greatly reduces merge conflicts for selected file.
| JT | Just True Single | Just true Single applies the compression logic described above and removes the false values from profile,permissionset for selected file.
| CS-A| Compress All | Run the compression logic for all profiles,permissionsets,labels,objects in the repo.
| JT-A| Just True All | Run the JustTrue logic described above on profiles and permission sets. Along with compression on labels and objects.
