function Write-HostColored {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White")]
        [String]$Color,

        [Parameter(Mandatory=$true)]
        [String]$Message
    )
    Write-Host $Message -ForegroundColor $Color
}

function Read-HostColored {
    param(
        [Parameter(Mandatory=$true)]
        [String]$Prompt,
        [String]$Color = "Cyan"
    )
    Write-HostColored -Color $Color $Prompt
    return Read-Host
}

# Pas de Export-ModuleMember ici
