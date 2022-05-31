# ntpsync
NTP synchronization script

## ntpsync.bat
本バッチファイルを実行するとNTPサーバに対して強制的に時刻を同期させる。以下の条件下で使用することができる。

- バッチファイルがローカルパス上に配置されていること
  - UNC (Universal Naming Convention) パスなどに配置されていると動作しない
- NTPサーバが事前に設定されている
- 「設定」→「時刻を自動的に設定する」がON
- Win32Timeサービスが起動している
  - Win32Timeサービスが起動していない場合は強制的に起動する


# 参考文献
- [Windows 時刻同期コマンド　バッチファイル](https://amksystem.com/cmd/time-sync/)
- [Windows 10の時刻同期設定](https://gato.intaa.net/archives/12107)
- [WindowsのNTP設定の勘所](https://qiita.com/tatsubey/items/70fe898bfa00986d5305)
