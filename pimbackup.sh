#!/bin/bash


##BASE information and build up from there.

###Define user information

username='insert_user_name_here'
password='insert_application_specific_password'

###define main backup location from the local users home directory
backup_folder="$HOME/Documents/pimbackup"
#echo $backup_calendar_folder

###use and define the format of the date to be tacked on to the backup file for quick reference of its export
date_extension="-%Y-%m-%d"
file_date="$(date +"${date_extension}")"
#echo $(date)
#echo $file_date

###Nextcloud server information broken down and built up so it can be easily be adapted to new installs or if updates change resource paths

####The root of the nextcloud installation
serverinstall='insert_url_of_the_nextcloud_instance'


####The static path from root for a resource. Items that vary (like a particular calendar will be tacked on later)

calendarpath="remote.php/dav/calendars/$username"
addresspath="remote.php/dav/addressbooks/users/$username/contacts/?export"

####Specify what calendars to pull for backup by adding the array
calendars=('calendarname1' 'calendarname2' 'calendarname3' 'calendarname4')

##Build-up and fetch

###Setup the the backup location
setfolders() {
	if [ ! -d "$backup_folder" ]; then
  		mkdir -p $backup_folder
	fi
	if [ ! -d "$backup_folder/calendars" ]; then
		mkdir -p "$backup_folder/calendars"
	fi
	if [ ! -d "$backup_folder/contacts" ]; then
		mkdir -p "$backup_folder/contacts"
	fi
}
###Setup and fetch the addressbook
get_addressbook() {
	####Build-up the complete backup folder and backup filename for the addressbook
	local addressfolder="$backup_folder/contacts"
	local addressfile="contacts${file_date}.vcf"
	local outputfile="$addressfolder/$addressfile"
	
	####Build-up the complete url for the addressbook resource
	local addressurl="${serverinstall}${addresspath}"
	
	#echo $addressfolder
	#echo $addressfile
	#echo $outputfile
	#echo $addressurl
    
    ####Fetch the addressbook and save it using curl with the complete information built.
	#curl -v -L -o "${outputfile}" -u ${username}:"${password}" "${addressurl}"
	curl -L -o "${outputfile}" -u ${username}:"${password}" "${addressurl}"
	}

###Setup and fetch the calendars
get_calendars() {
    ####Build-up the backup folder for the calendars
    local calendarfolder="${backup_folder}/calendars"
    
    ####Parse through the calendars array to setup the rest of the backup information and retrieve
    for i in "${calendars[@]}"
        do
            #####Setup subfolder folders for each calendar retrieved
            local single_cal_folder="${calendarfolder}/${i}"
            #echo $single_cal_folder
            if [ ! -d "$single_cal_folder" ]; then
                mkdir -p "$single_cal_folder"
            fi
            
            #####Build-up the calendar backup filename
            local calendarfile="$i${file_date}.ics"
            #echo $calendarfile
            
            ####Build-up the complete calendar backup location
            local outputfile="${single_cal_folder}/${calendarfile}"
            #echo $outputfile
            
            ####Build-up the complete url for the calendar to retrieve
            local calendarurl="${serverinstall}${calendarpath}/${i}?export"
            #echo $calendarurl
            
            ####Fetch the calendar fand save it using curl with the complete information built.
            #curl -v -L -o "${outputfile}" -u ${username}:"${password}" "${calendarurl}"
            curl -L -o "${outputfile}" -u ${username}:"${password}" "${calendarurl}"
        done
    }

##Take action
setfolders
get_addressbook
get_calendars
