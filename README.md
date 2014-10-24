# Celera Workflow

This is our attempt at a workflow for using the Celera Assembler on our dataset
of PacBio and Illumina reads.

The repository contains some scripts for running Celera Assembler.
More importantly, it contains git submodules pointing to our versions of needed
third-party software, including:

- Celera Assembler, a.k.a. wgs-assembler
- Jellyfish (originally packaged with wgs-assembler, but removed b/c of license
  compatibility)
- AMOS

Currently, this has been tested on OS X 10.9 with gcc/g++ 4.9 from Homebrew.

TODO(10/24): get this working on Linux.

## Requirements

Being able to run <code>pacBioToCA</code> (including compiling AMOS) requires:

- Java 1.7+
- BLAT
- Boost

## Installation

In theory, it suffices to run:

    git submodule update --init
    ./install_third_party.sh
    ./install_downloads.sh

## Post-Installation

You will need to add <code>/usr/local/pacbio/bin</code> to your <code>${PATH}</code>.
