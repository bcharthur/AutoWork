function Check-Chocolatey {
    $choco = Get-Command choco.exe -ErrorAction SilentlyContinue
    if ($null -eq $choco) {
        Write-HostColored -Color "Yellow" "Chocolatey n'est pas installé sur cette machine."
        $userResponse = Read-HostColored -Prompt "Chocolatey est nécessaire. L'installer ? (y/N)" -Color "Yellow"

        if ($userResponse.ToLower() -eq 'y') {
            Write-HostColored -Color "Green" "Installation de Chocolatey en cours..."
            Set-ExecutionPolicy Bypass -Scope Process -Force
            Invoke-Expression (New-Object Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')
            Write-HostColored -Color "Green" "Chocolatey installé avec succès."
        } else {
            Write-HostColored -Color "Red" "Vous avez refusé. Certaines fonctionnalités ne marcheront pas."
        }
    } else {
        Write-HostColored -Color "Green" "Chocolatey est déjà installé."
    }
}
