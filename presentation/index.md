---
title       : Developing Data Products Presentation 
subtitle    : Movies Budget and Ratings Investigation Tool
author      : Seamus Sands
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Background

Each year an enormous amount of money is spent on creating "Great Hit" movies.

Using a sample dataset of thousands of films, which included the highest budgeted films within a 10 year period (1990-2000), as a relatively recent time period, shows staggering increases in budgets per movie.
This is shown in the calculations below:




```r
movies1990 <- movies[movies$year=="1990" ,]
max(movies1990$budget, na.rm = TRUE)
```

```
## [1] 70000000
```

```r
movies2000 <- movies[movies$year=="2000" ,]
max(movies2000$budget, na.rm = TRUE)
```

```
## [1] 127500000
```

---

## Motivation

This leads to a number of questions:

* Does a higher budget increase the movie rating?

* Is movie ratings increasing over the years?

* Is budget increasing year on year?

<br>

The Movies Budget and Ratings Investigation Tool allows the user to investigate these questions for themselves. 

--- 

## Features

<br><br>

This applications intuitive design allows the user to 

 - view the budget spent on a historical film catelog
 - investigate any potential link between budget and viewer rating
 - examine the film data, by searching or subsetting by year and genre

using a collection of thousands of films, dating back over 100 years.

---

## Application


<img src="application.png" alt="Drawing" style="width: 800px; border-style: solid; border-width: 5px; display: block; margin: 0 auto;" />

The application can be found [here] (https://seamuss.shinyapps.io/DevelopingDataProducts).
