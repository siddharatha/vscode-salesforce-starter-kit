s/^<applicationVisibilities\>.*<visible\>false.*//; 
s/^<classAccesses\>.*<enabled\>false.*//; 
s/^<pageAccesses\>.*<enabled\>false.*//; 
s/^<recordTypeVisibilities\>.*<visible\>false.*//; 
s/^<tabVisibilities\>.*<visibility\>Hidden.*//; 
s/^<tabSettings\>.*<visibility\>None.*//; 
s/^<fieldPermissions\>.*<editable\>false.*<readable\>false.*//; 
s/^<objectPermissions\>.*<allowCreate\>false.*<allowDelete\>false.*<allowEdit\>false.*<allowRead\>false.*<modifyAllRecords\>false.*<viewAllRecords\>false.*//; 
BEGIN { $\ = undef; }
s/\r//g;                  # remove all CR characters
s/\t/    /g;              # replace all tabs with 4 spaces
if (/^\s/) {              # ignore the the xml root node
  s/\n//;                 # remove newlines
  s/^    (?=<(?!\/))/\n/; # insert newlines where appropriate
  s/^(    )+//;		      # trim remaining whitespace
  s/^(        )+//;     # trim special spaces    
}