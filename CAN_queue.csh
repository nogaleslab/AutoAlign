#!/bin/csh -f

# Name of job
#$ -N CAN

# Name of queue
#$ -q barcelona.q 

# Set parallel environment; set number of processors
#$ -pe smp 2

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
set classums=$2
set numIters=$3
set directLearning=$4
set indirectLearning=$5
set maxage=$6
set nodes=$7

# To submit:  qsub ../CAN_submit.csh ../current_mra classsums${i} $numIters 0.01 0.0005 25 $nodes

../CAN $input $classums $numIters $directLearning $indirectLearning $maxage $nodes

touch CAN_is_done
