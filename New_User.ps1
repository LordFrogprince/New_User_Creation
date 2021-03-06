######################################
#         New User Script            #
#                                    #
#    Used to add Employees to Domain #
#                                    #
#   Version 7.4                      #
######################################

# This script contains a GUI that provisions and creates a new Network User. You must have PSCribo, ADTools, and MSOnline to run.
# Account asked for During Prompt is USER@domain.com Format only!
#
# Version 7.3
#  
# This versions adds to the email portion to open a ticket if the user needs a U - Drive Created. This process currently 
# requries domain admin(s) to fullfill. Set at line 1255 and account at 1006 and 1010 for help desk email.

#
# Updates - Email is now down with authentication for Automation Account
# Papercut is only assiged with email
# Changes exchange database option to be dynamic
# Adds logic to auto install PSCribo
# Added Cell Phone User Group and Checkbox


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#################### Background Form ####################
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '769,750'
$Form.text                       = "New User Account Creation"
$Form.TopMost                    = $false

#################### END of Background Form ####################

#################### User Section ####################
$Groupbox2                       = New-Object system.Windows.Forms.Groupbox
$Groupbox2.height                = 250
$Groupbox2.width                 = 358
$Groupbox2.text                  = "User"
$Groupbox2.location              = New-Object System.Drawing.Point(15,20)

$NewDomainLabel                     = New-Object system.Windows.Forms.Label
$NewDomainLabel.text                = "New User"
$NewDomainLabel.AutoSize            = $true
$NewDomainLabel.width               = 25
$NewDomainLabel.height              = 10
$NewDomainLabel.location            = New-Object System.Drawing.Point(15,14)
$NewDomainLabel.Font                = 'Microsoft Sans Serif,11,style=Italic'

$FirstNameLabel                  = New-Object system.Windows.Forms.Label
$FirstNameLabel.text            = "First Name"
$FirstNameLabel.AutoSize        = $true
$FirstNameLabel.width           = 25
$FirstNameLabel.height           = 10
$FirstNameLabel.location         = New-Object System.Drawing.Point(120,15)
$FirstNameLabel.Font             = 'Microsoft Sans Serif,10,style=Italic'

$FirstName                       = New-Object system.Windows.Forms.TextBox
$FirstName.multiline             = $false
$FirstName.width                 = 146
$FirstName.height                = 20
$FirstName.location              = New-Object System.Drawing.Point(188,16)
$FirstName.Font                  = 'Microsoft Sans Serif,10'

$Lastname                        = New-Object system.Windows.Forms.TextBox
$Lastname.multiline              = $false
$Lastname.width                  = 146
$Lastname.height                 = 20
$Lastname.location               = New-Object System.Drawing.Point(188,42)
$Lastname.Font                   = 'Microsoft Sans Serif,10'


$LastnameLabel                   = New-Object system.Windows.Forms.Label
$LastnameLabel.text              = "Last Name"
$LastnameLabel.AutoSize          = $true
$LastnameLabel.width             = 25
$LastnameLabel.height            = 10
$LastnameLabel.location          = New-Object System.Drawing.Point(120,45)
$LastnameLabel.Font              = 'Microsoft Sans Serif,10,style=Italic'

$AliasLabel                      = New-Object system.Windows.Forms.Label
$AliasLabel.text                 = "Email Alias"
$AliasLabel.AutoSize             = $true
$AliasLabel.width                = 25
$AliasLabel.height               = 10
$AliasLabel.location             = New-Object System.Drawing.Point(13,80)
$AliasLabel.Font                 = 'Microsoft Sans Serif,11,style=Italic'

$userid                          = New-Object system.Windows.Forms.TextBox
$userid.multiline                = $false
$userid.width                    = 149
$userid.height                   = 20
$userid.location                 = New-Object System.Drawing.Point(13,100)
$userid.Font                     = 'Microsoft Sans Serif,10'

$Alaislabel                   = New-Object system.Windows.Forms.Label
$Alaislabel.text              = "@yourdomain.com"
$Alaislabel.AutoSize          = $true
$Alaislabel.width             = 25
$Alaislabel.height            = 10
$Alaislabel.location          = New-Object System.Drawing.Point(164,100)
$Alaislabel.Font              = 'Microsoft Sans Serif,10'

$WarningLabel                   = New-Object system.Windows.Forms.Label
$WarningLabel.AutoSize          = $true
$WarningLabel.width             = 25
$WarningLabel.height            = 10
$WarningLabel.location          = New-Object System.Drawing.Point(164,100)
$WarningLabel.Font              = 'Microsoft Sans Serif,10'
$WarningLabel.ForeColor         = "#ff0000"

$JobTitle                       = New-Object system.Windows.Forms.TextBox
$JobTitle.multiline             = $false
$JobTitle.width                 = 175
$JobTitle.height                = 20
$JobTitle.location              = New-Object System.Drawing.Point(13,160)
$JobTitle.Font                  = 'Microsoft Sans Serif,10'

$JobTitleLabel                    = New-Object system.Windows.Forms.Label
$JobTitleLabel.text               = "Job Title"
$JobTitleLabel.AutoSize           = $true
$JobTitleLabel.width              = 25
$JobTitleLabel.height             = 10
$JobTitleLabel.location           = New-Object System.Drawing.Point(13,140)
$JobTitleLabel.Font               = 'Microsoft Sans Serif,11,style=Italic'

$ExtensionLabel                    = New-Object system.Windows.Forms.Label
$ExtensionLabel.text               = "Extension"
$ExtensionLabel.AutoSize           = $true
$ExtensionLabel.width              = 25
$ExtensionLabel.height             = 10
$ExtensionLabel.location           = New-Object System.Drawing.Point(230,135)
$ExtensionLabel.Font               = 'Microsoft Sans Serif,11,style=Italic'

$Extension                       = New-Object system.Windows.Forms.TextBox
$Extension.multiline             = $false
$Extension.width                 = 100
$Extension.height                = 20
$Extension.location              = New-Object System.Drawing.Point(230,160)
$Extension.Font                  = 'Microsoft Sans Serif,10'


$managerID                       = New-Object system.Windows.Forms.TextBox
$managerID.multiline             = $false
$managerID.width                 = 149
$managerID.height                = 20
$managerID.location              = New-Object System.Drawing.Point(13,220)
$managerID.Font                  = 'Microsoft Sans Serif,10'

$ManagerLabel                          = New-Object system.Windows.Forms.Label
$ManagerLabel.text                     = "@yourdomain.com"
$ManagerLabel.AutoSize                 = $true
$ManagerLabel.width                    = 25
$ManagerLabel.height                   = 10
$ManagerLabel.location                 = New-Object System.Drawing.Point(164,225)
$ManagerLabel.Font                     = 'Microsoft Sans Serif,10'

