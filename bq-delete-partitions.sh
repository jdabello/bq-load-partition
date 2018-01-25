#!/bin/sh

now=`date +"%Y%m%d" -d "10/31/2017"`
end=`date +"%Y%m%d" -d "11/30/2017"`

while [ "$now" != "$end" ] ; 
do 
        now=`date +"%Y%m%d" -d "$now - 1 day"`; 
        now_two=`date +"%Y,%m,%d" -d "$now"`; 
        echo $now
        bq rm -f 'my_dataset.my_partitioned_table$'"$now"''
		sleep 0.6
done  