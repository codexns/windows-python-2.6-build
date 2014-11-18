$ErrorActionPreference = "Stop"

$opensslVersion = '1.0.1j'
$pythonVersion = '2.6.9'

$winDir = split-path -parent $MyInvocation.MyCommand.Path
$buildDir = join-path $winDir .\py26-amd64
$depsDir = join-path $winDir .\deps
$stagingDir = join-path $buildDir .\staging
$tmpDir = join-path $buildDir .\tmp

# From http://stackoverflow.com/questions/4384814/how-to-call-batch-script-from-powershell/4385011#4385011
&$winDir\invoke-environment '"C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\bin\amd64\vcvarsamd64.bat"'

if (!(test-path $buildDir)) {
    new-item $buildDir -itemtype directory
}

if (!(test-path $depsDir)) {
    new-item $depsDir -itemtype directory
}

if (!(test-path $stagingDir)) {
    new-item $stagingDir -itemtype directory
}

cd $depsDir


$webclient = new-object System.Net.WebClient


if (!(test-path .\strawberry-perl-5.18.2.1-32bit-portable.zip)) {
    $webclient.DownloadFile("http://strawberryperl.com/download/5.18.2.1/strawberry-perl-5.18.2.1-32bit-portable.zip", "$depsDir\strawberry-perl-5.18.2.1-32bit-portable.zip")
}
if (!(test-path .\perl)) {
    new-item .\perl -itemtype directory
    cd .\perl\
    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y ..\strawberry-perl-5.18.2.1-32bit-portable.zip
    cd ..
}
$env:PATH="$depsDir\perl\perl\site\bin;$depsDir\perl\perl\bin;$depsDir\perl\c\bin;${env:PATH}"
$env:TERM="dumb"


if (!(test-path .\bzip2-1.0.6.tar.gz)) {
    $webclient.DownloadFile("http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz", "$depsDir\bzip2-1.0.6.tar.gz")
}
if (!(test-path .\bzip2-1.0.6)) {
    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\bzip2-1.0.6.tar.gz
    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\bzip2-1.0.6.tar
    remove-item .\bzip2-1.0.6.tar
}
if (test-path $buildDir\bzip2-1.0.6) {
    # Try twice to prevent locking issues
    try {
        remove-item -recurse -force $buildDir\bzip2-1.0.6
    } catch {
        remove-item -recurse -force $buildDir\bzip2-1.0.6
    }
}
copy-item -recurse .\bzip2-1.0.6 $buildDir\


if (!(test-path .\db-4.7.25.zip)) {
    $webclient.DownloadFile("http://download.oracle.com/berkeley-db/db-4.7.25.zip", "$depsDir\db-4.7.25.zip")
}
if (!(test-path .\db-4.7.25.0)) {
    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\db-4.7.25.zip
    rename-item .\db-4.7.25 .\db-4.7.25.0
}
if (test-path $buildDir\db-4.7.25.0) {
    # Try twice to prevent locking issues
    try {
        remove-item -recurse -force $buildDir\db-4.7.25.0
    } catch {
        remove-item -recurse -force $buildDir\db-4.7.25.0
    }
}
copy-item -recurse .\db-4.7.25.0 $buildDir\


if (!(test-path .\tcl8517-src.zip)) {
    $webclient.DownloadFile("http://downloads.sourceforge.net/project/tcl/Tcl/8.5.17/tcl8517-src.zip?r=http%3A%2F%2Fwww.tcl.tk%2Fsoftware%2Ftcltk%2Fdownload.html&ts=1416343508&use_mirror=hivelocity", "$depsDir\tcl8517-src.zip")
}
if (!(test-path .\tcl8.5.17)) {
    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\tcl8517-src.zip
}
if (test-path $buildDir\tcl8.5.17) {
    # Try twice to prevent locking issues
    try {
        remove-item -recurse -force $buildDir\tcl8.5.17
    } catch {
        remove-item -recurse -force $buildDir\tcl8.5.17
    }
}
copy-item -recurse .\tcl8.5.17 $buildDir\


if (!(test-path .\tk8517-src.zip)) {
    $webclient.DownloadFile("http://downloads.sourceforge.net/project/tcl/Tcl/8.5.17/tk8517-src.zip?r=http%3A%2F%2Fwww.tcl.tk%2Fsoftware%2Ftcltk%2Fdownload.html&ts=1416343594&use_mirror=tcpdiag", "$depsDir\tk8517-src.zip")
}
if (!(test-path .\tk8.5.17)) {
    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\tk8517-src.zip
}
if (test-path $buildDir\tk8.5.17) {
    # Try twice to prevent locking issues
    try {
        remove-item -recurse -force $buildDir\tk8.5.17
    } catch {
        remove-item -recurse -force $buildDir\tk8.5.17
    }
}
copy-item -recurse .\tk8.5.17 $buildDir\


