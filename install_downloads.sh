#!/bin/bash
set -e

mkdir -p dls
cd dls

rm -f Statistics-Descriptive-3.0607.tar.gz
wget 'http://search.cpan.org/CPAN/authors/id/S/SH/SHLOMIF/Statistics-Descriptive-3.0607.tar.gz'

tar xzf Statistics-Descriptive-3.0607.tar.gz
cp -rf Statistics-Descriptive-3.0607/lib/Statistics /usr/local/pacbio/bin/
cp -rf Statistics-Descriptive-3.0607/lib/Statistics /usr/local/pacbio/lib/
