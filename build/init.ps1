$brewPackages = @(
    "pre-commit",
    "gawk",
    "terraform-docs",
    "tflint",
    "tfsec",
    "coreutils",
    "checkov",
    "terrascan",
    "golang",
    "docker"
)
function ReplaceAllStringsInFile($SearchString, $ReplaceString, $FullPathToFile) {
    $content = [System.IO.File]::ReadAllText("$FullPathToFile").Replace("$SearchString", "$ReplaceString")
    [System.IO.File]::WriteAllText("$FullPathToFile", $content)
}
function SetupPreCommit {
    Write-host "Configuring pre-commit..."
    $dir = Join-Path $env:HOME ".git-template"
    if (Test-Path "$dir") {
        Remove-item -Recurse -Force -Path "$dir" -Verbose
    }
    $globalHooks = Join-path $dir "hooks"
    $localHooks = "$PSScriptRoot/../.git/hooks"
    if (Test-Path "$localHooks") {
        Remove-item -Recurse -Force -Path "$localHooks" -Verbose
    }

    New-Item -ItemType Directory -Path $dir
    git config --global init.templateDir $dir
    git config --global core.hooksPath  $dir/hooks
    pre-commit init-templatedir -t pre-commit   $dir
    pre-commit init-templatedir -t prepare-commit-msg   $dir
    pre-commit init-templatedir -t commit-msg   $dir

    Copy-Item $globalHooks -Destination $localHooks -Recurse -Verbose
}
function InstallMacDependencies {
    foreach ($package in $brewPackages) {
        Write-Host "Going to check for package $package"
        brew install $package
    }
}
function FixReadme {
    $file = "$PSScriptRoot/../README.md"
    $path = Get-Item  "$PSScriptRoot/.."
    ReplaceAllStringsInFile -SearchString "TERRAFORM-MODULE-TEMPLATE" -ReplaceString $path.Name.ToUpper() -FullPathToFile $file
}

function PrintAdditionalNeededConfig {
    Write-Host "Please add following statements to your .bashrc or .zshrc"
    Write-host "
Optional:
    export GOPATH=`$HOME/dev/go-workspace
    export GOROOT=/usr/local/opt/go/libexec
    export PATH=`$PATH:`$GOPATH/bin
    export PATH=`$PATH:`$GOROOT/bin
Required:
    export TF_PLUGIN_CACHE_DIR=~/.terraform-cache
    export KICS_QUERIES_PATH=/usr/local/opt/kics/share/kics/assets/queries"
}

if ($IsWindows) {
    Write-Error "This script is currently not able to setup windows systems"
    exit 1
}
if ($IsLinux) {
    Write-Error "This script is currently not able to setup linux systems"
    exit 1
}
if ($IsMacOS) {
    InstallMacDependencies
    PrintAdditionalNeededConfig
}

SetupPreCommit
FixReadme
