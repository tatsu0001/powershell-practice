
param([String] $TaskName = $null,
      [Switch] $GridView,
      [String] $Csv = $null)

$ErrorActionPreference = "Stop"

function Get-TaskList(
    [String] $TaskName = $null) {

    $query="schtasks.exe /Query /FO CSV /V "
    [Object[]] $taskList = (Invoke-Expression "& $query" | ConvertFrom-Csv | ? { -not ($_.タスク名 -eq "タスク名") } )
    if ($TaskName) {
        $taskList = $taskList | ? { $_.タスク名 -cmatch [Regex]$TaskName }
    }

    return $taskList
}

# タスク一覧
$taskList = Get-TaskList -TaskName $TaskName

# ファイル出力
if ($Csv) {
    if (Test-Path -Path $Csv -PathType Leaf) {
        Write-Host "ERROR: $Csv が既に存在します。"
    }

    $taskList | Export-Csv -Path $Csv -Encoding OEM -NoTypeInformation > $null
}

# グリッド表示
if ($GridView) {
    $taskList | Out-GridView -Title "スケジュールタスク一覧" 
    # GridViewが閉じるのを待つ
    while([System.Diagnostics.Process]::GetCurrentProcess().MainWindowHandle -ne 0){
        start-sleep 2
    }
}

