
param([Switch] $Verbose,
    [String] $TaskName = $null)

$ErrorActionPreference = "Stop"

function Get-TaskList(
    [Boolean] $Verbose,
    [String] $TaskName = $null) {

    $Query="schtasks.exe /Query /FO CSV "
    if ($Verbose) {
        $Query += " /V"
    }
    [Object[]] $taskList = (Invoke-Expression "& $Query" | ConvertFrom-Csv | ? { -not ($_.タスク名 -eq "タスク名") } )
    if ($TaskName) {
        $taskList = $taskList | ? { $_.タスク名 -cmatch [Regex]$TaskName }
    }

    $taskList
}

# タスク一覧表示
$taskList = Get-TaskList -Verbose $Verbose -TaskName $TaskName
$taskList | Out-GridView -Title "スケジュールタスク一覧" | Out-Null

