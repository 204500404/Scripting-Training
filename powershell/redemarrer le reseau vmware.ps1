# Redemarrage des services reseau VMware
Write-Host "=== redemarrage des services reseau vmware ===" -ForegroundColor Cyan

# Liste des services reseau lies a VMware
$vmwareServices = @(
    "wmware nat Service",
    "wmware dhcp Service",
    "wmware workstation server"
)

foreach ($service in $vmwareServices) {
    Write-Host "arret du service : $service" -ForegroundColor Yellow
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2

    Write-Host "demarrage du service : $service" -ForegroundColor Green
    Start-Service -Name $service -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 1
}

Write-Host "redemarrage termine." -ForegroundColor Cyan

