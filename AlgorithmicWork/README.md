# Algorithmic Work
Here you can find our SQL queries for
* [Snow](snow.sql)
* [Precipitation](precipitation.sql)
* [Wind](wind.sql)

The interpretation and usage in QuickSight can be found [here](../Visualization)

______
### A quick note on time series weather prediction
According to our problem statement, we aimed to aggregate past weather data instead of predicting new ones.
Therefore, we aggregated several observations with their location and correlated the results to conclude where the best place for a new refugee settlement and the establishment of a new big city would be the best.

However, we tried to work with Spark's Machine Learning package and expand the prediction of a new TMAX date to multiple observations concerning a previous date.

The files are located here:
* [Prediction Model Training](prediction/observation_train.py)
* [Prediction of new observation values](prediction/observation_prediction.py)

Our solution's disadvantage was that we tried to implement a time series forecasting from scratch that frameworks like Prophet have already solved.
And these technologies are continuously optimized. That's why we stopped after our first draft considering the prediction further.
