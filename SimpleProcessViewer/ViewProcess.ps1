
param([String] $CommandPattern = $null,
      [Switch] $GridView,
      [String] $Csv = $null)

$ErrorActionPreference = "Stop"

function Get-ProcessList(
    [String] $CommandPattern = $null) {

    # �o�͑Ώۂ�
    # - �v���Z�X��
    # - �e�v���Z�XID
    # - �v���Z�XID
    # - ���s�J�n����
    # - �R�}���h���C��
    # - �T�v
    # �̂�
    [Object[]] $procList = Get-WmiObject win32_process | `
        Select-Object -Property Name, ParentProcessId, ProcessId, CreationDate, CommandLine, Description | `
        Sort-Object -Property ParentProcessId, ProcessId
    if ($Pattern) {
        $procList = $procList | ? { $_.CommandLine -match [Regex]$CommandPattern }
    }

    return $procList
}

# �^�X�N�ꗗ
$procList = Get-ProcessList -CommandPattern $CommandPattern
$output = $false

# �t�@�C���o��
if ($Csv) {
    if (Test-Path -Path $Csv -PathType Leaf) {
        Write-Host "ERROR: $Csv �����ɑ��݂��܂��B"
    }

    $procList | Export-Csv -Path $Csv -Encoding OEM -NoTypeInformation > $null
    $output = $true
}

# �O���b�h�\��
if ($GridView) {
    $procList | Out-GridView -Title "�v���Z�X�ꗗ" 
    # GridView������̂�҂�
    while([System.Diagnostics.Process]::GetCurrentProcess().MainWindowHandle -ne 0){
        start-sleep 2
    }
    $output = $true
}

# �W���o��
if (-not $output) {
    $procList | ConvertTo-Csv -Delimiter ',' -NoTypeInformation | Write-Host
}

