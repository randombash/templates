#!/bin/bash   

# Author:
# Purpose:

# Only use color if not a DUMB terminal.
[ -t 1 ] || export TERM=dumb
txtbold=$(tput bold)   # Bold
txtreset=$(tput sgr0)  # Reset

#traps to remove or keep temporary file
trap 'echo -e  "\nScript terminated. Removing temporary files, if any." && rm -f $temp_file; exit ' SIGINT ERR 
trap 'echo -e "\nLeaving  $temp_file in place -please remove manually" ; exit 131' SIGQUIT
trap 'rm -f $temp_file' EXIT

function usage() {
    echo -ne "$@" 2>&1
    echo "USAGE: $0 ['arg1'] [arg2]"
    echo "    arg1:      is blablabla"
    echo "    arg2:      is eciepecie"
    echo -e "When ran without awrguments, $0 prompts for all parameters."
}

function  input(){
    if [[ "$*" = "--help" || "$*" = "-h" ]]; then  usage ; exit 0 
    elif [ "$#" -ne 1 ] && [ "$#" -ne 2 ] && [ "$#" -ne 0  ]; then  usage "ERROR: expected 1 or 2 arguments but got $#.\n"; exit 1;
    elif [ "$#" = 0 ]; then
        read -rp "arg1:  " arg1
        read -rp "arg2 (optional):  " arg2 
    else arg1=$1; arg2=$2; 
    fi
}

#debugging information:
debug () {
    echo "Debugging info:"
    #This script's process ID
    echo PID: $$
    #Variables used by this script
    echo -e "    Used for processing:\narg1=${arg1}\narg2=${arg2}\n";
    #echo -e "\nAll log lines:\n"
    #cat $temp_file ;
    }
#debug

main (){
  ### main function do things here
  ## set variables
  #temporary file to log to:
  temp_file=$(mktemp)

  
  #take input from cli or prompt, print help or catch incorrect input
  input "$@"
  

}

main
