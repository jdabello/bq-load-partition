#!/bin/sh

#e.g. bq-load-partition.sh project-id source_dataset source_table partitioned_dataset partitioned_table source_table_date_field 10/31/2017 11/30/2017

#Read parameters
project=$1                 #GCP Project
source_dataset=$2          #BigQuery Source Dataset
source_table=$3            #BigQuery Source Table
partitioned_dataset=$4     #BigQuery Destination Dataset
partitioned_table=$5       #BigQuery Destination Table (partitioned)
source_table_date_field=$6 #Date field on the source table that will be used to partition the table
from=$7 #MM/DD/YYYY        #Start date
to=$8 #MM/DD/YYYY          #End date
source_path="${project}.${source_dataset}.${source_table}"

now=`date +"%Y%m%d" -d "${from}"` 
end=`date +"%Y%m%d" -d "${to}"`


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