$ManagerLabel                    = New-Object system.Windows.Forms.Label
$ManagerLabel.text               = "Manager"
$ManagerLabel.AutoSize           = $true
$ManagerLabel.width              = 25
$ManagerLabel.height             = 10
$ManagerLabel.location           = New-Object System.Drawing.Point(13,195)
$ManagerLabel.Font               = 'Microsoft Sans Serif,11,style=Italic'
#################### End User Section ####################

#################### Account Options Section ####################

$ACOptions                       = New-Object system.Windows.Forms.Groupbox
$ACOptions.height                = 230
$ACOptions.width                 = 123
$ACOptions.text                  = "Account Options"
$ACOptions.location              = New-Object System.Drawing.Point(15,283)

$email                           = New-Object system.Windows.Forms.CheckBox
$email.text                      = "Email"
$email.AutoSize                  = $false
$email.width                     = 103
$email.height                    = 20
$email.location                  = New-Object System.Drawing.Point(11,25)
$email.Font                      = 'Microsoft Sans Serif,10'

$AX                              = New-Object system.Windows.Forms.CheckBox
$AX.text                         = "AX User"
$AX.AutoSize                     = $false
$AX.width                        = 103
$AX.height                       = 20
$AX.location                     = New-Object System.Drawing.Point(11,50)
$AX.Font                         = 'Microsoft Sans Serif,10'

$Office                          = New-Object system.Windows.Forms.CheckBox
$Office.text                     = "Office 365"
$Office.AutoSize                 = $false
$Office.width                    = 103
$Office.height                   = 20
$Office.location                 = New-Object System.Drawing.Point(11,75)
$Office.Font                     = 'Microsoft Sans Serif,10'

$LogiHouse                       = New-Object system.Windows.Forms.CheckBox
$LogiHouse.text                  = "Logi House"
$LogiHouse.AutoSize              = $false
$LogiHouse.width                 = 103
$LogiHouse.height                = 20
$LogiHouse.location              = New-Object System.Drawing.Point(11,100)
$LogiHouse.Font                  = 'Microsoft Sans Serif,10'

$HQ                           = New-Object system.Windows.Forms.CheckBox
$HQ.text                      = "Main HQ"
$HQ.AutoSize                  = $false
$HQ.width                     = 103
$HQ.height                    = 20
$HQ.location                  = New-Object System.Drawing.Point(11,125)
$HQ.Font                      = 'Microsoft Sans Serif,10'

$Papercut                        = New-Object system.Windows.Forms.CheckBox
$Papercut.text                   = "PaperCut"
$Papercut.AutoSize               = $false
$Papercut.width                  = 103
$Papercut.height                 = 20
$Papercut.location               = New-Object System.Drawing.Point(11,150)
$Papercut.Font                   = 'Microsoft Sans Serif,10'

$ComPhone                        = New-Object system.Windows.Forms.CheckBox
$ComPhone.text                   = "Cell Phone"
$ComPhone.AutoSize               = $false
$ComPhone.width                  = 103
$ComPhone.height                 = 20
$ComPhone.location               = New-Object System.Drawing.Point(11,175)
$ComPhone.Font                   = 'Microsoft Sans Serif,10'



#################### End of Account Options Section ####################

#################### Department Options Section ####################
$Groupbox1                       = New-Object system.Windows.Forms.Groupbox
$Groupbox1.height                = 218
$Groupbox1.width                 = 123
$Groupbox1.text                  = "Department"
$Groupbox1.location              = New-Object System.Drawing.Point(15,520)

$IT                              = New-Object system.Windows.Forms.CheckBox
$IT.text                         = "IT"
$IT.AutoSize                     = $false
$IT.width                        = 97
$IT.height                       = 18
$IT.location                     = New-Object System.Drawing.Point(12,25)
$IT.Font                         = 'Microsoft Sans Serif,10'

$Prod                            = New-Object system.Windows.Forms.CheckBox
$Prod.text                       = "Production"
$Prod.AutoSize                   = $false
$Prod.width                      = 97
$Prod.height                     = 18
$Prod.location                   = New-Object System.Drawing.Point(12,50)
$Prod.Font                       = 'Microsoft Sans Serif,10'

$Logistics                       = New-Object system.Windows.Forms.CheckBox
$Logistics.text                  = "Logistics"
$Logistics.AutoSize              = $false
$Logistics.width                 = 97
$Logistics.height                = 18
$Logistics.location              = New-Object System.Drawing.Point(12,75)
$Logistics.Font                  = 'Microsoft Sans Serif,10'

$Sales                           = New-Object system.Windows.Forms.CheckBox
$Sales.text                      = "Sales"
$Sales.AutoSize                  = $false
$Sales.width                     = 97
$Sales.height                    = 18
$Sales.location                  = New-Object System.Drawing.Point(12,100)
$Sales.Font                      = 'Microsoft Sans Serif,10'

$CustService                     = New-Object system.Windows.Forms.CheckBox
$CustService.text                = "CustService"
$CustService.AutoSize            = $false
$CustService.width               = 104
$CustService.height              = 18
$CustService.location            = New-Object System.Drawing.Point(12,125)
$CustService.Font                = 'Microsoft Sans Serif,10'

$Warranty                        = New-Object system.Windows.Forms.CheckBox
$Warranty.text                   = "Warranty"
$Warranty.AutoSize               = $false
$Warranty.width                  = 97
$Warranty.height                 = 18
$Warranty.location               = New-Object System.Drawing.Point(12,150)
$Warranty.Font                   = 'Microsoft Sans Serif,10'

$Finance                         = New-Object system.Windows.Forms.CheckBox
$Finance.text                    = "Finance"
$Finance.AutoSize                = $false
$Finance.width                   = 97
$Finance.height                  = 18
$Finance.location                = New-Object System.Drawing.Point(12,170)
$Finance.Font                    = 'Microsoft Sans Serif,10'

$HR                              = New-Object system.Windows.Forms.CheckBox
$HR.text                         = "HR"
$HR.AutoSize                     = $false
$HR.width                        = 97
$HR.height                       = 18
$HR.location                     = New-Object System.Drawing.Point(12,195)
$HR.Font                         = 'Microsoft Sans Serif,10'
#################### End of Department Options Section ####################

#################### The Below Section is For Network Drives ####################
$Ndrives                         = New-Object system.Windows.Forms.Groupbox
$Ndrives.height                  = 405
$Ndrives.width                   = 218
$Ndrives.text                    = "Network Drives"
$Ndrives.location                = New-Object System.Drawing.Point(158,283)

$HDrive                          = New-Object system.Windows.Forms.CheckBox
$HDrive.text                     = "H: Housewares"
$HDrive.AutoSize                 = $false
$HDrive.width                    = 202
$HDrive.height                   = 17
$HDrive.location                 = New-Object System.Drawing.Point(8,20)
$HDrive.Font                     = 'Microsoft Sans Serif,10'

