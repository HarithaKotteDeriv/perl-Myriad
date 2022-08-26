#!/usr/bin/env bash

bash $(pwd)/ci/common/update_packages

perl -MConfig -le'print "$_=$Config{$_}" for sort keys %Config' > /opt/perl.config
export PERL5LIB=$(pwd)/deps/lib/perl5:$(pwd)/deps/lib/perl5/$(perl -MConfig -le'print $Config{archname}'):$PERL5LIB

bash $(pwd)/ci/common/update_cpan

export PATH=$(pwd)/deps/bin:$PATH
dzil run cover -test -report coveralls || :
