from textblob import TextBlob


def get_sentiment(text):
    if not isinstance(text, str) or not text.strip():
        return None
    return TextBlob(text).sentiment.polarity


def add_sentiment_score(pandas_dataframe):
    pandas_dataframe = pandas_dataframe.copy()
    pandas_dataframe["sentiment_score"] = pandas_dataframe["review_text"].apply(
        get_sentiment
    )
    return pandas_dataframe


def model(dbt, session):
    dbt.config(
        materialized="table",
        enabled=False)

    spark_dataframe = dbt.ref("stg_airbnb__reviews")
    pandas_dataframe = spark_dataframe.toPandas()

    return add_sentiment_score(pandas_dataframe)