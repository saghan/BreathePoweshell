[string[]]$file_data = Get-Content $PSScriptRoot"\quotes.txt" -Raw
$file_data = $file_data.Split([Environment]::NewLine, [StringSplitOptions]::RemoveEmptyEntries)
Write-Host $file_data.Length
$line_num =0

foreach($line in $file_data){
Write-Host $line
}

while($true){
$StartTime = Get-Date
    $EndTime = $StartTime.AddSeconds(6)
$ErrorActionPreference = "Stop"

[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

$APP_ID = '110366bd-56e2-47ed-9bdf-3ce1fa408b6c'

$line = $file_data[$line_num%$file_data.Length]

$template = @"
<toast>
    <visual>
        <binding template="ToastText02">
            <text id="1">Relax</text>
            <text id="2">$line</text>
        </binding>
    </visual>
</toast>
"@
$line_num++
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($template)
$toast = New-Object Windows.UI.Notifications.ToastNotification $xml
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($APP_ID).Show($toast)
Start-Sleep -Seconds $( [int]( New-TimeSpan -End $EndTime ).TotalSeconds )
}