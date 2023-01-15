# Brainstorming
Please indicate the proposed topic/analysis/product, as well as the technologies you intend to use. We will provide some feedback on your proposed project.
[Link to coursys](https://coursys.sfu.ca/2022fa-cmpt-732-g1/pages/Project#h-proposal)

### Data processing
* temperature by ground cover
* cloudiness by ground cover, temperature
* wind by temperature, ground cover
* tornadoes by wind, temperature, ground cover (...)
* soil 

### Hypotheses

* Forests are cooler than cities
* Number of bush fires has increased because of a higher temperature during summer
* Number of blizzards has increased because of a lower temperature during winter
* There is more extreme weather than before
* Extreme weather cases: does more snow in winter correlate to more dust in summer?
* Does the Ground cover change over the years? And what impact has the ground on the weather?
* How is the cloudiness or wind impacted on climate change?
* Under which conditions do tornadoes occur more frequently? (future: first step before prediction? alerting?)


### Target group
* Agriculture: Effect of disasters on Agriculture
* Citizens

### Technologies
* Data Processing: Spark?
* UI and Visualization: TODO
* 1 new technologies: TODO (maybe the one )


# Proposal
## Target Group
Agriculture

## Dataset
* Getting the data: Acquiring/gathering/downloading.
    * https://www.ncei.noaa.gov/products/land-based-station/global-historical-climatology-network-daily

## Problem Statement
* Work on defining problem itself and motivation for the analysis.
    * ELEMENTS=Temperature, Snowfall, Wind, Rain, Cloudiness, Fog
    * Trend of ELEMENTS over time
        * Relate them to extrem weather cases/ disasters
        * Impact on soil
    * Effect of surface on the ELEMENTS
        * Divide the data by regions (tropics vs. northern countries)
        * Which country is more affected by ELEMENTS compared to others

### Workflow
*  Algorithmic work: Work on the algorithms including integrating data mining and machine learning techniques.
    * ETL
    * Data analysis and evaluation
    * Data visualization
    * Bigness/parallelization

### Technologies
* ETL: Extract-Transform-Load work and cleaning the data set.
    * Spark
* Bigness/parallelization: Efficiency of the analysis on a cluster, and scalability to larger data sets.
    * AWS
* UI: User interface to the results, possibly including web or data exploration frontends
    * TODO ask Greg/ George
* Visualization: Visualization of analysis results
    * TODO ask Greg/ George
* Technologies: New technologies learned as part of doing the project.
    * TODO ask Greg/ George

# Team Collaboration
* Members: Karishma, Crystal, Jeanne
* Division of work
    * Out of the 6 elements (mentioned in our Project Statement), each one of us would analyze 2
* Version Control System: GitLab
