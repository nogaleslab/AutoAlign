#!/bin/csh -f

# Name of job
#$ -N pretreat

# Name of queue
#$ -q barcelona.q 

# Set parallel environment; set number of processors
#$ -pe orte 8

# Max walltime for this job (2 hrs)
##$ -l h_rt=02:00:00

# Merge the standard out and standard error to one file
##$ -j y

# Run job through csh shell
#$ -S /bin/csh

# use current working directory
#$ -cwd

# The following is for reporting only. It is not really needed
# to run the job. It will show up in your output file.
#

echo "Job starting `date`"
echo "Current working directory: $cwd"
echo "Got $NSLOTS processors."

# The job

# To run: qsub pretreat.csh classsums${i}

set input=$1


setenv IMAGIC_BATCH 1
echo "! "
echo "! "
echo "! ====================== "
echo "! IMAGIC ACCUMULATE FILE "
echo "! ====================== "
echo "! "
echo "! "
echo "! IMAGIC program: alimass ----------------------------------------------"
echo "! "
mpirun -np $NSLOTS -x IMAGIC_BATCH /opt/qb3/imagic-110119e/align/alimass.e_mpi MODE MASS <<EOF
$input
${input}_center
0.7
0.15
NO
EOF
echo "! "
echo "! IMAGIC program: alirefs ----------------------------------------------"
echo "! "
/opt/qb3/imagic-110119e/align/alirefs.e <<EOF
BOTH
ROTATION_FIRST
CCF
${input}_center
NO
0.99
${input}_center_prep
-999.
0.3
-180,180
LOW
0.0,0.7
NO
5
NO
EOF
echo "! "
echo "! IMAGIC program: arithm -----------------------------------------------"
echo "! "
/opt/qb3/imagic-110119e/stand/arithm.e <<EOF
${input}_center_prep
${input}_center_prep_mask
SOFT
0.6
0.2
EOF
echo "! "
echo "! IMAGIC program: pretreat ---------------------------------------------"
echo "! "
/opt/qb3/imagic-110119e/stand/pretreat.e <<EOF
${input}_center_prep_mask
${input}_center_prep_mask_norm
NORM_VARIANACE
WHOLE
10.0
NO
NO
EOF

touch pretreat_is_done
