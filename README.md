# Roblox-Multi-Instance-Script

Instructions:
* Download [Handle](https://learn.microsoft.com/en-us/sysinternals/downloads/handle) (a tool from Microsoft's Sysinternals)
* Open CloseRobloxSingleton.ps1 in a text editor
* Put the path to `handle.exe` in $HandleExe
  * Example: `$HandleExe   = "C:\Users\Clayel\Downloads\Handle\handle.exe"`
* Save and close CloseRobloxSingleton.ps1
* Run Powershell (not Command Prompt) as Administrator (Handle requires Administrator permissions to function)
  * Open taskbar, type in Powershell, right click, hit "Run as Administrator"
* Navigate to the folder where the script is downloaded
  * Example: `cd C:\Users\Clayel\Downloads`
* Allow the script to be run as an Administrator
  * ``Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass``
  * Type `Y` or `y` to allow it to be run
* Run the script
  * `.\CloseRobloxSingleton.ps1`

![Using the Script](https://i.imgur.com/sdw9UTg.png)

The script will then automatically close the `ROBLOX_singletonEvent` event handle when it appears, allowing you to run as many instances of Roblox as you wish. It will continuously run, so if you close Roblox and open it again it will still close the event handle as normal. To stop the script, close the Powershell window.

Due to Handle being Windows-specific, this script only works on Windows operating systems.

Generously made by ChatGPT in about 2 hours of debugging. (I certainly don't know how to code in Powershell's language, heh)
