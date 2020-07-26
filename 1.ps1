$file_data = Get-Content $PSScriptRoot"\quotes.txt"
$line_num =0
while($true){
$StartTime = Get-Date
    $EndTime = $StartTime.AddSeconds(6)
$ErrorActionPreference = "Stop"

$notificationTitle = "Notification: " + [DateTime]::Now.ToShortTimeString()
$notificationContent = "notification content"

[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText01)

#Convert to .NET type for XML manipulation
$toastXml = [xml] $template.GetXml()
$toastXml.GetElementsByTagName("text").AppendChild($toastXml.CreateTextNode($notificationTitle)) > $null

#Convert back to WinRT type
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($toastXml.OuterXml)

$toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
$toast.Tag = "PowerShell"
$toast.Group = "PowerShell"
$toast.ExpirationTime = [DateTimeOffset]::Now.AddSeconds(30)
#$toast.SuppressPopup = $true

$notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("PowerShell")
$notifier.Show($toast);
Start-Sleep -Seconds $( [int]( New-TimeSpan -End $EndTime ).TotalSeconds )
}