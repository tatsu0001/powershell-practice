param(
    # タスク名
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $TaskName,

    # 実行コマンド
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $RunCommand,

    # 実行ユーザ(デフォルト:自ユーザ)
    [String] $RunUser = $Env:USERNAME,

    # パスワード
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $RunUserPassword,

    # 実行間隔(デフォルト:毎週)
    # 有効なスケジュールの種類は MINUTE、HOURLY、DAILY、 WEEKLY、MONTHLY、
    # ONCE、ONSTART、ONLOGON、ONIDLE、 WEEKLY、MONTHLY、ONCE、ONSTART、ONLOGON、ONIDLE
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $ScheduleIntervalType = "WEEKLY",

    # 実行日/曜日(デフォルト:1日)
    # MON、TUE、WED、THU、FRI、SAT および SUN,
    # 毎月の指定 (MONTHLY) の場合は、日を 1 から 31,
    # ワイルドカード "*" を使うとすべての日
    [String] $ScheduleDay = $null,

    # 実行月(デフォルト:既定の日は月の最初の日)
    # 有効な値は、JAN、FEB、MAR、APR、MAY、JUN、JUL、
    # AUG、SEP、OCT、NOV および DEC です。ワイルド カード"*" を使うとすべての月
    [String] $ScheduleMonth = $null,

    # アイドル時間(分)
    # 待機後にスケジュールされた ONIDLE のタスクが実行される
    # 有効な範囲は、1 から 999 
    [String] $IdleMinutes = $null,

    # 開始時刻
    # HH:mm の形式 (24 時間形式)
    # 指定されていない場合の既定値は現在の時刻
    # このオプションは -ScheduleIntervalType ONCE と併用する必要がある
    [String] $StartTime = $null,

    # タスクの実行を終了する時刻を指定します。時刻の形式は
    #HH:mm (24 時間形式) です。たとえば、午後 2 時 50 分
    #の場合は 14:50 と指定します。次のスケジュールの種類には
    #適用できません: ONSTART、ONLOGON、ONIDLE、ONEVENT。
    [String] $EndTime = $null,

    # 繰り返し間隔
    # 次のスケジュールの種類には適用できません: MINUTE
    # HOURLY、ONSTART、ONLOGON、ONIDLE、ONEVENT。
    # 有効な範囲: 1 - 599940 分
    # -EndTime または -Duration が指定された場合、規定は10分
    [String] $RunIntervalMinutes = $null,

    # 継続時間
    # HH:mm の形式
    # これは -EndTime と共には適用されない
    # また、次のスケジュールの種類には適用されない
    # ONSTART、ONLOGON、ONIDLE、ONEVENT。
    [String] $Duration = $null,

    # 終了時刻または継続時間にタスクを終了
    # 次のスケジュールの種類には適用されない
    # ONSTART、ONLOGON、ONIDLE、ONEVENT
    # -EndTime または -Duration の指定が必要
    [Switch] $Kill,

    #タスクを実行する最初の日を指定します。 形式は
    #yyyy/mm/dd です。既定値は現在の日付です。
    #これは次のスケジュールの種類には適用されません: ONCE、
    #ONSTART、ONLOGON、ONIDLE、ONEVENT。
    [String] $StartDay = $null,

    #タスクを実行する最後の日を指定してください。形式は
    #yyyy/mm/dd です。これは次のスケジュールの種類には適用
    #されません: ONCE、ONSTART、ONLOGON、ONIDLE、ONEVENT。
    [String] $EndDay = $null,

    # OnEvent トリガーに対するイベントのチャネル指定
    [String] $EventChannel = $null,

    # ジョブの実行時に -RunUser ユーザーが現在ログオンしている
    # 場合にのみ、タスクが対話的に実行されるようにします。
    # このタスクは、ユーザーがログインしている場合にのみ実行
    # します。
    [Switch] $Interactive,

    # パスワードは保存されません。タスクは特定のユーザー
    # として非対話的に実行されます。
    # ローカル リソースしか使用できません。
    [Switch] $NoPassword, 

    # 最後の実行後で削除するタスクをマークします
    [Switch] $ZFlag,

    # 指定したタスクが既に存在する場合、タスクを強制的に作成し、警告を抑制します。
    [Switch] $Force,

    # 実行レベル
    # ジョブの実行レベルを設定します。有効な値は
    # LIMITED と HIGHEST です。既定値は LIMITED です。
    [String] $RunLevel = $null,

    # トリガーの開始後から、タスクが実行するまでの待機
    # 時間を指定します。時間の形式は mmmm:ss です。
    # このオプションは ONSTART、ONLOGON、ONEVENT の
    # 種類のスケジュールにのみ有効です。
    [String] $Delay = $null,

    #診断能力を向上させるために、プロセス終了コードは
    #HRESULT 形式になります。
    [Switch] $HResult,

    # 設定対象システム名(マシン名)
    # デフォルトはローカル
    [String] $System = $null,

    # SchTask.exeが実行されるユーザコンテキスト
    [String] $User = $null,

    # $User のパスワード
    # 与えられたユーザーのコンテキストのパスワードを指定し
    # ます。省略すると入力が促されます。
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