$JDrive                          = New-Object system.Windows.Forms.CheckBox
$JDrive.text                     = "J: Label"
$JDrive.AutoSize                 = $false
$JDrive.width                    = 106
$JDrive.height                   = 17
$JDrive.location                 = New-Object System.Drawing.Point(8,40)
$JDrive.Font                     = 'Microsoft Sans Serif,10'

$IDrive                          = New-Object system.Windows.Forms.CheckBox
$IDrive.text                     = "I: EDI Drive"
$IDrive.AutoSize                 = $false
$IDrive.width                    = 106
$IDrive.height                   = 17
$IDrive.location                 = New-Object System.Drawing.Point(8,60)
$IDrive.Font                     = 'Microsoft Sans Serif,10'

$KDrive                          = New-Object system.Windows.Forms.CheckBox
$KDrive.text                     = "K: IT Drive"
$KDrive.AutoSize                 = $false
$KDrive.width                    = 106
$KDrive.height                   = 17
$KDrive.location                 = New-Object System.Drawing.Point(8,80)
$KDrive.Font                     = 'Microsoft Sans Serif,10'

$MDrive                          = New-Object system.Windows.Forms.CheckBox
$MDrive.text                     = "M: M2M"
$MDrive.AutoSize                 = $false
$MDrive.width                    = 106
$MDrive.height                   = 17
$MDrive.location                 = New-Object System.Drawing.Point(8,100)
$MDrive.Font                     = 'Microsoft Sans Serif,10'

$ODrive                          = New-Object system.Windows.Forms.CheckBox
$ODrive.text                     = "O: Warranty"
$ODrive.AutoSize                 = $false
$ODrive.width                    = 106
$ODrive.height                   = 17
$ODrive.location                 = New-Object System.Drawing.Point(8,120)
$ODrive.Font                     = 'Microsoft Sans Serif,10'

$PDrive                          = New-Object system.Windows.Forms.CheckBox
$PDrive.text                     = "P: Cad Share "
$PDrive.AutoSize                 = $false
$PDrive.width                    = 106
$PDrive.height                   = 17
$PDrive.location                 = New-Object System.Drawing.Point(8,140)
$PDrive.Font                     = 'Microsoft Sans Serif,10'

$QDrive                          = New-Object system.Windows.Forms.CheckBox
$QDrive.text                     = "Q: Customer Service"
$QDrive.AutoSize                 = $false
$QDrive.width                    = 202
$QDrive.height                   = 17
$QDrive.location                 = New-Object System.Drawing.Point(8,160)
$QDrive.Font                     = 'Microsoft Sans Serif,10'

$RDrive                          = New-Object system.Windows.Forms.CheckBox
$RDrive.text                     = "R: Shopfloor"
$RDrive.AutoSize                 = $false
$RDrive.width                    = 106
$RDrive.height                   = 17
$RDrive.location                 = New-Object System.Drawing.Point(8,180)
$RDrive.Font                     = 'Microsoft Sans Serif,10'

$SDrive                          = New-Object system.Windows.Forms.CheckBox
$SDrive.text                     = "S: Shipping"
$SDrive.AutoSize                 = $false
$SDrive.width                    = 106
$SDrive.height                   = 17
$SDrive.location                 = New-Object System.Drawing.Point(8,200)
$SDrive.Font                     = 'Microsoft Sans Serif,10'

$TDrive                          = New-Object system.Windows.Forms.CheckBox
$TDrive.text                     = "T: Controller"
$TDrive.AutoSize                 = $false
$TDrive.width                    = 106
$TDrive.height                   = 17
$TDrive.location                 = New-Object System.Drawing.Point(8,220)
$TDrive.Font                     = 'Microsoft Sans Serif,10'

$UDrive                          = New-Object system.Windows.Forms.CheckBox
$UDrive.text                     = "U: Personal"
$UDrive.AutoSize                 = $false
$UDrive.width                    = 106
$UDrive.height                   = 17
$UDrive.location                 = New-Object System.Drawing.Point(8,240)
$UDrive.Font                     = 'Microsoft Sans Serif,10'

$SVDrive                         = New-Object system.Windows.Forms.CheckBox
$SVDrive.text                    = "V: SVN"
$SVDrive.AutoSize                = $false
$SVDrive.width                   = 106
$SVDrive.height                  = 17
$SVDrive.location                = New-Object System.Drawing.Point(8,260)
$SVDrive.Font                    = 'Microsoft Sans Serif,10'

$WDrive                          = New-Object system.Windows.Forms.CheckBox
$WDrive.text                     = "W: Machine Control"
$WDrive.AutoSize                 = $false
$WDrive.width                    = 202
$WDrive.height                   = 17
$WDrive.location                 = New-Object System.Drawing.Point(8,280)
$WDrive.Font                     = 'Microsoft Sans Serif,10'

$XDrive                          = New-Object system.Windows.Forms.CheckBox
$XDrive.text                     = "X: Recieving and Inspection"
$XDrive.AutoSize                 = $false
$XDrive.width                    = 202
$XDrive.height                   = 17
$XDrive.location                 = New-Object System.Drawing.Point(8,300)
$XDrive.Font                     = 'Microsoft Sans Serif,10'

$ZDrive                          = New-Object system.Windows.Forms.CheckBox
$ZDrive.text                     = "Z: Finance"
$ZDrive.AutoSize                 = $false
$ZDrive.width                    = 106
$ZDrive.height                   = 17
$ZDrive.location                 = New-Object System.Drawing.Point(8,320)
$ZDrive.Font                     = 'Microsoft Sans Serif,10'

################## End of the Network Drives  ####################

################## Password Generation  ####################

$Groupbox3                       = New-Object system.Windows.Forms.Groupbox
$Groupbox3.height                = 130
$Groupbox3.width                 = 249
$Groupbox3.text                  = "Password"
$Groupbox3.location              = New-Object System.Drawing.Point(386,20)

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.width                  = 222
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(10,42)
$TextBox2.Font                   = 'Microsoft Sans Serif,10'

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "Generated Password"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(16,19)
$Label4.Font                     = 'Microsoft Sans Serif,10'

$generatepass                    = New-Object system.Windows.Forms.Button
$generatepass.text               = "Generate"
$generatepass.width              = 71
$generatepass.height             = 30
$generatepass.location           = New-Object System.Drawing.Point(159,71)
$generatepass.Font               = 'Microsoft Sans Serif,10'

################## End of Password Generation  ####################

################## Output  ####################
$Output                          = New-Object system.Windows.Forms.TextBox
$Output.multiline                = $True
$Output.width                    = 368
$Output.height                   = 300
$Output.location                 = New-Object System.Drawing.Point(388,183)
$Output.Font                     = 'Microsoft Sans Serif,10'

