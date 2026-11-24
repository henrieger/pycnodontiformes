#!/usr/bin/env bash

print_help() {
  echo "Helper script to run MrBayes analysis"
  echo "Usage: $0 [-h] [-n THREADS] [-x PATH]"
  echo
  echo "Options:"
  printf "\t-h\n\t--help\n\t\tPrint this help message and exit\n\n"
  printf "\t-n THREADS\n\t-j THREADS\n\t--jobs THREADS\n\t-t THREADS\n\t--threads THREADS\n\t\tSpecify the maximum number of MPI threads for the analysis\n\n"
  printf "\t-x PATH\n\t--executable PATH\n\t\tSpecify the executable path for MrBayes with MPI support.\n"
}

valid_mb_exec() {
  if [[ $($1 -v) != "MrBayes"* ]]; then
    return 1
  fi

  $1 -v | grep Features | grep MPI &> /dev/null
  return $?
}


njobs=16
mrbayes_candidate=

while [[ "$#" -gt 0 ]]; do 
  case $1 in 
    -h|--help)
      print_help
      exit 0
    ;;
    -x|--executable)
      mrbayes_candidate=$2
      shift
    ;;
    -n|-j|-t|--jobs|--threads)
      njobs=$2
      shift
    ;;
  esac
  shift
done

mrbayes_exec=
if [[ -n $mrbayes_candidate ]]; then 
  if [[ $(valid_mb_exec $mrbayes_candidate) ]]; then
    mrbayes_exec=$mrbayes_candidate
  else
    echo "Executable '$mrbayes_candidate' is not a valid MrBayes path with MPI support" 1>&2
    exit 1
  fi
elif [[ $(valid_mb_exec mb) ]]; then
  mrbayes_exec=mb
elif [[ $(valid_mb_exec mb-mpi) ]]; then
  mrbayes_exec=mb-mpi
else
  echo "MrBayes with MPI support not found." 1>&2
  echo "Please specify a valid path for MrBayes with MPI support with the -x option" 1>&2
  echo " or install it from a valid repository." 1>&2
  exit 1
fi

mpirun -n $njobs --oversubscribe $mrbayes_exec costa_2026_combined.mb
