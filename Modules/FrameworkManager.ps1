function Select-Framework {
    Write-HostColored -Color "Yellow" "`n=== Choix framework projet ==="
    Write-HostColored -Color "White" "[1] - Flask (python)"
    Write-HostColored -Color "White" "[2] - Symfony (php)"
    Write-HostColored -Color "White" "[3] - SpringBoot (java)"

    $choice = Read-HostColored -Prompt "Votre choix : [1,2,3]" -Color "Yellow"
    switch ($choice) {
        '1' {
            Write-HostColored -Color "Cyan" "Vous avez choisi Flask (python)."
            # ICI : Vérifier Python / Flask, installer si besoin via choco
            return "Flask (python)"
        }
        '2' {
            Write-HostColored -Color "Cyan" "Vous avez choisi Symfony (php)."
            return "Symfony (php)"
        }
        '3' {
            Write-HostColored -Color "Cyan" "Vous avez choisi SpringBoot (java)."
            return "SpringBoot (java)"
        }
        default {
            Write-HostColored -Color "Red" "Choix invalide, on prend Flask (python) par défaut."
            return "Flask (python)"
        }
    }
}