if (test-path $buildDir\tcltk) {
    # Try twice to prevent locking issues
    try {
        remove-item -recurse -force $buildDir\tcltk
    } catch {
        remove-item -recurse -force $buildDir\tcltk
    }
}
new-item $buildDir\tcltk64 -itemtype directory


if (!(test-path .\sqlite-amalgamation-3080200.zip)) {
    $webclient.DownloadFile("http://www.sqlite.org/2013/sqlite-amalgamation-3080200.zip", "$depsDir\sqlite-amalgamation-3080200.zip")
}
if (!(test-path .\sqlite-3.8.2)) {
    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\sqlite-amalgamation-3080200.zip
    rename-item .\sqlite-amalgamation-3080200 .\sqlite-3.8.2
}
if (test-path $buildDir\sqlite-3.8.2) {
    # Try twice to prevent locking issues
    try {
        remove-item -recurse -force $buildDir\sqlite-3.8.2
    } catch {
        remove-item -recurse -force $buildDir\sqlite-3.8.2
    }
}
copy-item -recurse .\sqlite-3.8.2 $buildDir\


if (!(test-path .\openssl-$opensslVersion)) {
    if (!(test-path .\openssl-$opensslVersion.tar.gz)) {
        $webclient.DownloadFile("http://www.openssl.org/source/openssl-$opensslVersion.tar.gz", "$depsDir\openssl-$opensslVersion.tar.gz")
    }

    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\openssl-$opensslVersion.tar.gz
    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\openssl-$opensslVersion.tar
    remove-item .\openssl-$opensslVersion.tar
}

if (test-path $buildDir\openssl-$opensslVersion) {
    # Try twice to prevent locking issues
    try {
        remove-item -recurse -force $buildDir\openssl-$opensslVersion
    } catch {
        remove-item -recurse -force $buildDir\openssl-$opensslVersion
    }
}
copy-item -recurse .\openssl-$opensslVersion $buildDir\


if (!(test-path .\Python-$pythonVersion)) {
    if (!(test-path .\Python-$pythonVersion.tgz)) {
        $webclient.DownloadFile("https://www.python.org/ftp/python/$pythonVersion/Python-$pythonVersion.tgz", "$depsDir\Python-$pythonVersion.tgz")
    }

    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\Python-$pythonVersion.tgz
    &"${env:ProgramFiles}\7-Zip\7z.exe" x -y .\Python-$pythonVersion.tar
    remove-item .\Python-$pythonVersion.tar
}

if (test-path $buildDir\Python-$pythonVersion) {
    # Try twice to prevent locking issues
    try {
        remove-item -recurse -force $buildDir\Python-$pythonVersion
    } catch {
        remove-item -recurse -force $buildDir\Python-$pythonVersion
    }
}
copy-item -recurse .\Python-$pythonVersion $buildDir\


cd $buildDir\openssl-$opensslVersion\
perl Configure VC-WIN64A shared enable-static-engine no-md2 no-rc5 no-ssl2 --prefix=$stagingDir
.\ms\do_win64a.bat
nmake.exe -f .\ms\nt.mak
copy-item .\tmp32\buildinf.h .\crypto\buildinf_amd64.h
copy-item .\inc32\openssl\opensslconf.h .\crypto\opensslconf_amd64.h


cd $buildDir\tcl8.5.17\win
nmake -f makefile.vc COMPILERFLAGS=-DWINVER=0x0500 MACHINE=AMD64 INSTALLDIR=$buildDir\tcltk64 clean nmakehlp.exe all
nmake -f makefile.vc MACHINE=AMD64 INSTALLDIR=$buildDir\tcltk64 install

cd $buildDir\tk8.5.17\win
nmake -f makefile.vc COMPILERFLAGS=-DWINVER=0x0500 OPTS=noxp MACHINE=AMD64 INSTALLDIR=$buildDir\tcltk64 TCLDIR=$buildDir\tcl8.5.17 clean
nmake -f makefile.vc COMPILERFLAGS=-DWINVER=0x0500 OPTS=noxp MACHINE=AMD64 INSTALLDIR=$buildDir\tcltk64 TCLDIR=$buildDir\tcl8.5.17 all
nmake -f makefile.vc COMPILERFLAGS=-DWINVER=0x0500 OPTS=noxp MACHINE=AMD64 INSTALLDIR=$buildDir\tcltk64 TCLDIR=$buildDir\tcl8.5.17 install


cd $buildDir\Python-$pythonVersion\
cd PCbuild

(get-content $winDir\pyproject.vsprops.diff) | &$winDir\gnupach.exe -p1
# Use the python we just compiled - this requires we compile on a x64 machine
$env:HOST_PYTHON=".\amd64\python.exe"

msbuild /p:useenv=true .\pcbuild.sln /t:build /p:Configuration=Release /p:Platform=x64
