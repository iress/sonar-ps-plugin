# sonar-ps-plugin

Maintained fork of the [PowerShell language plugin for SonarQube](https://github.com/gretard/sonar-ps-plugin).

## Description ##
Currently plugin supports:

- Reporting of issues found by [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer)
- Cyclomatic and cognitive complexity metrics (since version 0.3.0)
- Reporting number of lines of code and comment lines metrics  (since version 0.3.2)


## Donating ##
You can support the original author of this [project and others](https://github.com/gretard) via [Paypal](https://www.paypal.me/greta514284/)

[![Support via PayPal](https://cdn.rawgit.com/twolfson/paypal-github-button/1.0.0/dist/button.svg)](https://www.paypal.me/greta514284/)

## Usage ##
1. Download and install SonarQube
2. Download plugin from the [releases](https://github.com/gretard/sonar-ps-plugin/releases) and copy it to sonarqube's extensions\plugins directory
3. Start SonarQube and enable rules
4. Prepare build agent machines:
  - **WINDOWS**:
    - Install [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) into your build machine where you plan to run sonar scanner, quick steps:
    - In powershell terminal run (more [info](https://learn.microsoft.com/en-us/powershell/utility-modules/psscriptanalyzer/overview?view=ps-modules#installing-psscriptanalyzer)): ```Install-Module -Name PSScriptAnalyzer -Force```
    - Verify if module got installed successfully in poweshell terminal run (more [info](https://learn.microsoft.com/en-us/powershell/utility-modules/psscriptanalyzer/using-scriptanalyzer?source=recommendations&view=ps-modules)): ```Invoke-ScriptAnalyzer -ScriptDefinition '"b" = "b"; function eliminate-file () { }'```
    - You can check [sample project](https://github.com/gretard/sonar-ps-plugin/tree/master/sampleProject) to test plugin and verify configuration
  - **LINUX**:
    - Install Powershell on Linux (for example Ubuntu https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.4)
    - Install PSScript analyzer (https://learn.microsoft.com/en-us/powershell/utility-modules/psscriptanalyzer/overview?view=ps-modules#installing-psscriptanalyzer), for example in the terminal execute to install it:
      ```pwsh -Command "Install-Module -Name PSScriptAnalyzer -Force"```
    - Test if module is working properly:
      ```pwsh -Command "Invoke-ScriptAnalyzer -ScriptDefinition '"b" = "b"; function eliminate-file () { }'"```
    - Once you executed previous steps, please specify "_sonar.ps.executable_" property to point to powershell executable on the linux (you can find it by using command ```whereis pwsh```): _sonar.ps.executable="/usr/bin/pwsh"_

## Configuration ##
Currently there is a possibility to override the following options either on server in the Administration tab or on the project configuration files:

- **sonar.ps.tokenizer.skip** - if set to true - skips tokenizer, which might be time consuming, defaults to *false*
- **sonar.ps.file.suffixes** - allows to specify which files should be detected as Powershell files, defaults to *.ps1,.psm1,.psd1*
- **sonar.ps.executable** - allows to specify powershell executable, defaults to *powershell.exe* (since version 0.3.0)
- **sonar.ps.plugin.skip** - if set to true - skips plugin in general, meaning that no sensors are run, defaults to *false* (since version 0.3.0)
- **sonar.ps.tokenizer.timeout** - maximum number of seconds to wait for tokenizer results,  defaults to *3600* (since version 0.4.0)
- **sonar.ps.external.rules.skip** - list of repo:ruleId comma separated pairs to skip reporting of issues found by rules (since version 0.5.0)

## Requirements ##
Different plugin versions support the following:

| Plugin Version | SonarQube Version | PSScriptAnalyzer Rules | Java | Notes |
|---|---|---|---|---|
| 0.6.0 | LTA 2026.1+ | 1.25+ | 21+ | Current |
| 0.5.4 | 8.9.2+ | 1.22+ | 17+ | Optimizations and fixes for SonarQube 10+ |
| 0.5.3 | 8.9.2+ | 1.20+ | 17+ |  |
| 0.5.1 | 8.9.2+ | 1.20+ | 11+ |  |
| 0.5.0 | 6.7.7+ | 1.18.1 | 8 |  |
| 0.3.0 | 6.3+ | 1.17.1 | 8 |  |
| 0.2.2 | 5.6+ | 1.17.1 | 8 |  |

## Development ##
Build and test using Docker Compose:
- Run tests: `docker compose run --rm test`
- Build package: `docker compose run --rm build`
- Use a custom Docker registry: `DEFAULT_DOCKER_REPO=your.registry.com/path docker compose run --rm test`

**Upgrading Java:** Update at least the base image tag in [docker-compose.yml](docker-compose.yml) and `jdk.min.version` in `pom.xml`.

**Upgrading PSScriptAnalyzer:** Run `regenerateRulesDefinition.ps1` to generate new rules, then update `PSSCRIPTANALYZER_VERSION` in the [Dockerfile](Dockerfile).

**Upgrading SonarQube API:** `sonar.apiVersion` is generally backwards compatible. Upgrade `sonar.apiVersion` when you need new API endpoints or when existing ones are deprecated/removed. Also upgrade `sonar.testingHarnessVersion` to match the same SonarQube release.

**Releasing:** Increment version in `pom.xml`, build with `docker compose run --rm build`, create a [GitHub release](https://github.com/iress/sonar-ps-plugin), and attach the `.jar` from `sonar-ps-plugin/target/`.



