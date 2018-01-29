#!/bin/sh

#e.g. bq-delete-partitions.sh partitioned_dataset partitioned_table 10/31/2017 11/30/2017

partitioned_dataset=$1
partitioned_table=$2
from=$3 #MM/DD/YYYY
to=$4 #MM/DD/YYYY

now=`date +"%Y%m%d" -d "${from}"` 
end=`date +"%Y%m%d" -d "${to}"`

while [ "$now" != "$end" ] ; 
do 
        now=`date +"%Y%m%d" -d "$now - 1 day"`; 
        now_two=`date +"%Y,%m,%d" -d "$now"`; 
        echo $now
        bq rm -f ''"${partitioned_dataset}"'.'"${partitioned_table}"'$'"${now}"''
		sleep 0.6
done  
