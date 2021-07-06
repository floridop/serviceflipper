# Powershell serviceflipper script for Spool service
Powershell script to flip the windows spool service on/off to mitigate CVE-2021-34527

## Disclaimer
I quickly wrote this to mitigate the PrintNightmare thing, so that a user with admin rights can turn on the service on demand quickly.
It is no solution to the problem and to activate it one needs to lower the powershell security, so it is only recommended for users who know what they're doing.
  - Use at your own risk.
  - Remember to reset powershell security after M$ releases a good patch

## Prerequisites

1. In the search bar write "PowerShell"
2. Right click on the powershell icon and select "Run as Administrator" 
3. Change your powershell executions security to ```RemoteSigned``` 

```powershell
   Set-ExecutionPolicy RemoteSigned
```
Answer Y at the prompt. You can restore this later using either `AllSigned` or `Restricted`.

## Usage

Every time you run the script it will either kill the spooler if it's on, or start it if it is off.
1. Copy the script on your desktop
2. right click and select "Run with PowerShell"
3. Accept the administrative rights elevation (services can only be managed by admins) 
4. Read the status of the service, push any key to exit the script
5. Run again to trigger the service on or off

## Acknowledgements

This is my first powershell script. I took inspiration from:
- https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-34527
- <https://www.windowscentral.com/how-create-and-run-your-first-powershell-script-file-windows-10>
- <https://stackoverflow.com/questions/35064964/powershell-script-to-check-if-service-is-started-if-not-then-start-it>
- https://superuser.com/questions/108207/how-to-run-a-powershell-script-as-administrator
