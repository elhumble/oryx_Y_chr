#!/bin/sh
# Grid Engine options
#$ -N ed_index_ref
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=16G
#$ -pe sharedmem 4
#$ -R y
#$ -o o_files/
#$ -e e_files/

# Jobscript to index reference

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load samtools
module add roslin/samtools/1.9
module add roslin/bwa/0.7.17

REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_Y_2020/reference/oryx.1.FINAL.fasta

# index ref with both bwa and samtools for mapping and SNP calling with samtools

samtools faidx $REFERENCE
bwa index $REFERENCE
