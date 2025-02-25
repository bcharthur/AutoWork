function Manage-Database {
    Write-HostColored -Color "Yellow" "`n=== Configuration de la base de données ==="

    $dbHost = Read-HostColored -Prompt "Adresse de la machine (localhost si local)" -Color "Yellow"
    if (!$dbHost) { $dbHost = "localhost" }

    # On simule l'absence de service SQL détecté
    $detected = $false

    if (-not $detected) {
        Write-HostColored -Color "Yellow" "Aucun service SQL détecté sur $dbHost."
        $respInstallDb = Read-HostColored -Prompt "Souhaitez-vous en installer un ? (y/n)" -Color "Yellow"
        if ($respInstallDb.ToLower() -eq 'y') {
            Write-HostColored -Color "Yellow" "Choisissez votre service SQL :"
            Write-Host "[1] - MySQL"
            Write-Host "[2] - SQLServer"
            Write-Host "[3] - PostGre"
            $dbChoice = Read-HostColored -Prompt "Votre choix : " -Color "Yellow"

            switch ($dbChoice) {
                '1' {
                    Write-HostColored -Color "Cyan" "Installation de MySQL via Chocolatey..."
                    choco install mysql --yes
                    Write-HostColored -Color "Green" "MySQL installé."
                    $serviceType = "MySQL"
                }
                '2' {
                    Write-HostColored -Color "Cyan" "Installation de SQL Server via Chocolatey..."
                    choco install sql-server --yes
                    Write-HostColored -Color "Green" "SQL Server installé."
                    $serviceType = "SQLServer"
                }
                '3' {
                    Write-HostColored -Color "Cyan" "Installation de PostgreSQL via Chocolatey..."
                    choco install postgresql --yes
                    Write-HostColored -Color "Green" "PostgreSQL installé."
                    $serviceType = "PostGre"
                }
                default {
                    Write-HostColored -Color "Red" "Choix invalide, MySQL par défaut."
                    $serviceType = "MySQL"
                }
            }
        } else {
            Write-HostColored -Color "Red" "Aucun service DB installé. On continue quand même."
            $serviceType = "none"
        }
    } else {
        # On aurait détecté un service existant
        $serviceType = "MySQL"
    }

    if ($serviceType -ne "none") {
        $dbName = Read-HostColored -Prompt "Nom de la base de données à créer ou utiliser :" -Color "Yellow"
        if (!$dbName) { $dbName = "default_db" }

        Write-HostColored -Color "Cyan" "Création de la base '$dbName' (ou déjà existante)."
        # Ex: CREATE DATABASE $dbName ...

        $createTable = Read-HostColored -Prompt "Souhaitez-vous créer une table ? (y/n)" -Color "Yellow"
        if ($createTable.ToLower() -eq 'y') {
            $tableName = Read-HostColored -Prompt "Nom de la table :" -Color "Yellow"
            if (!$tableName) { $tableName = "table1" }

            Write-HostColored -Color "Green" "Colonne 'id' générée (PK, auto_incr)."
            $columns = @("id, int auto_increment primary key")

            $moreCols = "y"
            while ($moreCols.ToLower() -eq "y") {
                $colName = Read-HostColored -Prompt "Nom de la colonne :" -Color "Yellow"
                $colType = Read-HostColored -Prompt "Type (varchar, int, etc.):" -Color "Yellow"
                $colSize = Read-HostColored -Prompt "Taille (ex: 255) ou vide :" -Color "Yellow"

                if ($colName -and $colType) {
                    if ($colSize) {
                        $columns += "$colName $colType($colSize)"
                    } else {
                        $columns += "$colName $colType"
                    }
                }
                $moreCols = Read-HostColored -Prompt "Ajouter une autre colonne ? (y/N)" -Color "Yellow"
            }

            Write-HostColored -Color "Green" "Table '$tableName' créée (fictive) avec les colonnes :"
            foreach ($col in $columns) {
                Write-Host " - $col"
            }
        } else {
            $tableName = $null
        }

        return @{
            Host        = $dbHost
            ServiceType = $serviceType
            Database    = $dbName
            Table       = $tableName
        }
    } else {
        return @{
            Host        = $dbHost
            ServiceType = "none"
            Database    = $null
            Table       = $null
        }
    }
}
