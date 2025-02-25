function Generate-FlaskCrudFromSchema {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ProjectPath,
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    Write-HostColored -Color "Yellow" "`n=== Génération du CRUD Flask à partir du schema ==="

    # Chemin source du schema
    $source = Join-Path $PSScriptRoot "\schema"
    if (!(Test-Path $source)) {
        Write-HostColored -Color "Red" "Le dossier schema n'existe pas : $source"
        return
    }

    # Récupérer tous les éléments du dossier schema récursivement
    $items = Get-ChildItem -Path $source -Recurse

    foreach ($item in $items) {
        # Calcul du chemin relatif à partir du dossier source
        $relPath = $item.FullName.Substring($source.Length).TrimStart('\')
        # Remplacer {name} dans le chemin (nom de dossier ou nom de fichier)
        $destRelPath = $relPath -replace "\{name\}", $Name
        $destPath = Join-Path $ProjectPath $destRelPath

        if ($item.PSIsContainer) {
            if (!(Test-Path $destPath)) {
                New-Item -ItemType Directory -Path $destPath -Force | Out-Null
            }
        }
        else {
            # Pour un fichier, on lit son contenu, on remplace {name} par le nom voulu, puis on l'écrit dans la destination.
            $content = Get-Content $item.FullName -Raw
            $content = $content -replace "\{name\}", $Name
            $destDir = Split-Path $destPath
            if (!(Test-Path $destDir)) {
                New-Item -ItemType Directory -Path $destDir -Force | Out-Null
            }
            $content | Out-File $destPath -Encoding utf8
        }
    }

    Write-HostColored -Color "Green" "CRUD Flask généré à partir du schema avec le nom '$Name'."
}
