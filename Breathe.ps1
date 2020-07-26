
if (Get-Module -ListAvailable -Name BurntToast) {
    
} 
else {
    Install-Module -Name BurntToast
}

Write-Host "Breathe: Developed by Microsoft Hackathon Group"
$nl = [Environment]::NewLine
Write-Host $nl

$interval = Read-Host -Prompt 'At what interval do you want  to take a break? (in minutes)'

[string[]]$file_data = Get-Content $PSScriptRoot"\quotes.txt" -Raw
$file_data = $file_data.Split([Environment]::NewLine, [StringSplitOptions]::RemoveEmptyEntries)
$line_num =0

while($true){
$StartTime = Get-Date
    $EndTime = $StartTime.AddMinutes($interval)
    $ExpirationTime =$StartTime.AddSeconds(20)
$ErrorActionPreference = "Stop"

[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

$APP_ID = 'BreatheAppID'

$line = $file_data[$line_num%$file_data.Length]

$image_arr = "rocket.png", "rocket.png", "butterfly.jpg", "flower.jpg", "cloud.png"
$image_name = $image_arr[$line_num%$file_data.Length]
$line_num++
New-BurntToastNotification -Silent -ExpirationTime $EndTime  -AppLogo $PSScriptRoot"\images\"$image_name -Text "Reminder to take a break",
                                                           $line.ToString() 
Start-Sleep -Seconds $( [int]( New-TimeSpan -End $EndTime ).TotalSeconds )

}