# Compiling Python 2.6.9 on Windows

The included Powershell scripts will compile Python 2.6.9 from source on Windows.

# Pre-requisites

1. Install Visual Studio 2008 Pro and install service packs. Be sure to select 64 bit compilers (if possible).
2. Install 7-Zip x64 to `C:\Programs Files\7-Zip\`

# Compiling

Use powershell to execute the following:

```posh
.\build-py26-win32.ps1
.\build-py26-amd64.ps1
```

This will compile everything into the `py26-win32/Python-2.6.9/PCbuild/` folder for x32 and
`py26-amd64/Python-2.6.9/PCbuild/amd64/` for x64.
