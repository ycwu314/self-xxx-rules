$processNames = @(
    "MsMpEng.exe",
    "MpCmdRun.exe",
    "GoogleUpdate.exe",
    "MSOfficePLUSService.exe",
    "OfficeClickToRun.exe",
    "LenovoVantageService.exe"
)

foreach ($processName in $processNames) {
    $ruleName = "Block_for_process $processName"
    
    # 检查是否已存在相同名称的规则
    $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
    
    if ($existingRule -eq $null) {
        # 不存在相同名称的规则，创建新规则
        New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Program $processName -Action Block
        Write-Host "Created firewall rule for $processName"
    }
    else {
        # 已存在相同名称的规则，跳过创建
        Write-Host "Firewall rule for $processName already exists. Skipping..."
    }
}
