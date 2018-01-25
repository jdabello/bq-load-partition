#!/bin/sh

#Edit the values of PROJECT, DATASET, PARTITIONED_TABLE, SOURCE_TABLE and SOURCE_TABLE_DATE

now=`date +"%Y%m%d" -d "10/31/2017"`
end=`date +"%Y%m%d" -d "11/30/2017"`

while [ "$now" != "$end" ] ; 
do 
        now=`date +"%Y%m%d" -d "$now + 1 day"`; 
        now_two=`date +"%Y,%m,%d" -d "$now"`; 
        echo $now
        bq --nosync query --use_legacy_sql=false --allow_large_results --replace \
		--noflatten_results --destination_table '[DATASET].[PARTITIONED_TABLE]$'"$now"'' \
		'select
		*
		from `[PROJECT].[DATASET].[SOURCE_TABLE]` 
		where TIMESTAMP_TRUNC(TIMESTAMP([SOURCE_TABLE_DATE]), DAY)=TIMESTAMP(DATE('"$now_two"'));'
		sleep 0.6
done  
