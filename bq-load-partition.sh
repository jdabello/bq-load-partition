#!/bin/sh

now=`date +"%Y%m%d" -d "10/31/2017"`
end=`date +"%Y%m%d" -d "11/30/2017"`

while [ "$now" != "$end" ] ; 
do 
        now=`date +"%Y%m%d" -d "$now + 1 day"`; 
        now_two=`date +"%Y,%m,%d" -d "$now"`; 
        echo $now
        bq --nosync query --use_legacy_sql=false --allow_large_results --replace \
		--noflatten_results --destination_table 'my_dataset.my_partitioned_table$'"$now"'' \
		'select
		a,
		e,
		i,
		o,
		u
		from `my_project.my_dataset.vowels` 
		where TIMESTAMP_TRUNC(TIMESTAMP(vowel_date), DAY)=TIMESTAMP(DATE('"$now_two"'));'
		sleep 0.6
done  
