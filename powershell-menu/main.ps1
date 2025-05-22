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

# Function to invoke Windows Defender scans
function Invoke-DefenderScan {
    Clear-Host
    Write-Host "=========================="
    Write-Host "  Windows Defender Scan   "
    Write-Host "=========================="
    Write-Host "Select a scan type:"
    Write-Host "1. Quick Scan"
    Write-Host "2. Full Scan"
    Write-Host "3. Custom Scan"
    Write-Host "B. Back to Main Menu"
    Write-Host "=========================="
    
    $scanChoice = Read-Host "Enter your choice"

    switch ($scanChoice) {
        "1" {
            Write-Host "Starting Quick Scan..." -ForegroundColor Green
            Start-MpScan -ScanType QuickScan
            Write-Host "Quick Scan finished." -ForegroundColor Green
        }
        "2" {
            Write-Host "Starting Full Scan..." -ForegroundColor Green
            Write-Host "This may take a long time."
            Start-MpScan -ScanType FullScan
            Write-Host "Full Scan finished." -ForegroundColor Green
        }
        "3" {
            $customPath = Read-Host "Enter the file or folder path for custom scan (e.g., C:\Users\YourUser\Documents)"
            if (Test-Path $customPath) {
                Write-Host "Starting Custom Scan on: $customPath..." -ForegroundColor Green
                Start-MpScan -ScanType CustomScan -ScanPath $customPath
                Write-Host "Custom Scan on '$customPath' finished." -ForegroundColor Green
            } else {
                Write-Host "Error: Path not found - '$customPath'. Please enter a valid path." -ForegroundColor Red
            }
        }
        "B" {
            Write-Host "Returning to Main Menu..."
            return # Exits the function, goes back to the main menu loop
        }
        default {
            Write-Host "Invalid scan type selected. Please choose a valid option." -ForegroundColor Yellow
        }
    }
    Read-Host "Press Enter to continue..."
}

# Function to update Windows Defender signatures
function Update-DefenderSignatures {
    Write-Host "Attempting to update Windows Defender signatures..."
    try {
        Update-MpSignature -ErrorAction Stop
        Write-Host "Windows Defender signatures updated successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "An error occurred during signature update:" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
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
    Write-Host "4. Start Windows Defender Scan"      # New
    Write-Host "5. Update Windows Defender Signatures" # New
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
        "4" {                                     # New
            Invoke-DefenderScan
        }
        "5" {                                     # New
            Update-DefenderSignatures
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
