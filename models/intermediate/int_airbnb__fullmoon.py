import holidays
import pandas as pd


def add_holiday_flag(pandas_dataframe):
    pandas_dataframe = pandas_dataframe.copy()

    dates = pd.to_datetime(pandas_dataframe["full_moon_date"])
    pandas_dataframe["full_moon_date"] = dates.dt.date

    # kalendarz musi znac lata z gory, inaczej jest pusty przy iteracji
    years = range(int(dates.dt.year.min()), int(dates.dt.year.max()) + 1)
    german_holidays = holidays.Germany(years=years)

    pandas_dataframe["is_holiday"] = pandas_dataframe["full_moon_date"].isin(
        list(german_holidays.keys())
    )
    return pandas_dataframe


def model(dbt, session):
    dbt.config(materialized="table")

    spark_dataframe = dbt.ref("seed_full_moon_dates")
    pandas_dataframe = spark_dataframe.toPandas()

    return add_holiday_flag(pandas_dataframe)