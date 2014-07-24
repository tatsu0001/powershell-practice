param(
    # �^�X�N��
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $TaskName,

    # ���s�R�}���h
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $RunCommand,

    # ���s���[�U(�f�t�H���g:�����[�U)
    [String] $RunUser = $Env:USERNAME,

    # �p�X���[�h
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $RunUserPassword,

    # ���s�Ԋu(�f�t�H���g:���T)
    # �L���ȃX�P�W���[���̎�ނ� MINUTE�AHOURLY�ADAILY�A WEEKLY�AMONTHLY�A
    # ONCE�AONSTART�AONLOGON�AONIDLE�A WEEKLY�AMONTHLY�AONCE�AONSTART�AONLOGON�AONIDLE
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $ScheduleIntervalType = "WEEKLY",

    # ���s��/�j��(�f�t�H���g:1��)
    # MON�ATUE�AWED�ATHU�AFRI�ASAT ����� SUN,
    # �����̎w�� (MONTHLY) �̏ꍇ�́A���� 1 ���� 31,
    # ���C���h�J�[�h "*" ���g���Ƃ��ׂĂ̓�
    [String] $ScheduleDay = $null,

    # ���s��(�f�t�H���g:����̓��͌��̍ŏ��̓�)
    # �L���Ȓl�́AJAN�AFEB�AMAR�AAPR�AMAY�AJUN�AJUL�A
    # AUG�ASEP�AOCT�ANOV ����� DEC �ł��B���C���h �J�[�h"*" ���g���Ƃ��ׂĂ̌�
    [String] $ScheduleMonth = $null,

    # �A�C�h������(��)
    # �ҋ@��ɃX�P�W���[�����ꂽ ONIDLE �̃^�X�N�����s�����
    # �L���Ȕ͈͂́A1 ���� 999 
    [String] $IdleMinutes = $null,

    # �J�n����
    # HH:mm �̌`�� (24 ���Ԍ`��)
    # �w�肳��Ă��Ȃ��ꍇ�̊���l�͌��݂̎���
    # ���̃I�v�V������ -ScheduleIntervalType ONCE �ƕ��p����K�v������
    [String] $StartTime = $null,

    # �^�X�N�̎��s���I�����鎞�����w�肵�܂��B�����̌`����
    #HH:mm (24 ���Ԍ`��) �ł��B���Ƃ��΁A�ߌ� 2 �� 50 ��
    #�̏ꍇ�� 14:50 �Ǝw�肵�܂��B���̃X�P�W���[���̎�ނɂ�
    #�K�p�ł��܂���: ONSTART�AONLOGON�AONIDLE�AONEVENT�B
    [String] $EndTime = $null,

    # �J��Ԃ��Ԋu
    # ���̃X�P�W���[���̎�ނɂ͓K�p�ł��܂���: MINUTE
    # HOURLY�AONSTART�AONLOGON�AONIDLE�AONEVENT�B
    # �L���Ȕ͈�: 1 - 599940 ��
    # -EndTime �܂��� -Duration ���w�肳�ꂽ�ꍇ�A�K���10��
    [String] $RunIntervalMinutes = $null,

    # �p������
    # HH:mm �̌`��
    # ����� -EndTime �Ƌ��ɂ͓K�p����Ȃ�
    # �܂��A���̃X�P�W���[���̎�ނɂ͓K�p����Ȃ�
    # ONSTART�AONLOGON�AONIDLE�AONEVENT�B
    [String] $Duration = $null,

    # �I�������܂��͌p�����ԂɃ^�X�N���I��
    # ���̃X�P�W���[���̎�ނɂ͓K�p����Ȃ�
    # ONSTART�AONLOGON�AONIDLE�AONEVENT
    # -EndTime �܂��� -Duration �̎w�肪�K�v
    [Switch] $Kill,

    #�^�X�N�����s����ŏ��̓����w�肵�܂��B �`����
    #yyyy/mm/dd �ł��B����l�͌��݂̓��t�ł��B
    #����͎��̃X�P�W���[���̎�ނɂ͓K�p����܂���: ONCE�A
    #ONSTART�AONLOGON�AONIDLE�AONEVENT�B
    [String] $StartDay = $null,

    #�^�X�N�����s����Ō�̓����w�肵�Ă��������B�`����
    #yyyy/mm/dd �ł��B����͎��̃X�P�W���[���̎�ނɂ͓K�p
    #����܂���: ONCE�AONSTART�AONLOGON�AONIDLE�AONEVENT�B
    [String] $EndDay = $null,

    # OnEvent �g���K�[�ɑ΂���C�x���g�̃`���l���w��
    [String] $EventChannel = $null,

    # �W���u�̎��s���� -RunUser ���[�U�[�����݃��O�I�����Ă���
    # �ꍇ�ɂ̂݁A�^�X�N���Θb�I�Ɏ��s�����悤�ɂ��܂��B
    # ���̃^�X�N�́A���[�U�[�����O�C�����Ă���ꍇ�ɂ̂ݎ��s
    # ���܂��B
    [Switch] $Interactive,

    # �p�X���[�h�͕ۑ�����܂���B�^�X�N�͓���̃��[�U�[
    # �Ƃ��Ĕ�Θb�I�Ɏ��s����܂��B
    # ���[�J�� ���\�[�X�����g�p�ł��܂���B
    [Switch] $NoPassword, 

    # �Ō�̎��s��ō폜����^�X�N���}�[�N���܂�
    [Switch] $ZFlag,

    # �w�肵���^�X�N�����ɑ��݂���ꍇ�A�^�X�N�������I�ɍ쐬���A�x����}�����܂��B
    [Switch] $Force,

    # ���s���x��
    # �W���u�̎��s���x����ݒ肵�܂��B�L���Ȓl��
    # LIMITED �� HIGHEST �ł��B����l�� LIMITED �ł��B
    [String] $RunLevel = $null,

    # �g���K�[�̊J�n�ォ��A�^�X�N�����s����܂ł̑ҋ@
    # ���Ԃ��w�肵�܂��B���Ԃ̌`���� mmmm:ss �ł��B
    # ���̃I�v�V������ ONSTART�AONLOGON�AONEVENT ��
    # ��ނ̃X�P�W���[���ɂ̂ݗL���ł��B
    [String] $Delay = $null,

    #�f�f�\�͂����コ���邽�߂ɁA�v���Z�X�I���R�[�h��
    #HRESULT �`���ɂȂ�܂��B
    [Switch] $HResult,

    # �ݒ�ΏۃV�X�e����(�}�V����)
    # �f�t�H���g�̓��[�J��
    [String] $System = $null,

    # SchTask.exe�����s����郆�[�U�R���e�L�X�g
    [String] $User = $null,

    # $User �̃p�X���[�h
    # �^����ꂽ���[�U�[�̃R���e�L�X�g�̃p�X���[�h���w�肵
    # �܂��B�ȗ�����Ɠ��͂�������܂��B
    [String] $Password = $null
    )

