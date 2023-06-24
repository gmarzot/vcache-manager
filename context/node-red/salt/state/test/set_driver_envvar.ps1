$oldpath=[Environment]::GetEnvironmentVariable("Path");
$path="/atf/utilities/drivers/windows";
$newpath="$oldpath;$path;"
[Environment]::SetEnvironmentVariable("Path", "$newpath", "Machine")
