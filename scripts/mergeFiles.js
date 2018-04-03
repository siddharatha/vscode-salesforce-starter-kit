var fs = require('fs');
var child_process = require('child_process');
var path = require('path');
// print process.argv
const relativefilename = process.argv[2];
if(relativefilename){     
    if(relativefilename.startsWith('src')){
        const splits=relativefilename.split('/');        
        const folder=splits[1];
        switch(folder){
            case 'permissionsets':
            console.log('its perm sets, we merge');
            console.log('we compress first');
            child_process.execSync(`perl -i.bak -p scripts/profileCompress.pl "${relativefilename}"`);
            const targetfilename = 'repo/'+splits[1]+'/'+splits[2];
            if(fs.existsSync(targetfilename)){                
                //child_process.execSync(`perl -i.bak -p scripts/profileCompress.pl "${targetfilename}"`);
                //child_process.execSync(`cat "${relativefilename}" >> "${targetfilename}" && echo "\n" >> "${targetfilename}" && "${targetfilename}"  >> "${targetfilename}"`);
                console.log('we have to merge but lets replace for now ');
                child_process.execSync(`cp "${relativefilename}" "${targetfilename}"`);
                child_process.execSync(`mv "${relativefilename}.bak" "${relativefilename}"`);
                child_process.execSync(`cd repo && git add ${splits[1]}/${splits[2]}`);
            }
            else{
                console.log('we just copy');
                child_process.execSync(`cp "${relativefilename}" "${targetfilename}"`);
                child_process.execSync(`mv "${relativefilename}.bak" "${relativefilename}"`);
                child_process.execSync(`cd repo && git add ${splits[1]}/${splits[2]}`);
            }
            console.log('done');
            break;
            case 'classes':
            console.log('its class we override');
            break;
            default:
            console.log('we override by default');
        }
    }
    else
    console.log('you are running this on a folder outside src. we are quite opinionated about the folder structure. Unless you want to change the scripts, please run it on a salesforce folder inside src like permissionsets, or classes etc.')
}
else{
    console.log('no file selected');
}