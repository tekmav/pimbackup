# pimbackup

A simple bash script for backing up a user's calendars and contacts from a Nextcloud server.  It appends the current date
to the filenames for quick reference of when the backup was made.  The only requirement on the user's local machine is 
**curl**.

## Usage

Clone the repository.  Edit the pimbackup.sh file and substitute in the correct values of for your Nextcloud instance.  These
would be the username, your application specific password (recommended since you should be using Two Factor Authentication as
a regular security measure), the names of the calendars you want backed, the address of the Nextcloud instance.

The script can be ran manually by calling it with:

```
bash pimbackup.sh
```

Or it can be marked executable and ran via a cron job for regular backups.

## The script's design

This script was written for a simple need and to answer that need required some learning.  Since this was the first time
I have written a bash script, the design of the script reflects a methodology of breaking down the parts, testing the parts,
and bring it all together.  Comments reflect the intent of each section of code while commented out `echo` statements reflect
the testing to ensure that each step produces the desired outcome. Commented out `curl` statements used verbose modes to
show that the correct calls and connection to the Nextcloud instance were being made.

The script was not written for size, efficiency, or even uniform syntax.  It was written from an absolute beginners point.
A newer, more concise version make come later but the original version will always be available here as a learning tool.