$Outputlabel                     = New-Object system.Windows.Forms.Label
$Outputlabel.text                = "Output"
$Outputlabel.AutoSize            = $true
$Outputlabel.width               = 25
$Outputlabel.height              = 10
$Outputlabel.location            = New-Object System.Drawing.Point(396,163)
$Outputlabel.Font                = 'Microsoft Sans Serif,10'

################## End of Output  ####################

################## Run Button  ####################
$Run                             = New-Object system.Windows.Forms.Button
$Run.text                        = "Create"
$Run.width                       = 60
$Run.height                      = 30
$Run.location                    = New-Object System.Drawing.Point(696,581)
$Run.Font                        = 'Microsoft Sans Serif,10'

################## End of Run Button  ####################

################## Close Button  ####################
$Close                             = New-Object system.Windows.Forms.Button
$Close.text                        = "Close"
$Close.width                       = 60
$Close.height                      = 30
$Close.location                    = New-Object System.Drawing.Point(696,700)
$Close.Font                        = 'Microsoft Sans Serif,10'

################## End of Run Button  ####################

$Form.controls.AddRange(@($Ndrives,$ACOptions,$Groupbox1,$Groupbox2,$Groupbox3,$Output,$Run,$Close,$Outputlabel))
$Ndrives.controls.AddRange(@($HDrive,$IDrive,$JDrive,$KDrive,$TDrive,$MDrive,$SVDrive,$UDrive,$WDrive,$ODrive,$RDrive,$QDrive,$PDrive,$XDrive,$SDrive,$ZDrive))
$Groupbox2.controls.AddRange(@($userid,$NewDomainLabel,$managerID,$ManagerLabel,$ManagerLabel,$extensionlabel,$extension,$FirstName,$Lastname,$FirstNameLabel,$LastnameLabel,$AliasLabel,$Alaislabel,$JobTitle,$JobTitleLabel,$Warninglabel))
$ACOptions.controls.AddRange(@($email,$AX,$Office,$LogiHouse,$HQ, $PaperCut, $ComPhone))
$Groupbox1.controls.AddRange(@($IT,$Prod,$CustService,$Logistics,$Sales,$Warranty,$Finance,$HR))
$Groupbox3.controls.AddRange(@($TextBox2,$Label4,$generatepass))

################## Set Tab Order  ####################
$FirstName.TabIndex = 0
$Lastname.TabIndex = 1
$userID.TabIndex = 2
$JobTitle.Tabindex = 3
$extension.tabindex = 4
$managerID.Tabindex = 5
$email.TabIndex = 6
$AX.TabIndex = 7
$Office.TabIndex = 8
$LogiHouse.TabIndex = 9
$HQ.TabIndex = 10
$Papercut.TabIndex = 10
$ComPhone.TabIndex = 11
$IT.TabIndex = 12
$Prod.TabIndex = 13
$Logistics.TabIndex = 14
$Sales.TabIndex = 15
$CustService.TabIndex = 16
$Warranty.TabIndex = 17
$Finance.TabIndex = 18
$HR.TabIndex = 19
$HDrive.TabIndex = 20
$JDrive.TabIndex = 21
$IDrive.TabIndex = 22
$KDrive.TabIndex = 23
$MDrive.TabIndex = 24
$ODrive.TabIndex = 25
$PDrive.TabIndex = 26
$QDrive.TabIndex = 27
$RDrive.TabIndex = 28
$SDrive.TabIndex = 29
$TDrive.TabIndex = 30
$UDrive.TabIndex = 31
$SVDrive.TabIndex = 32
$WDrive.TabIndex = 33
$XDrive.TabIndex = 34
$ZDrive.TabIndex = 35
$generatepass.TabIndex = 36
$Run.TabIndex = 37
$TextBox2.TabIndex = 99


#region gui events {
$HDrive.Add_CheckedChanged({  })
$IDrive.Add_CheckedChanged({  })
$JDrive.Add_CheckedChanged({  })
$KDrive.Add_CheckedChanged({  })
$email.Add_CheckedChanged({  })
$papercut.Add_CheckedChanged({  })
$ComPhone.Add_CheckedChanged({  })
$userid.Add_TextChanged({  })
$AX.Add_CheckedChanged({  })
$Office.Add_CheckedChanged({  })
$IT.Add_CheckedChanged({  })
$Prod.Add_CheckedChanged({  })
$Logistics.Add_CheckedChanged({  })
$Sales.Add_CheckedChanged({  })
$CustService.Add_CheckedChanged({  })
$Warranty.Add_CheckedChanged({  })
$Finance.Add_CheckedChanged({  }) 
$MDrive.Add_CheckedChanged({  })
$ODrive.Add_CheckedChanged({  })
$PDrive.Add_CheckedChanged({  })
$QDrive.Add_CheckedChanged({  })
$RDrive.Add_CheckedChanged({  })
$SDrive.Add_CheckedChanged({  })
$TDrive.Add_CheckedChanged({  })
$UDrive.Add_CheckedChanged({  })
$SVDrive.Add_CheckedChanged({  })
$WDrive.Add_CheckedChanged({  })
$XDrive.Add_CheckedChanged({  })
$ZDrive.Add_CheckedChanged({  })
$Output.Add_TextChanged({  })
$TextBox2.Add_TextChanged({  })
$generatepass.Add_Click({  })
$Run.Add_Click({  })
$LogiHouse.Add_CheckedChanged({  })
$HQ.Add_CheckedChanged({  })
$managerID.Add_TextChanged({  })
$Lastname.Add_TextChanged({  })
$FirstName.Add_TextChanged({  })
$JobTitle.Add_TextChanged({  })
$Extension.Add_TextChanged({  })
$Close.Add_Click({  })
#endregion events }

#endregion GUI }

#######  Form Logic  #######

