#!/bin/sh 

# Reference CPU solution - varying size

###				QUEUE?
#BSUB -q hpcintrogpu
#BSUB -J poisson_ref_cpu
#BSUB -n 1
#BSUB -R "rusage[mem=1024MB]"

##				SHOULD  WHAT ABOUT GPU?
#BSUB -R "select[model=XeonE5_2650v4]"
#BSUB -R "span[hosts=1]"
##				CAN I JUST CHANGE TO CPU?
#BSUB -gpu "num=1:mode=exclusive_process"
#BSUB -M 4GB
#BSUB -W 40
###BSUB -B 
#BSUB -N 
#BSUB -o O_ratio_1_%J.out 
#BSUB -e E_ratio_1_%J.err 

#CC=${1-"gcc"}
NDIMS="256"
START_T=16
EXECUTABLE_J="../poisson_j"
THREADS="1 2 4 6 8 10 12 14 16 18 20 22 24"
lscpu
LOGEXT=$CC.dat
export OMP_DISPLAY_ENV=verbose
export OMP_DISPLAY_AFFINITY=TRUE
export OMP_PLACES=cores
export OMP_PROC_BIND=spread #close

for NDIM in $NDIMS
do
	/bin/rm -f "./perf_j_$NDIM$LOGEXT"
	for n in $THREADS
	do
	
		export OMP_NUM_THREADS=$n
		echo $EXECUTABLE_J  $NDIM 3000 0.0 $START_T 0 1 $n
		$EXECUTABLE_J $NDIM 3000 0.0 $START_T 0 1  | grep -v CPU >> ./perf_numa_$NDIM$LOGEXT

	done
done

exit 0

