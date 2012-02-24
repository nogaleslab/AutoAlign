#!/bin/csh -f

# Name of job
#$ -N MRA

# Name of queue
#$ -q barcelona.q 

# Set parallel environment; set number of processors
#$ -pe orte 22 

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

set input=$1
set output=$2
set refs=$3
set bandpass=$4
set filt_str=$5

echo '$input'
echo '$output'
echo '$refs'
echo '$bandpass'
echo '$filter_str'

setenv IMAGIC_BATCH 1
echo "! "
echo "! "
echo "! ====================== "
echo "! IMAGIC ACCUMULATE FILE "
echo "! ====================== "
echo "! "
echo "! "
echo "! IMAGIC program: mralign ----------------------------------------------"
echo "! "
mpirun -np $NSLOTS -x IMAGIC_BATCH  /opt/qb3/imagic-110119e/align/mralign.e_mpi <<EOF
FRESH
ALL_REFERENCES
ALIGNMENT
BOTH (ROT AND TRANS)
ROTATION_FIRST
CCF
$input
$output
$bandpass
$refs
NO_FILTER
0.2
0.2
-180,180
-180,180
LOW
0.0,0.7
5
NO
EOF

touch MRA_is_done
