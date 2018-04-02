BEGIN { $\ = undef; }
s/\r//g;                  # remove all CR characters
s/\t/    /g;              # replace all tabs with 4 spaces
s/^<userPermissions\>.*//;  
s/^<loginIpRanges\>.*//;  
if (/^\s/) {              # ignore the the xml root node
  s/\n//;                 # remove newlines
  s/^    (?=<(?!\/))/\n/; # insert newlines where appropriate
  s/^(    )+//;		      # trim remaining whitespace
  s/^(        )+//;     # trim special spaces    
}
# s/^<userPermissions>//; # remove user permissions
s/<\/Profile>/\n\n<\/Profile>/;
s/<\/PermissionSet>/\n\n<\/PermissionSet>/;
s/<\/CustomLabels>/\n\n<\/CustomLabels>/;
s/<\/CustomObject>/\n\n<\/CustomObject>/;