$ErrorActionPreference = "Stop"

$Query = "schtasks.exe /create /TN $TaskName /TR $RunCommand /RU $RunUser /RP $RunUserPassword /SC $ScheduleIntervalType"
if ($ScheduleDay) {
    $Query += " /D $ScheduleDay"
}
if ($ScheduleMonth) {
    $Query += " /M $ScheduleMonth"
}
if ($IdleMinutes) {
    $Query += " /I $IdleMinutes"
}
if ($StartTime) {
    $Query += " /ST $StartTime"
}
if ($EndTime) {
    $Query += " /ET $EndTime"
}
if ($RunIntervalMinutes) {
    $Query += " /RI $RunIntervalMinutes"
}
if ($Duration) {
    $Query += " /DU $Duration"
}
if ($Kill) {
    $Query += " /K"
}
if ($StartDay) {
    $Query += " /SD $StartDay"
}
if ($EndDay) {
    $Query += " /ED $EndDay"
}
if ($EventChannel) {
    $Query += " /EC $EventChannel"
}
if ($Interactive) {
    $Query += " /IT"
}
if ($NoPassword) {
    $Query += " /NP"
}
if ($ZFla) {
    $Query += " /Z"
}
if ($Force) {
    $Query += " /F"
}
if ($RunLevel) {
    $Query += " /RL $RunLevel"
}
if ($Delay) {
    $Query += " /DELAY $Delay"
}
if ($HResult) {
    $Query += " /HRESULT"
}
if ($System) {
    $Query += " /S $System"
}
if ($User) {
    $Query += " /U $User"
}
if ($Password ) {
    $Query += " /P $Password"
}

Invoke-Expression "& $Query"

