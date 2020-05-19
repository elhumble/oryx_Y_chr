#!/bin/sh
# Grid Engine options
#$ -N sort_sam
#$ -cwd
#$ -l h_rt=2:00:00
#$ -l h_vmem=8G
#S -pe sharedmem 4
#$ -t 1-478
#$ -R y

# Jobscript to sort bam files

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java 

SCRATCH=/exports/eddie/scratch/ehumble
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_Y_2020/data/out

# Get list of files in target directory

bam=$(ls -1 ${TARGET_DIR}/*mapped.bam)

# Get file to be processed by *this* task
# Extract the Nth file in the list of files, $bam, where N == $SGE_TASK_ID

this_bam=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p)
echo Processing file: ${this_bam} on $HOSTNAME

mkdir $SCRATCH/data/out

BASE=$(echo "$this_bam" | cut -f 12 -d "/")

echo Saving file ${BASE} on $SCRATCH 

java -Xmx4g -jar /exports/cmvm/eddie/eb/groups/ogden_grp/software/picard/picard.jar SortSam \
       I=$this_bam \
       O=$SCRATCH/${BASE%.bam}_sorted.bam \
       SORT_ORDER=coordinate \
       TMP_DIR=$SCRATCH \

