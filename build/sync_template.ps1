$protectedFiles = @(
    "main.tf",
    "outputs.tf"
    "variables.tf"
)
$ChangedFiles = $(git status --porcelain | Measure-Object | Select-Object -expand Count)
if ($ChangedFiles -gt 0)
{
    Write-Error "Found $ChangedFiles changed files. Please commit or stash them before using this script."
    exit 0
}

$tempPath = Join-Path $([system.io.path]::GetTempPath()) "xoap-template"

if(Test-path "$tempPath"){
    Write-Host "Removing old temporary files for xoap module template"
    Remove-Item "$tempPath" -Recurse -Force -Verbose
}

git clone https://github.com/xoap-io/terraform-module-template.git $tempPath

$templateItems = Get-ChildItem $tempPath -File | Where-Object {$_.Name -notin $protectedFiles}

foreach($item in $templateItems){
    $targetPath = $item.FullName.Replace($tempPath, "${PSScriptRoot}/..")
    Copy-Item $item.FullName -Destination $targetPath -Force -Verbose
}
