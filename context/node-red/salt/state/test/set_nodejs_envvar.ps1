$oldpath=[Environment]::GetEnvironmentVariable("Path");
$path="C:\Program Files\nodejs\";
$newpath="$oldpath;$path;"
[Environment]::SetEnvironmentVariable("Path", "$newpath", "Machine")
