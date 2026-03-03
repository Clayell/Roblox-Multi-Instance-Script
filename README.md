# Roblox-Multi-Instance-Script

Normal Instructions: (will automatically run at startup)
* Download this repository and unzip it
  * Green Code Button in Top Right -> Download ZIP -> Right click on file -> Extract All -> Extract
* Download [Handle](https://learn.microsoft.com/en-us/sysinternals/downloads/handle) (a tool from Microsoft's Sysinternals)
* Open CloseRobloxSingleton.ps1 in a text editor
* Put the path to `handle.exe` in $HandleExe
  * Example: `$HandleExe   = "C:\Users\Clayel\Downloads\Handle\handle.exe"`
* Save and close CloseRobloxSingleton.ps1
* Run Powershell (not Command Prompt) as Administrator (Handle requires Administrator permissions to function)
  * Open taskbar, type in Powershell, right click, hit "Run as Administrator"
* Navigate to the folder where the script is downloaded
  * Example: `cd C:\Users\Clayel\Downloads\RobloxMultiInstanceScript`
* Allow the script to be run as an Administrator
  * ``Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass``
  * Type `Y` or `y` to allow it to be run
* Run the schedule task script
  * `.\ScheduleTask.ps1`

You can confirm it is running by looking at the logs in CloseRobloxSingleton.txt.

![Using the schedule task script](https://i.imgur.com/tfNoeaa.png)
![The task in task scheduler](https://i.imgur.com/l1UXQ58.png)
![The txt file output](https://i.imgur.com/RQ4I5Nf.png)

The script schedules another script to automatically open on the computer's startup or when it awakes from sleep, and then run that script. This scheduled script will then automatically close the `ROBLOX_singletonEvent` event handle when it appears, allowing you to run as many instances of Roblox as you wish. It will continuously run, so if you close Roblox and open it again it will still close the event handle as normal. To stop the script, terminate all Powershell processes in Task Manager, and disable/delete the task in Task Scheduler.

---

Alternative Instructions: (must be run at every startup)
* Download this repository and unzip it
  * Green Code Button in Top Right -> Download ZIP -> Right click on file -> Extract All -> Extract
* Download [Handle](https://learn.microsoft.com/en-us/sysinternals/downloads/handle) (a tool from Microsoft's Sysinternals)
* Open CloseRobloxSingleton.ps1 in a text editor
* Put the path to `handle.exe` in $HandleExe
  * Example: `$HandleExe   = "C:\Users\Clayel\Downloads\Handle\handle.exe"`
* Save and close CloseRobloxSingleton.ps1
* Run Powershell (not Command Prompt) as Administrator (Handle requires Administrator permissions to function)
  * Open taskbar, type in Powershell, right click, hit "Run as Administrator"
* Navigate to the folder where the script is downloaded
  * Example: `cd C:\Users\Clayel\Downloads\RobloxMultiInstanceScript`
* Allow the script to be run as an Administrator
  * ``Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass``
  * Type `Y` or `y` to allow it to be run
* Run the  script
  * `CloseRobloxSingleton.ps1`

![Using the script manually](https://i.imgur.com/380R48Z.png)

The script automatically closes the `ROBLOX_singletonEvent` event handle when it appears, allowing you to run as many instances of Roblox as you wish. It will continuously run, so if you close Roblox and open it again it will still close the event handle as normal. To stop the script, close the Powershell window, or terminate all Powershell processes in Task Manager.

---

Due to Handle being Windows-specific, this script only works on Windows operating systems.

Generously made by ChatGPT in about 4 hours of debugging. (I certainly don't know how to code in Powershell's language, heh)
