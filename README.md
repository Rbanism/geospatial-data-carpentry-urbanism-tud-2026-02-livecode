[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

# Geospatial Data Carpentry for Urbanism - Notes 
## Usage Learners 
The repository should mimic the project structure of the R project that has been created by the instructors during the Data Carpentry. 
Go to the file in which the instructor is now coding: 
- [script.R](https://github.com/Rbanism/geospatial-data-carpentry-urbanism-tud-2026-02-livecode/blob/main/script.R)
You don't see the most recent lines of code? Refresh the page and see the new commands coming in!

> **Note**: 
> - You will only see non-empty folders. You still need to create folders to follow the workshop smoothly.
> - the `data` folder will not be available in the repository due to its size. 

## Usage Instructors 
Instructors can automatically update the repository using [gitautopush](https://pypi.org/project/gitautopush/). 

### Prerequisites for the solution
To work with the solution instructors need to have the following setup ready:
- Python and pip installed
- Git installed
- GitHub account added to the repository as a Contributor

### Steps
- `pip install gitautopush`
- `git clone` this repository to your local directory
- if you have cloned the repository a while ago, `git pull` to avoid conflicts
- in the terminal, start observing the folder by command: `gitautopush /path/to/my/repo/folder`
- you can also set up a delay between live coding and the notes in the repository by adding `--sleep <INT>` argument,  `INT` being the amount of time (in seconds) to wait in between attempts to synchronize.
- in the folder of the repository, create a new R script/ Rmarkdown and save the changes
- see if it automatically pushes to the repository
- save often with `Ctrl+S` for the changes to be pushed to the repository; alternatively, enable autosave in RStudio
- once you finish your lesson, make sure to close `gitautopush` with `Ctrl+C`

### Troubleshooting
- git requires SSH authentication
    - Add [SSH agent](https://stackoverflow.com/questions/10032461/git-keeps-asking-me-for-my-ssh-key-passphrase): write `eval $(ssh-agent)` followed by `ssh-add` in your terminal
    - If you don't SSH key set up yet, set it up without a passphrase (just hit enter when prompted for it)
    - You can try with `git clone` using  `https` (worked for me but normally not recommended)
- ValueError: A `git status` command didn't work, are you sure this is a git repository?
    - It might occur when there are already some changes to be staged once you launch `gitautopush`. First, run `gitautopush`, then start creating files or making changes to the existing ones. 
    - Another thing to try is to first commit and push one file manually to the repository, once you have done that and no changes are staged run `gitautopush`
- If you have set up all your git commits to be signed (verified) on GitHub, you will need to disable this feature for the live notes repository. You can do it iby running the following command in the repository root:

```
git config --local commit.gpgsign false
```

If you want to check if the commit signing is disabled, run (the returned value should be `false`):

```
git config --get commit.gpgsign

```



This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).
