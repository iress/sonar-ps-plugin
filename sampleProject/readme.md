# Sample PowerShell Project For sonar-ps-plugin

This folder is a small PowerShell project used to validate that the sonar-ps plugin is installed and working in SonarQube.

It includes:
- Realistic sample scripts in src/
- A script with intentional quality issues in src/intentional-issues.ps1

Some sample scripts are adapted from:
https://adamtheautomator.com/powershell-script-examples/

## Prerequisites

1. SonarQube is running and reachable.
2. The sonar-ps-plugin jar is copied into SonarQube extensions/plugins and SonarQube has been restarted.
3. You have a valid Sonar token.
4. sonar-scanner and pwsh must be installed on your machine.
5. A project with projectKey `examples.ps.project` exists in SonarQube.

## Run A Scan

From this folder (sampleProject), run something like:

sonar-scanner \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.token=<your_token> \
  -Dsonar.ps.executable=/usr/local/bin/pwsh

Replace `<your_token>` with your actual Sonar token.

## What To Validate

1. PowerShell files are detected under src/.
2. Issues are raised from PSScriptAnalyzer rules.
3. The intentional-issues.ps1 file reports multiple findings.
4. Measures appear (for example line counts and complexity).
5. CPD/tokens are generated when tokenizer is enabled.

## Intentional Issue File

The file src/intentional-issues.ps1 intentionally contains patterns that should trigger common rules, such as:
- Cmdlet aliases
- Write-Host usage
- Non-approved verb in function name
- Plain-text secure string creation
