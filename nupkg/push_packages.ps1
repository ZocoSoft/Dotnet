#powershell -ExecutionPolicy ByPass -File push_packages.ps1
. ".\common.ps1"

$apiKey ="qngwrgs3rcdkaa7oyfokmhsddqah4kalcxvk3q5xoo4kjvcfsyga" # $args[0]

# Get the version
[xml]$commonPropsXml = Get-Content (Join-Path $rootFolder "common.props")
$version = $commonPropsXml.Project.PropertyGroup.Version

# Publish all packages
foreach($project in $projects) {
    $projectName = $project.Substring($project.LastIndexOf("/") + 1)
    & dotnet nuget push ($projectName + "." + $version + ".nupkg") -s "Dotnet" --api-key "$apiKey"
}

# Go back to the pack folder
Set-Location $packFolder
