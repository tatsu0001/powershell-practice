
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
    [Object[]] $taskList = (Invoke-Expression "& $Query" | ConvertFrom-Csv | ? { -not ($_.�^�X�N�� -eq "�^�X�N��") } )
    if ($TaskName) {
        $taskList = $taskList | ? { $_.�^�X�N�� -cmatch [Regex]$TaskName }
    }

    $taskList
}

# �^�X�N�ꗗ�\��
$taskList = Get-TaskList -Verbose $Verbose -TaskName $TaskName
$taskList | Out-GridView -Title "�X�P�W���[���^�X�N�ꗗ" | Out-Null

