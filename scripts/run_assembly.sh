#!/bin/bash
set -e

ROOT_PATH="$(pwd)"

RESULTS_PATH="${ROOT_PATH}/results"
EC_SPEC_PATH="${ROOT_PATH}/pacbio_ec.spec"
ASM_SPEC_PATH="${ROOT_PATH}/pacbio_asm.spec"

PACBIO_FASTQ_PATH="${ROOT_PATH}/pacbio.fastq"
PACBIO_FRG_PATH="${ROOT_PATH}/pacbio.frg"
PACBIO_EC_FRG_PATH="${ROOT_PATH}/pacbio_ec.frg"

ILLUMINA_1_FASTQ_PATH="${ROOT_PATH}/illumina_1.fastq"
ILLUMINA_2_FASTQ_PATH="${ROOT_PATH}/illumina_2.fastq"
ILLUMINA_FRG_PATH="${ROOT_PATH}/illumina.frg"

# See: <http://wgs-assembler.sourceforge.net/wiki/index.php/FastqToCA>.
#
# This will make a frg files for the libraries.
# Both fastq sets (pacbio and illumina) use sanger style phred scores
# (this can be seen by the '#' and '+' characters).
fastqToCA -technology pacbio-raw -libraryname pacbio -reads "${PACBIO_FASTQ_PATH}" > "${PACBIO_FRG_PATH}"
fastqToCA -insertsize 400 75 -technology illumina-long -libraryname illumina -mates "${ILLUMINA_1_FASTQ_PATH}","${ILLUMINA_2_FASTQ_PATH}" > "${ILLUMINA_FRG_PATH}"

# See: <http://wgs-assembler.sourceforge.net/wiki/index.php/PacBioToCA>.
#
# pacBioToCA needs AMOS. Mostly compiles as intended (needs a minor patch).
pacBioToCA -length 500 -partitions 200 -t 1 -l pacbio_ec -s "${EC_SPEC_PATH}" -fastq "${PACBIO_FASTQ_PATH}" "${ILLUMINA_FRG_PATH}"
rm -rf temppacbio_ec

# See: <http://wgs-assembler.sourceforge.net/wiki/index.php/RunCA>.
mkdir -p "${RESULTS_PATH}"
runCA -d "${RESULTS_PATH}" -p pacbio_asm -s "${ASM_SPEC_PATH}" "${PACBIO_EC_FRG_PATH}"
