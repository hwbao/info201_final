[<img src="www/Ar.png" width= 200px height=150px
     alt="Kickstarter Data Visualization"
/>](https://hwbao.shinyapps.io/info201_final/)
## Click the Logo to enter the website!

# Project Description

**What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.**

- We are working with the dataset that are collected from the [Kickstarter Platform](https://www.kickstarter.com). Kickstarter is a global crowdfunding platform that focuses on creativity and merchandising. Kickstarter has reportedly received more than $4 billion in pledges from 15.5 million backers to fund 257,000 creative projects, such as films, music, video games, etc.
We found the data on [Kaggle](https://www.kaggle.com/kemical/kickstarter-projects).

**Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences.**
	
- Our target audience would be the creators are who interested in posting their projects on the Kickstarter website. Our data analysis and visualization would provide them with a general idea of the competition that exist on the Kickstarter website. 

- On the other hand, we also target the potential investors as our audience. With the help of our data analysis, they would have a better picture of the risks and profit they are facing. 


**What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.**

1. What is the successful rate for each different category of Kickstarter projects?
2. What’s the average amount of money that a backer would give to a project in specific category?
3. What’s the average goal for a specific category?
4. What is the trend of crowd fundraising in terms of different categories and timelines?
5. What is the most popular category in each country?

# Technical Description
**How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?**

- We will be reading the data as a static .csv file.

**What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?**
- We need to reformat the data such as the date, client ID, etc. For instance, We will use functions, such as select and filter, to get the specific value that we require.

**What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as dplyr)**

- We will be using libraries such as shiny, ggplot, plotly, leaflet, etc.

**What major challenges do you anticipate?**

- We are expecting challenges such as cleaning up the data (NA/Null values...)
Also, it would be challenging if we are merging data from different online databases. 

**Not required, but optional: what questions, if any, will you be answering with statistical analysis/machine learning?**

- It is possible that we could use the help of machine learning to predict the future kickstarter projects’ success rate by summarizing the law from the past.
