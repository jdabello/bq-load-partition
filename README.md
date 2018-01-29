# bq-load-partition

This directory contains a bash script that can be used to write query results to a partitioned table in [Big Query](https://cloud.google.com/bigquery/). It also provides a bash script that can be used to delete specific partitions. The script uses the [bq Command-Line tool](https://cloud.google.com/bigquery/bq-command-line-tool) to perform this actions.


## Table of Contents
1. [Install Google Cloud SDK (Optional)](#gcloud) 
2. [Create a partitioned table](#create-partitioned-table)
3. [Usage](#usage)

## <a name="gcloud"></a>1. Install Google Cloud SDK (Optional)

This bash script uses the bq Command-Line tool. If you haven't installed gcloud, follow the steps in the [Google Cloud SDK Documentation](https://cloud.google.com/sdk/docs/) to do so. Alternatively you can execute this scripts from [Cloud Shell](https://cloud.google.com/shell/).

## <a name="create-partitioned-table"></a>2. Create a partitioned table

Execute the followint command using the --time_partitioning_type flag to create an empty table in an existing dataset:

```bash
bq mk --time_partitioning_type=DAY [DATASET].[TABLE]
```

Where [DATASET] is an existing dataset in your project and [TABLE] is the name of the table you're creating.

## <a name="usage"></a>3. Usage

### Load Partitions

Execute the bq-load-partition.sh script indicating the projectid, the source dataset, source table, the destination dataset (partitioned_dataset), destination table (partitioned_table), the date field on the source table (source_table_date_field) and the date range in MM/DD/YYYY format.

```bash
bq-load-partition.sh project-id source_dataset source_table partitioned_dataset partitioned_table source_table_date_field MM/DD/YYYY MM/DD/YYYY
```

### Delete Partitions

Execute the bq-delete-partitions.sh script indicating the the destination dataset (partitioned_dataset), destination table (partitioned_table) and the date range to be deleted in MM/DD/YYYY format.

```bash
bq-delete-partitions.sh partitioned_dataset partitioned_table MM/DD/YYYY MM/DD/YYYY
```
