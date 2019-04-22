# Installing depending modules for local development

[CmdletBinding()]

$Script:Modules = @(
    'InvokeBuild',
    'Pester',
    'platyPS',
    'PSScriptAnalyzer',
    'BuildHelpers'
)

$Script:ModuleInstallScope = 'CurrentUser'

'Starting build...'
'Installing module dependencies...'

Get-PackageProvider -Name 'NuGet' -ForceBootstrap | Out-Null

Install-Module -Name $Script:Modules -Scope $Script:ModuleInstallScope -Force

Set-BuildEnvironment
Get-ChildItem Env:BH*