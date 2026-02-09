FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install Python and Jupyter
RUN apt-get update \
    && apt-get install -y --no-install-recommends python3-pip \
    && pip3 install --no-cache-dir jupyterlab notebook \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch to vscode user for Julia installation
USER vscode

# Install juliaup (Julia version manager)
RUN curl -fsSL https://install.julialang.org | sh -s -- --yes

# Make juliaup available in PATH
ENV PATH="/home/vscode/.juliaup/bin:${PATH}"

# Install and set Julia 1.12 as default
RUN juliaup add 1.12 && juliaup default 1.12

# Install required Julia packages and precompile
RUN julia -e '\
    using Pkg; \
    Pkg.add([ \
        "IJulia", \
        "Distributions", \
        "Plots", \
        "Optim", \
        "NLSolversBase", \
        "Roots", \
        "DelimitedFiles", \
        "Statistics" \
    ]); \
    Pkg.precompile()'

USER root
