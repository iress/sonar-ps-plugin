ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG POWERSHELL_VERSION=7.4.13
ARG PSSCRIPTANALYZER_VERSION=1.25.0

RUN set -eux; \
    yum install -y libicu; \
    yum clean all; \
    PS_ARCH=$([ "$(uname -m)" = "x86_64" ] && echo "x64" || echo "arm64"); \
    mkdir -p /opt/microsoft/powershell/7; \
    curl -fsSL "https://github.com/PowerShell/PowerShell/releases/download/v${POWERSHELL_VERSION}/powershell-${POWERSHELL_VERSION}-linux-${PS_ARCH}.tar.gz" \
        | tar -xz -C /opt/microsoft/powershell/7; \
    chmod +x /opt/microsoft/powershell/7/pwsh; \
    ln -sf /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh; \
    pwsh -NoLogo -NoProfile -Command \
        "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
        Install-Module -Name PSScriptAnalyzer -RequiredVersion ${PSSCRIPTANALYZER_VERSION} -Scope AllUsers -Force"