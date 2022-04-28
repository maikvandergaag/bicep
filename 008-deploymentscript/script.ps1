param([string] $name)

$output = 'Hello {0}. The env value 1 is {1}, the env value 2  is {2}.' -f $name,${Env:envValue1},${Env:envValue2}

Write-Output $output

$DeploymentScriptOutputs = @{}
$DeploymentScriptOutputs['output1'] = $output