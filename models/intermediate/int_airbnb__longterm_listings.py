from pyspark.sql import functions as F


def model(dbt, session):
    dbt.config(
        enabled=False)
    
    spark_dataframe = dbt.ref("int_airbnb__listings_cleaned")

    spark_dataframe = (
        spark_dataframe
        .filter(F.col("minimum_nights") >= 30)
        .select("listing_id", "listing_name", "price")
    )

    # model required 6 IAM roles, storage bucket and 2 compute accounts.
    return spark_dataframe