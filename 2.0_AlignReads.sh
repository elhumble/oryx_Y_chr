#!/bin/sh
# Grid Engine options
#$ -N ed_bwa_mem
#$ -cwd
#$ -l h_rt=24:00:00
#$ -l h_vmem=12G
#$ -t 1-478
#$ -pe sharedmem 8
#$ -R y
#$ -e e_files/
#$ -o o_files/

# Jobscript to index reference

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load blast
module load roslin/bwa/0.7.17
module load roslin/samtools/1.9 

OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_Y_2020/data/out
TARGET_DIR=/exports/eddie/scratch/ehumble
SAMPLE_SHEET="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_Y_2020/file_lists/samples.txt"
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_Y_2020/reference/oryx.1.FINAL.fasta

# Get list of files

base=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $1}'`
r1=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $2}'`
r2=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $3}'`


# Process
echo Processing sample: ${base} on $HOSTNAME

bwa mem -t 8 $REFERENCE $TARGET_DIR/$r1 $TARGET_DIR/$r2 | samtools view -bF 4 - > $OUTPUT_DIR/${base}_mapped.bam
