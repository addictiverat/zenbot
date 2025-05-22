# Placeholder function for showing system information
function Show-SystemInfo {
    Write-Host "Showing System Information..."
    # Add actual commands to display system info, e.g., Get-ComputerInfo
    Get-ComputerInfo | Out-String -Width 120 # Example, might need to adjust width
    Read-Host "Press Enter to continue..."
}

# Placeholder function for listing directory contents
function List-DirectoryContents {
    $path = Read-Host "Enter the path of the directory to list (e.g., C:\Users)"
    if (Test-Path $path -PathType Container) {
        Write-Host "Listing contents of directory: $path"
        Get-ChildItem -Path $path | Select-Object Name, Mode, LastWriteTime | Format-Table -AutoSize
    } else {
        Write-Host "Error: Directory not found or invalid path: $path" -ForegroundColor Red
    }
    Read-Host "Press Enter to continue..."
}

# Placeholder function for running a custom script
function Run-CustomScript {
    $scriptPath = Read-Host "Enter the full path to the PowerShell script to run"
    if (Test-Path $scriptPath -PathType Leaf -Patter '*.ps1') {
        Write-Host "Running script: $scriptPath"
        # Invoke the script. Use Invoke-Expression carefully or consider other methods for security.
        # For simplicity here, we'll just output the intent.
        # Invoke-Expression -Command "& '$scriptPath'"
        Write-Host "Placeholder: Would execute $scriptPath here."
    } else {
        Write-Host "Error: Script not found or invalid path: $scriptPath" -ForegroundColor Red
    }
    Read-Host "Press Enter to continue..."
}

# Main loop for the menu
while ($true) {
    Clear-Host
    Write-Host "=========================="
    Write-Host "   PowerShell Admin Menu  "
    Write-Host "=========================="
    Write-Host "Select an option:"
    Write-Host "1. Show System Information"
    Write-Host "2. List Directory Contents"
    Write-Host "3. Run a Custom Script"
    Write-Host "Q. Quit"
    Write-Host "=========================="

    $choice = Read-Host "Enter your choice"

    switch ($choice) {
        "1" {
            Show-SystemInfo
        }
        "2" {
            List-DirectoryContents
        }
        "3" {
            Run-CustomScript
        }
        "Q" {
            Write-Host "Exiting menu."
            exit
        }
        default {
            Write-Host "Invalid option. Press Enter to try again..." -ForegroundColor Yellow
            Read-Host
        }
    }
}
