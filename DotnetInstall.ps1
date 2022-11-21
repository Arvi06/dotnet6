$URL = "https://download.visualstudio.microsoft.com/download/pr/8de163f5-5d91-4dc3-9d01-e0b031a03dd9/0170b328d569a49f6f6a080064309161/dotnet-hosting-7.0.0-win.exe"
$Destination = "C:\inetpub\temp\"
$DotNETCoreUpdatesPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Updates\.NET" 
$DotNetCoreItems = Get-Item -ErrorAction Stop -Path $DotNETCoreUpdatesPath 
$NotInstalled = $True 
$DotNetCoreItems.GetSubKeyNames() | Where { $_ -Match "Microsoft .NET .*Windows Server Hosting" } | ForEach-Object { 
    $NotInstalled = $False 
    Write-Host "The host has already installed $_" 
	$okToDeploy = $true
} 
If ($NotInstalled) { 

    Write-Host "Can not find Microsoft.NET Hosting Bundle installed on the host"
    
    Write-Host "Installing .NET Hosting Bundle"
    Invoke-WebRequest -Uri $URL -OutFile $Destination\dotnet-hosting-7.0.0-win.exe
    Write-Host "Successfully Installed .NET Hosting Bundle"

    Write-Host "Running .exe file"
    cd "$Destination" 
    ./dotnet-hosting-7.0.0-win.exe /S /v /qn
} 