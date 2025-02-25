Param(
    [Parameter(Mandatory=$true)]
    [string]$Action,

    [Parameter(Mandatory=$false)]
    [string]$ProjectName
)

# Vérification du mode administrateur si nécessaire
<#
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Veuillez relancer ce script en tant qu'administrateur."
    exit
}
#>

. "$PSScriptRoot\Modules\Utility.ps1"
. "$PSScriptRoot\Modules\CheckChocolatey.ps1"
. "$PSScriptRoot\Modules\FrameworkManager.ps1"
. "$PSScriptRoot\Modules\DatabaseManager.ps1"

Write-HostColored -Color "Yellow" "`n=== AutoWork - Script de génération de projets ===`n"

switch ($Action.ToLower()) {
    'create' {
        if (-not $ProjectName) {
            Write-HostColored -Color "Red" "Veuillez spécifier un nom de projet. (Ex: .\AutoWork.ps1 create ItemProjet)"
            return
        }

        # Vérifier/installer Chocolatey
        Check-Chocolatey

        # Chemin complet du projet
        $fullProjectPath = Join-Path (Get-Location) $ProjectName

        if (!(Test-Path $fullProjectPath)) {
            New-Item -ItemType Directory -Path $fullProjectPath | Out-Null
            Write-HostColored -Color "Green" "Dossier '$ProjectName' créé avec succès."
        }
        else {
            Write-HostColored -Color "Yellow" "Le dossier '$ProjectName' existe déjà."
        }

        Set-Location $fullProjectPath
        Write-HostColored -Color "Cyan" "Vous êtes maintenant dans $(Get-Location)."

        # Sélection du framework
        $selectedFramework = Select-Framework

        # Configuration de la base de données
        $dbConnectionInfo = Manage-Database

        # Ici, pour l'exemple Flask, on souhaite utiliser le schema
        # On suppose que la propriété Table de $dbConnectionInfo contient le nom à utiliser
        if (-not $dbConnectionInfo.Table) {
            Write-HostColored -Color "Red" "Aucune table n'a été configurée. Annulation du CRUD."
            return
        }
        # Importation et appel de la fonction de génération depuis le schema
        . "$PSScriptRoot\Modules\CrudGenerator\Flask\Generate-FlaskCrudFromSchema.ps1"
        Generate-FlaskCrudFromSchema -ProjectPath $fullProjectPath -Name $dbConnectionInfo.Table

        Write-HostColored -Color "Green" "`n=== Projet '$ProjectName' généré avec succès! ==="
    }
    default {
        Write-HostColored -Color "Red" "Action inconnue : $Action. Seul 'create' est supporté pour l'instant."
    }
}
