#!/bin/csh -f

# Name of job
#$ -N incore_prep

# Name of queue
#$ -q barcelona.q 

# Set parallel environment; set number of processors
#$ -pe orte 4

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

set input=$1
set output=$2
set filt_strength=$3

setenv IMAGIC_BATCH 1
echo "! "
echo "! "
echo "! ====================== "
echo "! IMAGIC ACCUMULATE FILE "
echo "! ====================== "
echo "! "
echo "! "
echo "! IMAGIC program: incprep ----------------------------------------------"
echo "! "
mpirun -np $NSLOTS -x IMAGIC_BATCH /opt/qb3/imagic-110119e/incore/incprep.e_mpi <<EOF
$input
$output
0.03
0.005
$filt_strength
0.7,0.2
10.0
NO
EOF

touch incore_prep_is_done
