# Load necessary assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Get all screens connected
$screens = [System.Windows.Forms.Screen]::AllScreens

# Get the current mouse position
$mousePosition = [System.Windows.Forms.Control]::MousePosition

# Determine which screen the mouse is on
$currentScreen = $null
foreach ($screen in $screens) {
    if ($screen.Bounds.Contains($mousePosition)) {
        $currentScreen = $screen
        break
    }
}

# Check if the mouse is on a screen
if ($currentScreen -ne $null) {
    # Create forms to cover all other screens
    foreach ($screen in $screens) {
        if ($screen -ne $currentScreen) {
            $form = New-Object System.Windows.Forms.Form
            $form.FormBorderStyle = 'None'
            $form.TopMost = $true
            $form.BackColor = [System.Drawing.Color]::Black
            $form.Width = $screen.Bounds.Width
            $form.Height = $screen.Bounds.Height
            $form.StartPosition = 'Manual'
            $form.Location = $screen.Bounds.Location

            # Add mouse event handler to close on double-click
            $form.Add_MouseDoubleClick({
                $form.Close()
            })

            # Show the blacked-out form
            $form.Show()
        }
    }

    # Keep the script running until all blackout forms are closed
    while ([System.Windows.Forms.Application]::OpenForms.Count -gt 0) {
        [System.Windows.Forms.Application]::DoEvents()
    }
} else {
    Write-Host "Mouse not located on any screen."
}
