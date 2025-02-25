Param(
    [Parameter(Mandatory=$true)] [string]$Framework,
    [Parameter(Mandatory=$true)] [string]$ProjectPath,
    [Parameter(Mandatory=$true)] $DbInfo
)

function Generate-ProjectStructure {
    Write-HostColored -Color "Yellow" "`n=== Génération de la structure du projet ==="

    # On crée tout dans $ProjectPath directement.
    # On suppose DbInfo.Table est le nom de la table. On s'en sert pour un dossier JS et un dossier templates
    $tableName = $DbInfo.Table
    if (-not $tableName) { $tableName = "DefaultTable" }

    $directories = @(
        "Controller",
        "Entity",
        "Service",
        "Datatable",
        "Repository",
        "Setup\DB",
        "static\js\$tableName",
        "templates\$tableName\Fragments\Modals"
    )

    foreach ($dir in $directories) {
        $fullDir = Join-Path $ProjectPath $dir
        if (!(Test-Path $fullDir)) {
            New-Item -ItemType Directory -Path $fullDir -Force | Out-Null
        }
    }

    # Fichier base.html
    $baseHtmlPath = Join-Path $ProjectPath "templates\base.html"
    if (!(Test-Path $baseHtmlPath)) {
        "Base HTML template" | Out-File $baseHtmlPath -Encoding utf8
    }

    # Fichier ConnectionString
    $connStringPath = Join-Path $ProjectPath "Setup\DB\ConnectionString"
    if (!(Test-Path $connStringPath)) {
        "Host=$($DbInfo.Host); Database=$($DbInfo.Database)" | Out-File $connStringPath -Encoding utf8
    }

    Write-HostColored -Color "Green" "Structure du projet pour $Framework générée avec succès."
}