# Generate Password Using Random Password Generation
$generatepass.Add_Click({ 

function Get-RandomCharacter([string]$charactersToChooseFrom)

    {

       $offSet = Get-Random -Minimum 0 -Maximum (($charactersToChooseFrom.Length) - 1)

       return $charactersToChooseFrom.SubString($offSet,1)

    }
$dicewordlist = Import-Csv '\\Server\filepath\Dicewarecom Dice-Indexed Passphrase Word ListV3.txt'
$numbers = "1234567890"
$punctuation = "!@#$%^&*?-=_+()"
$Die = "123456"
Clear-Variable Roll* -Scope Global
$Roll1 += Get-RandomCharacter $Die
$Roll1 += Get-RandomCharacter $Die
$Roll1 += Get-RandomCharacter $Die
$Roll1 += Get-RandomCharacter $Die
$Roll1 += Get-RandomCharacter $Die
$Roll2 += Get-RandomCharacter $Die
$Roll2 += Get-RandomCharacter $Die
$Roll2 += Get-RandomCharacter $Die
$Roll2 += Get-RandomCharacter $Die
$Roll2 += Get-RandomCharacter $Die
$Roll3 += Get-RandomCharacter $Die
$Roll3 += Get-RandomCharacter $Die
$Roll3 += Get-RandomCharacter $Die
$Roll3 += Get-RandomCharacter $Die
$Roll3 += Get-RandomCharacter $Die

$password = Get-RandomCharacter $numbers 
$password += Get-RandomCharacter $numbers 
$password += $dicewordlist| Where-Object {$_.Value -eq $Roll1 } |Select -Expand word
$password +=$dicewordlist| Where-Object {$_.Value -eq $Roll2 } |Select -Expand word
$password +=$dicewordlist| Where-Object {$_.Value -eq $Roll3 } |Select -Expand word
if($password.Length -lt 15)
{
    do {
    $password += Get-RandomCharacter $punctuation
    }
    until ( $password.Length -gt 14)
}
$Roll1
$Roll2
$Roll3
$password.Length
$password        

$TextBox2.Text = $password 
  
    
})

####### Account Options Logic #######

    #Logihouse Checkbox Logic
         $LogiHouse.Add_CheckedChanged({
        if ($LogiHouse.Checked -eq $true) { 
            $HQ.Checked = $false
            $global:Logi = $true}
        else { $global:HQ = $false} 

})

    #HQ Checkbox Logic
         $HQ.Add_CheckedChanged({
        if ($HQ.Checked -eq $true) {
                $LogiHouse.Checked = $false
                $global:HQ = $true}
        else { $global:Logi = $false}
                 
})

    #PaperCut Logic
        $Papercut.Add_CheckedChanged({
        if ($Papercut.Checked -eq $true) {
                $Email.Checked = $true
                }
})

        $Email.Add_CheckedChanged({
        if ($Email.Checked -eq $false) {
                $Papercut.Checked = $false
                }
                                
})
####### Department Options Logic #######


    #IT Department Checkbox Logic
         $IT.Add_CheckedChanged({
        if ($IT.Checked -eq $true) { 
            $global:Dept = "OU Target"
            $global:DeptName = "IT"           
            $UDrive.checked = $true
            $hdrive.checked = $false
            $JDrive.checked = $false
            $IDrive.checked = $false
            $KDrive.checked = $true
            $MDrive.checked = $false
            $ODrive.checked = $false
            $PDrive.checked = $false
            $QDrive.checked = $false
            $RDrive.checked = $false
            $SDrive.checked = $false
            $TDrive.checked = $false
            $SVDrive.checked = $false
            $WDrive.checked = $false
            $XDrive.checked = $false
            $ZDrive.checked = $false
            $Prod.Checked = $false
            $Logistics.Checked = $false
            $Sales.Checked = $false
            $CustService.Checked = $false 
            $Warranty.Checked = $false
            $Finance.checked = $False
            $HR.checked = $false }

})

    #Production Department Checkbox Logic
         $Prod.Add_CheckedChanged({
        if ($Prod.Checked -eq $true) { 
            $global:Dept = "OU Target"
            $global:DeptName = "Production"
            $hdrive.checked = $false
            $JDrive.checked = $false
            $IDrive.checked = $false
            $KDrive.checked = $false
            $MDrive.checked = $false
            $ODrive.checked = $false
            $PDrive.checked = $false
            $QDrive.checked = $false
            $RDrive.checked = $false
            $SDrive.checked = $false
            $TDrive.checked = $false
            $SVDrive.checked = $false
            $WDrive.checked = $false
            $XDrive.checked = $false
            $ZDrive.checked = $false
            $IT.Checked = $false
            $Logistics.Checked = $false
            $Sales.Checked = $false
            $CustService.Checked = $false 
            $Warranty.Checked = $false
            $Finance.checked = $False 
            $HR.checked = $false}

})

    #Logistics Department Checkbox Logic
         $Logistics.Add_CheckedChanged({
        if ($Logistics.Checked -eq $true) { 
            $global:Dept = "OU Target"
            $global:DeptName = "Logistics"
            $hdrive.checked = $false
            $JDrive.checked = $true
            $IDrive.checked = $false
            $KDrive.checked = $false
            $MDrive.checked = $false
            $ODrive.checked = $false
            $PDrive.checked = $false
            $QDrive.checked = $false
            $RDrive.checked = $false
            $SDrive.checked = $true
            $TDrive.checked = $false
            $SVDrive.checked = $false
            $WDrive.checked = $false
            $XDrive.checked = $false
            $ZDrive.checked = $false
            $IT.Checked = $false
            $Prod.Checked = $false
            $Sales.Checked = $false
            $CustService.Checked = $false 
            $Warranty.Checked = $false
            $Finance.checked = $False
            $HR.checked = $false }

})

    #Sales Department Checkbox Logic
         $Sales.Add_CheckedChanged({
        if ($Sales.Checked -eq $true) { 
            $global:Dept = "OU Target"
            $global:DeptName = "Sales"
            $UDrive.checked = $true
            $hdrive.checked = $true
            $JDrive.checked = $false
            $IDrive.checked = $false
            $KDrive.checked = $false
            $MDrive.checked = $false
            $ODrive.checked = $false
            $PDrive.checked = $false
            $QDrive.checked = $false
            $RDrive.checked = $false
            $SDrive.checked = $false
            $TDrive.checked = $false
            $SVDrive.checked = $false
            $WDrive.checked = $false
            $XDrive.checked = $false
            $ZDrive.checked = $false            
            $IT.Checked = $false
            $Prod.Checked = $false
            $Logistics.Checked = $false
            $CustService.Checked = $false 
            $Warranty.Checked = $false
            $Finance.checked = $False
            $HR.checked = $false }

})

    #CustService Department Checkbox Logic
         $CustService.Add_CheckedChanged({
        if ($CustService.Checked -eq $true) { 
            $global:Dept = "OU Target"
            $global:DeptName = "Customer Service"
            $UDrive.checked = $true
            $hdrive.checked = $false
            $JDrive.checked = $false
            $IDrive.checked = $false
            $KDrive.checked = $false
            $MDrive.checked = $false
            $ODrive.checked = $false
            $PDrive.checked = $false
            $QDrive.checked = $true
            $RDrive.checked = $false
            $SDrive.checked = $false
            $TDrive.checked = $false
            $SVDrive.checked = $false
            $WDrive.checked = $false
            $XDrive.checked = $false
            $ZDrive.checked = $false
            $IT.Checked = $false
            $Prod.Checked = $false
            $Logistics.Checked = $false
            $Sales.Checked = $false 
            $Warranty.Checked = $false
            $Finance.checked = $False 
            $HR.checked = $false}
       
})

    #Warranty Department Checkbox Logic
         $Warranty.Add_CheckedChanged({
        if ($Warranty.Checked -eq $true) { 
            $global:Dept = "OU Target"
            $global:DeptName = "Warranty"
            $UDrive.checked = $true
            $hdrive.checked = $false
            $JDrive.checked = $false
            $IDrive.checked = $false
            $KDrive.checked = $false
            $MDrive.checked = $false
            $ODrive.checked = $true
            $PDrive.checked = $false
            $QDrive.checked = $false
            $RDrive.checked = $false
            $SDrive.checked = $false
            $TDrive.checked = $false
            $SVDrive.checked = $false
            $WDrive.checked = $false
            $XDrive.checked = $false
            $ZDrive.checked = $false
            $IT.Checked = $false
            $Prod.Checked = $false
            $Logistics.Checked = $false
            $Sales.Checked = $false 
            $CustService.Checked = $false
            $Finance.checked = $False  
            $HR.checked = $false}

})

    #Finance Department Checkbox Logic
         $Finance.Add_CheckedChanged({
        if ($Finance.Checked -eq $true) { 
            $global:Dept = "OU Target"
            $global:DeptName = "Finance"
            $UDrive.checked = $true
            $hdrive.checked = $false
            $JDrive.checked = $false
            $IDrive.checked = $false
            $KDrive.checked = $false
            $MDrive.checked = $false
            $ODrive.checked = $false
            $PDrive.checked = $false
            $QDrive.checked = $false
            $RDrive.checked = $false
            $SDrive.checked = $false
            $TDrive.checked = $false
            $SVDrive.checked = $false
            $WDrive.checked = $false
            $XDrive.checked = $false
            $ZDrive.checked = $true
            $IT.Checked = $false
            $Prod.Checked = $false
            $Logistics.Checked = $false
            $Sales.Checked = $false 
            $CustService.Checked = $false
            $Warranty.Checked = $false 
            $HR.checked = $false}
    
})

    #HR Department Checkbox Logic
         $HR.Add_CheckedChanged({
        if ($HR.Checked -eq $true) { 
            $global:Dept = "OU Target"
            $global:DeptName = "Human Resources"
            $UDrive.checked = $true
            $hdrive.checked = $false
            $JDrive.checked = $false
            $IDrive.checked = $false
            $KDrive.checked = $false
            $MDrive.checked = $false
            $ODrive.checked = $false
            $PDrive.checked = $false
            $QDrive.checked = $false
            $RDrive.checked = $false
            $SDrive.checked = $false
            $TDrive.checked = $false
            $SVDrive.checked = $false
            $WDrive.checked = $false
            $XDrive.checked = $false
            $ZDrive.checked = $false
            $IT.Checked = $false
            $Prod.Checked = $false
            $Logistics.Checked = $false
            $Sales.Checked = $false 
            $CustService.Checked = $false
            $Warranty.Checked = $false 
            $Finance.checked = $False}
})


