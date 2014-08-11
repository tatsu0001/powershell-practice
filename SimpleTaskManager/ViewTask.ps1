
param([String] $TaskName = $null,
      [Switch] $GridView,
      [String] $Csv = $null)

$ErrorActionPreference = "Stop"

function Get-TaskList(
    [String] $TaskName = $null) {

    $query="schtasks.exe /Query /FO CSV /V "
    [Object[]] $taskList = (Invoke-Expression "& $query" | ConvertFrom-Csv | ? { -not ($_.�^�X�N�� -eq "�^�X�N��") } )
    if ($TaskName) {
        $taskList = $taskList | ? { $_.�^�X�N�� -cmatch [Regex]$TaskName }
    }

    return $taskList
}

# �^�X�N�ꗗ
$taskList = Get-TaskList -TaskName $TaskName

# �t�@�C���o��
if ($Csv) {
    if (Test-Path -Path $Csv -PathType Leaf) {
        Write-Host "ERROR: $Csv �����ɑ��݂��܂��B"
    }

    $taskList | Export-Csv -Path $Csv -Encoding OEM -NoTypeInformation > $null
}

# �O���b�h�\��
if ($GridView) {
    $taskList | Out-GridView -Title "�X�P�W���[���^�X�N�ꗗ" 
    # GridView������̂�҂�
    while([System.Diagnostics.Process]::GetCurrentProcess().MainWindowHandle -ne 0){
        start-sleep 2
    }
}

