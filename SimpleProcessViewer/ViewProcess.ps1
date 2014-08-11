
param([String] $CommandPattern = $null,
      [Switch] $GridView,
      [String] $Csv = $null)

$ErrorActionPreference = "Stop"

function Get-ProcessList(
    [String] $CommandPattern = $null) {

    # 出力対象は
    # - プロセス名
    # - 親プロセスID
    # - プロセスID
    # - 実行開始日時
    # - コマンドライン
    # - 概要
    # のみ
    [Object[]] $procList = Get-WmiObject win32_process | `
        Select-Object -Property Name, ParentProcessId, ProcessId, CreationDate, CommandLine, Description | `
        Sort-Object -Property ParentProcessId, ProcessId
    if ($Pattern) {
        $procList = $procList | ? { $_.CommandLine -match [Regex]$CommandPattern }
    }

    return $procList
}

# タスク一覧
$procList = Get-ProcessList -CommandPattern $CommandPattern
$output = $false

# ファイル出力
if ($Csv) {
    if (Test-Path -Path $Csv -PathType Leaf) {
        Write-Host "ERROR: $Csv が既に存在します。"
    }

    $procList | Export-Csv -Path $Csv -Encoding OEM -NoTypeInformation > $null
    $output = $true
}

# グリッド表示
if ($GridView) {
    $procList | Out-GridView -Title "プロセス一覧" 
    # GridViewが閉じるのを待つ
    while([System.Diagnostics.Process]::GetCurrentProcess().MainWindowHandle -ne 0){
        start-sleep 2
    }
    $output = $true
}

# 標準出力
if (-not $output) {
    $procList | ConvertTo-Csv -Delimiter ',' -NoTypeInformation | Write-Host
}