####### User Options Logic #######

#Disable Manager ID Input Fields
     $managerid.Enabled = $false

#Disable Run Button
    $run.Enabled = $false

#User Input to enable Manager Field
 $userid.Add_TextChanged({
    if ($userid.text.Length -gt 1) {
        $managerID.Enabled = $true}
    else { $managerID.Enabled = $false}

    })


#Username Verification
$userid.Add_TextChanged({
    if ($userid.text.Length -gt 1){
        $user = $userid.Text
        $VUser = Get-ADUser -LDAPFilter "(sAMAccountName=$User)"
             If ($VUser -eq $Null)
	            { $Alaislabel.text = "@yourdomain.com"
                  $WarningLabel.text = $null}  
              				  
	  	     Else { $Alaislabel.text = $null
                   $WarningLabel.text = "Alias Already in Use!"
                   $managerID.Enabled = $false	}
               }
 })

 
#Require Manager Field to be populated or can't execute
   $managerID.Add_TextChanged({  
    if ($managerID.text.Length -gt 1) {
        $Run.Enabled = $true}
    else { $run.Enabled = $false}
 })

####### Execute Script to Create #######

$Run.Add_Click({ 

#Set intial Output
     $output.AppendText("`r`n") 

#Set Email Options
    $smtphost = "mail.domain.com"
    $from = "from@domain.com"
    $frompass = "account password"
    $timeout = "60"
  
#Set Domain Admin Email
    $domadmin = "systemadmin@domain.com"

#Set Help Desk Email
    $hemail = "help@domain.com"

# Unload all Modules for clean slate
    Remove-Module -Name MSOnline -ErrorAction Ignore
    Get-PSSession | Remove-PSSession 

# Load Modules Required
     $Pscribo= Get-Module -ListAvailable -name pscribo | Select-Object -ExpandProperty Name

    if ($Pscribo -eq "pscribo") {
         $output.AppendText("PSCribo Loaded")
         $output.AppendText("`r`n")
         }
    else { $output.AppendText("Pscribo Module Installing")
           $output.AppendText("`r`n")
            install-module -name pscribo -force
         }
    
    #Sets the Exchanger Server without Prompting or being Hardcoded
	    $server = (Get-ADGroupMember "exchange Servers" | select-object -expandProperty samaccountname -First 1)
	    $server = $server.TrimEnd('$')
	  		
    # Connect to Exchange Powershell
	    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$server/PowerShell/ -Authentication Kerberos
        #$output.ForeColor = [Drawing.Color]::Red
        $output.AppendText("Importing Exchange Powershell")
        $output.AppendText("`r`n")
	    Import-PSSession $Session

# Set Exchange Database To one like MXDB (Non mobile)
    if ($ComPhone.Checked -eq $true) {
             $Database = Get-Mailbox | Group-Object -Property:Database | Where-Object {$_.name -like "*Mobile*"} | Select-Object Name,Count | Sort-Object Count | Select-Object -ExpandProperty Name -first 1}
        Else {
             $Database = Get-Mailbox | Group-Object -Property:Database | Where-Object {$_.name -like "*MXDB*"} | Select-Object Name,Count | Sort-Object Count | Select-Object -ExpandProperty Name -first 1}
	
# Connect to Active Directory Powershell
    import-module C:\Windows\System32\WindowsPowerShell\v1.0\Modules\ActiveDirectory\ActiveDirectory.psd1
    #$output.ForeColor = [Drawing.Color]::Red
    $output.AppendText("Importing Active Directory Powershell")
    $output.AppendText("`r`n")
    
######## Set Script Variables ########

#Set $User to Input Field
	$User = $UserID.Text

#Set $Manager to Input Field
	$Manager = $managerID.Text

#Set $First to Input Field
    $First = $FirstName.Text

#Set $Last to Input Field
    $Last = $Lastname.Text

#Set Password Variables to Input Field
    $password = $TextBox2.Text | ConvertTo-SecureString -AsPlainText -Force
    $passwordfile = $textbox2.Text

#Set $Title to Input Field
    $Title = $JobTitle.Text

#Set Extension to Input Field
    $ext = $Extension.Text


####### Create New Domain User #######

#add delay for Variables to apply
 $output.AppendText("5 Second Delay for Variables to Apply")
 $output.AppendText("`r`n")   
 sleep -seconds 5

# Create the account either with email or no email address
if ($Email.Checked -eq $true) { 
            $output.ForeColor = [Drawing.Color]::Green
            $output.AppendText("Create user Using Exchange Command")
            $output.AppendText("`r`n")
            new-mailbox -UserPrincipalName ($user + "@domain.com") -alias $user -Database $database -Name ($First+" "+$Last) -OrganizationalUnit $Dept -Password $password -FirstName $First -LastName $Last -DisplayName "$first $last"}
        else { $output.ForeColor = [Drawing.Color]::Green
               $output.AppendText("Create user Using AD Command")
               $output.AppendText("`r`n")
               New-ADUser -Name $user -DisplayName "$first $last" -AccountPassword $password -GivenName $first -Surname $last -path $Dept -userprincipalname ($user + "@domain.com")
               Enable-ADAccount -Identity $user
                        } 
#Add Delay for Account Creation
    $output.AppendText("60 Second Delay for Account Creation to Replicate")
    $output.AppendText("`r`n") 
    sleep -Seconds 15
    $output.AppendText("45 Seconds Remaning")
    $output.AppendText("`r`n")
    sleep -Seconds 15
    $output.AppendText("30 Seconds Remaning")
    $output.AppendText("`r`n")
    sleep -Seconds 15
    $output.AppendText("15 Seconds Remaning")
    $output.AppendText("`r`n")
    sleep -Seconds 15
    
# Add Account Options to User

    # Set AX user if Checked
        if($AX.Checked -eq $true) {
            Add-ADGroupMember -Identity  "Security Group" -Members $User
            $output.ForeColor = [Drawing.Color]::Green
            $output.AppendText("$User added to Security Group")
            $output.AppendText("`r`n")}

    # Set Office 365 Licensing if checked
        if($Office.Checked -eq $True) {  Add-ADGroupMember -Identity  "Security Group" -Members $User
            $output.ForeColor = [Drawing.Color]::Green
            $output.AppendText("$User Office Security Group Added")
            $output.AppendText("`r`n")}
 
     #Set New Hire Group membership
        if ($Email.Checked -eq $true) { 
             Add-ADGroupMember -Identity  "Security Group" -Members $User 
             $output.ForeColor = [Drawing.Color]::Green
             $output.AppendText("$User added to Security Group KnowBe4")
             $output.AppendText("`r`n")}
                
    # Set User Company
        Set-ADUser -Identity $user -Company "COMPANY" 
        sleep -seconds 1

    # Set Company Department
        Set-ADUser -Identity $user -Department $DeptName 
        sleep -seconds 1
    
    # Set User Title   
        Set-ADUser -Identity $user -Title $Title
        sleep -seconds 1
    
    # Set User Manager
        Set-ADUser -Identity $user -Manager $Manager
        sleep -seconds 1
    
    # Set User Description 
        Set-ADUser -Identity $user -Description $Title
        sleep -seconds 1

    # Set Office Extension
        Set-ADUser -Identity $user -OfficePhone $ext
        sleep -seconds 1


    # Set Logi House if Checked
        if($LogiHouse.Checked -eq $true) {
             Add-ADGroupMember -Identity  "Distrubition Group for Logihouse" -Members $User 
             Set-ADUser -Identity $user -Office "Company Building" -City "Where" -state "State" -PostalCode "Postal" -Country "US" -StreetAddress "Street Address"
             $output.ForeColor = [Drawing.Color]::Green
             $output.AppendText("$User added to Logi House")
             $output.AppendText("`r`n")}

    # Set HQ if Checked
        if($HQ.Checked -eq $True) {
             Add-ADGroupMember -Identity "Distrubition Group for HQ" -Members $User
             Set-ADUser -Identity $user -Office "Company Building" -City "Where" -state "State" -PostalCode "Postal" -Country "US" -StreetAddress "Street Address"
             $output.ForeColor = [Drawing.Color]::Green
             $output.AppendText("$User added to Company HQ")
             $output.AppendText("`r`n")}
    
    # Set Papercut user if Checked
        if($Papercut.Checked -eq $true) {
            Add-ADGroupMember -Identity  "Security Group" -Members $User
            $output.ForeColor = [Drawing.Color]::Green
            $output.AppendText("$User added to Papercut")
            $output.AppendText("`r`n")}

    # Set Cell Phone Group if checked
        if($ComPhone.Checked -eq $True) {  
            Add-ADGroupMember -Identity  "Security Group" -Members $User
            $output.ForeColor = [Drawing.Color]::Green
            $output.AppendText("$User Iphone User Group Added")
            $output.AppendText("`r`n")}


# Add Network Drive Security Groups
    if($HDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Housewares (H) Drive Added")
        $output.AppendText("`r`n")} 
        
    if($JDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Label (J) Drive Added")
        $output.AppendText("`r`n")}             
            
    if($IDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("EDI (I) Drive Added")
        $output.AppendText("`r`n")}

    if($KDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("K (IT) Drive Added")
        $output.AppendText("`r`n")}

    if($MDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("M2M (M) Drive Added")
        $output.AppendText("`r`n")}

    if($ODrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Warranty (O) Drive Added")
        $output.AppendText("`r`n")}

    if($PDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Cad Shared File (P) Drive Added")
        $output.AppendText("`r`n")}
 
    if($QDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Customer Service (Q) Drive Added")
        $output.AppendText("`r`n")}
 
    if($RDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Shop Floor (R) Drive Added")
        $output.AppendText("`r`n")}

    if($SDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        Add-ADGroupMember -Identity "SecurityGroup For Drive x2" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Shipping (S) Drive Added")
        $output.AppendText("`r`n")}

    if($TDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Contoller (T) Drive Added")
        $output.AppendText("`r`n")}

    if($UDrive.Checked -eq $True) {
        # Create Help Desk Ticket
        
        #email body
        $body = " 

         #assign $domadmin
         
         U: Drive Create Requested for $user.  Please Create drive and assign security premissions to $user on User File Share location
         "    
        #Send Email
        $body = ($Body | Out-String)
        $emailUDmessage = New-Object System.Net.Mail.MailMessage ($from , $hemail)
        $emailUDmessage.Subject = "UDrive Requested for $User"
        $emailUDmessage.Body = "$body"

        $SMTPClient = New-Object System.Net.Mail.SmtpClient( $smtphost )
        $SMTPClient.EnableSsl = $False
        $SMTPClient.Credentials = New-Object System.Net.NetworkCredential( $from , $frompass );
        $SMTPClient.Send( $emailUDMessage )
       
        $output.ForeColor = [Drawing.Color]::Red
        $output.AppendText("Personal Drive Help Desk Ticket Created")
        $output.AppendText("`r`n")}

    if($SVDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("SVN (V) Drive Added")
        $output.AppendText("`r`n")}
 
    if($WDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Machine Control (W) Drive Added")
        $output.AppendText("`r`n")}

    if($XDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Receiving Inspection (X) Drive Added")
        $output.AppendText("`r`n")}
 
    if($ZDrive.Checked -eq $True) {
        Add-ADGroupMember -Identity "SecurityGroup For Drive" -Members $User
        $output.ForeColor = [Drawing.Color]::Green
        $output.AppendText("Finance (Z) Drive Added")
        $output.AppendText("`r`n")}
  
########## Create Word Document for New User ##########

# Create Word Document and HTML Document if Needed
    if ($email.Checked -eq $true) { 
               
         Document "$User" {

                   Paragraph -Style Heading1 "Welcome to the Company Network" -Bold -Size 18
                   BlankLine
                   BlankLine        
                   Paragraph "$First $Last," -Bold -Italic
                   BlankLine
                   Paragraph "Here at the COMPANY you will have access to a number of computer resources. To access these resources, you will use the network login of $user, with the password of $Passwordfile on the domain."
                   BlankLine
                   Paragraph "You will have the email address of $User@domain.com to send and receive email."
                   BlankLine
                   Paragraph "We currently use Microsoft Office for documents and email. If you have any questions on these programs please let your manager or the IT Department know so we can get you basic training in these tools if needed."
                   BlankLine
                   Paragraph "The first time you open an Office application it will ask you for your name and initials. Please enter them as requested. When you open Outlook for the first time is will ask you if you wish to connect to an email server, please say yes and choose 'Exchange' and next at the bottom of the windows. Outlook should detect your user settings and create your profile automatically. If you have any issues with the setup or network, please contact IT for assistance."
                   BlankLine
                   Paragraph "Our email server can also be accessed remotely via the web at HTTPS://mail.domain.com/owa"
                   BlankLine
                   Paragraph "Computer support is offered from the email address help@domain.com. Please send email for all support requests. We have a helpdesk that tracks support request and allows quick response and issue tracking."
                   BlankLine
                   Paragraph "The main number for company is (XXX) XXX-XXXX. "
                   BlankLine
                   BlankLine
                   Paragraph "Thank You,"
                   Paragraph "Company Information Technology Team" -Italic



} | Export-Document -Path "\\server\filepath\New User(s)\" -Format html,Word

        # Create Email
            $HTML = Get-Content "\\server\filepath\$User.HTMl"

        # Set Email Variables for User Accounts
            $User = ($User + "@domain.com")
            $Manager = ($Manager + "@domain.com")
            $HR = "HR@domain.com"

        # Send Email Message
            $HTML = ($HTML | Out-String)
            $emailmessage = New-Object System.Net.Mail.MailMessage ($from , $User)
            $emailmessage.cc.Add( $Manager )
            $emailmessage.CC.Add( $HR )
            $emailmessage.Subject = "Welcome to the Company $User"
            $emailmessage.IsBodyHtml = $true
            $emailmessage.Body = "$HTML"

            $SMTPClient = New-Object System.Net.Mail.SmtpClient( $smtphost )
            $SMTPClient.EnableSsl = $False
            $SMTPClient.Credentials = New-Object System.Net.NetworkCredential( $from , $frompass );
            $SMTPClient.Send( $emailMessage )
            $output.AppendText("Sending Email to $Manager,$HR,and $User")
            $output.AppendText("`r`n")

            
            #Send-MailMessage -to ($User + "@domain.com") -cc ($Manager + "@domain.com"),HR@domain.com -From $from -SmtpServer $smtphost -Subject "Welcome to the Company $User" -BodyAsHtml -Body ($html | Out-String)
             }
       else { Document "$User" {

                   Paragraph -Style Heading1 "Welcome to the Company Network" -Bold -Size 18
                   BlankLine
                   BlankLine        
                   Paragraph "$First $Last," -Bold -Italic
                   BlankLine
                   Paragraph "Here at the COMPANY you will have access to a number of computer resources. To access these resources, you will use the network login of $user, with the password of $Passwordfile on the company domain."
                   BlankLine
                   Paragraph "We currently use Microsoft Office for documents and email. If you have any questions on these programs please let your manager or the IT Department know so we can get you basic training in these tools if needed."
                   BlankLine
                   Paragraph "The first time you open an Office application it will ask you for your name and initials. Please enter them as requested. If you have any issues with the setup or network, please contact IT for assistance."
                   BlankLine
                   Paragraph "Computer support is offered from the email address help@domain.com or via calling extension XXXX. If you do not have access to email please have your manager submit a helpdesk ticket if the situation is not an emergency. We have a helpdesk that tracks support request and allows quick response and issue tracking."
                   BlankLine
                   Paragraph "The main number for Company is (XXX) XXX-XXXX."
                   BlankLine
                   BlankLine
                   Paragraph "Thank You,"
                   Paragraph "Company Information Technology Team" -Italic



} | Export-Document -Path "\\server\filepath\New User(s)\" -Format html,Word

        # Create Email
            $HTML = Get-Content "\\server\filepath\$User.HTMl"

        # Set Email Variables for User Accounts
            $Manager = ($Manager + "@domain.com")
            $HR = "HR@domain.com"
        
        # Send Email Message
            $HTML = ($HTML| Out-String)
            $emailmessage = New-Object System.Net.Mail.MailMessage ($from , $Manager)
            $emailmessage.CC.Add( $HR )
            $emailmessage.Subject = "Welcome to the Company $User"
            $emailmessage.IsBodyHtml = $true
            $emailmessage.Body = "$HTML"

            $SMTPClient = New-Object System.Net.Mail.SmtpClient( $smtphost )
            $SMTPClient.EnableSsl = $False
            $SMTPClient.Credentials = New-Object System.Net.NetworkCredential( $from , $frompass );
            $SMTPClient.Send( $emailMessage )
            $output.AppendText("Sending Email to $Manager, and $HR")
            $output.AppendText("`r`n")

            #Send-MailMessage -to ($Manager + "@domain.com"),HR@domain.com -From $from -SmtpServer $smtphost -Subject "Welcome to the Company $User" -BodyAsHtml -Body ($html | Out-String)
             }

# Disable Create Button
    $run.Enabled = $false

#Final Update to Output
    $output.AppendText("New User Script completed for $User")
    $output.AppendText("`r`n")

 })


 ########  Close GUI ########

$Close.Add_Click({ $form.close() })
    
  



# The Following line needs to be executed last  
    [void]$Form.ShowDialog()

