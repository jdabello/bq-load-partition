#!/bin/sh

#e.g. bq-load-partition.sh project-id source_dataset source_table partitioned_dataset partitioned_table source_table_date_field 10/31/2017 11/30/2017

#Read parameters
project=$1
source_dataset=$2
source_table=$3
partitioned_dataset=$4
partitioned_table=$5
source_table_date_field=$6
from=$7 #MM/DD/YYYY
to=$8 #MM/DD/YYYY
source_path="${project}.${source_dataset}.${source_table}"

now=`date +"%Y%m%d" -d "${7}"` 
end=`date +"%Y%m%d" -d "${8}"`


while [ "$now" != "$end" ] ; 
do 
        now=`date +"%Y%m%d" -d "$now + 1 day"`; 
        now_two=`date +"%Y,%m,%d" -d "$now"`; 
        partition="${partitioned_dataset}.${partitioned_table}\$${now}"
        echo "Loading Partition: ${partition}"
        bq --nosync query --use_legacy_sql=false --allow_large_results --replace \
		--noflatten_results --destination_table "${partition}" \
		'select
		*
		from `'"${source_path}"'` 
		where TIMESTAMP_TRUNC(TIMESTAMP('"${source_table_date_field}"'), DAY)=TIMESTAMP(DATE('"${now_two}"'));'
		sleep 0.6
done  