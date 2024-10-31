Dim shell
Set shell = CreateObject("WScript.Shell")
shell.Run "powershell -WindowStyle Hidden -File ""blackout.ps1""", 0, False
Set shell = Nothing