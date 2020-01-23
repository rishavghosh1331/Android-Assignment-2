Dim FileName, Description, TargetPath, IconLocation
Dim proc_arch, fileSys
	
DocDir = "C:\Program Files\HP\Documentation"
FileName = "index.html"
ShortCutName = "HP Documentation"
Description = "HP Documentation"
ShortCutPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP"
IconLocation = "C:\Program Files\HP\Documentation\elements\HP.ico"

Set oShell = WScript.CreateObject("WScript.Shell")
proc_arch = oShell.ExpandEnvironmentStrings("%PROCESSOR_ARCHITECTURE%")

TargetPath = DocDir & "\platform_guides\languages\" & FileName

Set fileSys=CreateObject("Scripting.FileSystemObject")
if Not fileSys.FolderExists(ShortCutPath) Then
    filesys.CreateFolder(ShortCutPath)
End if

Set shortcut = CreateObject("WScript.Shell").CreateShortcut(ShortCutPath & "\" + ShortCutName + ".lnk")
	shortcut.Description = Description
	shortcut.TargetPath = TargetPath
	shortcut.Arguments = "/Arguments:Shortcut"
	shortcut.IconLocation = IconLocation
	shortcut.Save
