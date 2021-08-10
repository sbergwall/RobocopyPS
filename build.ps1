# Installing depending modules for local development

[CmdletBinding()]

$Script:Modules = @(
    'InvokeBuild',
    'platyPS',
    'PSScriptAnalyzer',
    'BuildHelpers'
)

$Script:ModuleInstallScope = 'CurrentUser'

'Starting build...'

Get-PackageProvider -Name 'NuGet' -ForceBootstrap | Out-Null

foreach ($Module in $Script:Modules) {
    if (!(Get-Module $Module -ListAvailable)) {
        "Installing module dependencies: $Module"
        Install-Module -Name $Module -Scope $Script:ModuleInstallScope -Force
    }
}

if ((Get-Module pester -ListAvailable | Sort-Object version | Select-Object -Last 1).Version -lt 5.2){
    Install-Module 'Pester' -MinimumVersion 5.2 -Scope $Script:ModuleInstallScope -Force
}

'Setting Build Environment variables...'
Set-BuildEnvironment -Force
Get-ChildItem Env:BH*

