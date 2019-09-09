# New_User_Creation
This script has been sanitized from a working enviroment. 

You will need AD Tools installed, PSCribo Installed (or run as admin and PSCribo will install)

Line 627: This is the location of the included password generation list text file.  This needs to be located at a UNC path that the script can access.

Line 704 thru 950: These sections the begining Checkbox logic for each department needs to have the full OU path.  This is for the correct user location once they are created

Line 1000: This section needs account, email server, email account and password to send email for the Welcome Document.

Line 1006: This section needs a system administrator account email address.  This is due to the creation of the User Drive and requires elevated premissions that can only be set in our enviorment by an admin. See line 1255

Line 1010: Help Desk Ticket System Email.  Used to send the User Drive email and create a ticket and assign to the SysAdmin defined in line 1006. See line 1255.

Line 1040: This section sets the email database based off of a company phone.  It parses for the lowest number of users in the database and adds the variable for creation to the apporiate correct one.

Line 1255: This is to send an email the help desk and assign it to the Sys Admin in line 1006.

Line 1307 thru 1413: These are the create the welcome documentation, set a copy to a UNC Path for archive, and send an email to differnt accounts. You will need to update Domain information and UNC paths thruout this section.  This well send the email using the account specified in line 1000.

There is one issue still with the script.  When creating an email based account it sets the Account Name wrong in AD. It sometimes requires a rename to show correctly.  Still working on the syntax to get it work properly. 
