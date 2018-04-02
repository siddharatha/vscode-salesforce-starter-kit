# vscode-starter-kit
Am grouping a workflow for pre-dx salesforce sandbox based development , as a starter kit to later move to dx mode.

All the tasks that are available, are grouped within tasks.json , which are quite easy to access from Tasks/Run.

I will try to summarize series of commands you can run without using command line.
## Step-1
- Make sure you have installed the [extension pack](https://marketplace.visualstudio.com/items?itemName=siddharatha.schneider-salesforce-developer-extension-pack)
- Make sure you have git installed and added to your path.
- Create and Navigate to a new folder in vscode where you would have your development and a combined repo that manages entire metadata.
> cmd + shift + p (mac) / ctrl + shift + p (windows) - this is your place holder to enter commands - we refer to this as command-pallete in this readme.

## Step-2 
- open command-pallete and type git:clone
    - specify this url : https://github.com/siddharatha/vscode-starter-kit.git
- Click on the notification to open the repository.

- ![Clone](https://raw.githubusercontent.com/siddharatha/vscode-starter-kit-screenshots/master/step1-clone-vscode-starter-kit.gif)

## Step-3
- update the build.properties file with the branch name and repo url.
- I recommend using SSH to avoid saving passwords.
- open tasks from the menu
> Tasks -> Run task
- select "Get Branch"
- The downloaded repo is maintained in a repo folder. 
- The repo folder is added in .gitignore file , so we are not mixing information of these 2 repos.

- ![Get Branch](https://raw.githubusercontent.com/siddharatha/vscode-starter-kit-screenshots/master/stpe2-clone-branch-you-working-on.gif)

## Step-4 (Get my changes from a sandbox)
- I recommend using the extension [forcecode](https://marketplace.visualstudio.com/items?itemName=JohnAaronNelson.ForceCode) for active development.
- If you want to get your changes from a sandbox, you can use this task. 
- This task roughly takes about 5 minutes for a really large environment. 
- I would suggest you fill the build.properties with the username, password and serverurl in the sf.username, sf.password and sf.serverurl .
> avoid spaces  before and after = in build.properties
- ![get my changes](https://raw.githubusercontent.com/siddharatha/vscode-starter-kit-screenshots/master/stpe3-get-my-changes.gif)

- This relies on simple list metadata api to get the information, as audit trail might not give all of that we need. I will update this later where it can mix both of audit api and list api to get what we want.

> Before we dive into how to merge these 2 repos, we have to consider how we store our metadata.

## Approach philosophy
- Profiles,permissionsets,labels,objects are the trickiest of all metadata you have to manage.
- Thanks to v40 and above, you dont have to jump through hoops to download permissionset information through metadata api.
- But profiles are still a struggle. We have to deal with download pieces of information.
- Even if we manage to download them all, the way we store it in a vcs system, are not so smooth for merge. Especially when you have teams trying to do parallel development and they are concerned that they have to touch a xml file which has updates of 10's of other developers.
> Its scary to touch and merge a large profile xml.

### Solution 1 (compress xmls)
- [Compress profile xml files - Alexander Brett](http://alexander-brett.co.uk/2015/01/15/Compress-your-SFDC-profiles.html)
- This small script is quite efficient in compressing the xml files.
- This should reduce the errors in merge.

### Solution 1 add-on (compress and store true values)
- I added some extensions to this script as I wanted to mimic what salesforce has done with v40 and above .
- If we store only true values , that would reduce the size drastically.
> Store just true values in profile xmls.

## Step-5 (Clean up your repo)

- We rely on vscode tasks again.
- if you use [vscode-statusbar-tasks](https://marketplace.visualstudio.com/items?itemName=GuardRex.status-bar-tasks) extension, you can access them more conviniently.

### File by File
