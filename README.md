# Dyadic Data Analysis -  Modeling the Within-Person Process for Continuous Outcomes

* Daily diary reports of arguments and relational intimacy by 66 women in a cohabiting intimate relationship
* Completed an online background questionnaire and online nightly diaries for 28 consecutive evenings

## Research Questions
* How much do daily conflicts lower intimacy for the typical person?
* How much do people differ in this relationship?
* Does relationship quality (RQ) buffer conflict reactivity such that those with higher RQ are less reactive to conflict?

## Variables
* `id`: Participant id
* `time`: Diary day (0, 1, 2, . . ., 27)
* `time7c`: Time in units of one week, centered
* `intimacy`: Daily intimacy score (0-10)
* `conflict`: Daily conflict (0=no, 1=yes)
* `relqual`: Relationship quality (0=low, 1=high RQ)

## Notes: 
* Need to separate within-person and between-person effects of longitudinal predictors
* Daily `intimacy` (outcome) has both within-person and between-person variability
* Daily `conflict` (predictor) also has both within-person and between-person variability
  * `conflcb`: Daily conflict (between) – centred at grand mean
  * `conflcw`: Daily conflict (within) – centred at person mean
* Controlling for mean conflict allows for a pure within-person interpretation of the effect of daily conflict on daily intimacy

## Main Analyses:
* Analyzed the data using multilevel model that specified a within-subject process of reactivity to daily conflicts that we predicted would be stronger for those in low-quality as opposed to high-quality relationships.

## Results Summary:
* Fixed effects `intimacy` ~ `conflictw` by `relqual`: t(62) = 2.06, p = .044, 95% CI: [0.03, 2.00]). Women in the high-RQ group were about 1 unit (on 1-10 scale) less reactive to within-person variation in daily conflict than women in the low-RQ group.


## Part 1: Time-Course Plots by Relationship Quality

### Time Course Plots for **Intimacy** for the *Low* Relationship Quality Group

![LRQ Intimacy Time Plot](https://github.com/matt-j-murphy/DyadicData/blob/ae22f0c67f85f99998faa61421d22d6c1fcc489b/lrq-intimacy-time.png) 

### Time Course Plots for **Intimacy** for the *High* Relationship Quality Group

![HRQ Intimacy Time Plot](https://github.com/matt-j-murphy/DyadicData/blob/ae22f0c67f85f99998faa61421d22d6c1fcc489b/hrq-intimacy-time.png) 

### Time Course Plots for **Conflict** for the *Low* Relationship Quality Group

![LRQ Conflict Time Plot](https://github.com/matt-j-murphy/DyadicData/blob/ae22f0c67f85f99998faa61421d22d6c1fcc489b/lrq-conflict-time.png) 

### Time Course Plots for **Conflict** for the *High* Relationship Quality Group
![HRQ Conflict Time Plot](https://github.com/matt-j-murphy/DyadicData/blob/ae22f0c67f85f99998faa61421d22d6c1fcc489b/hrq-conflict-time.png) 

![Spag](https://github.com/matt-j-murphy/DyadicData/blob/becef1f2e1904d00d836d3339896367f94305784/spag.png) 


## Part 2: Intimacy ~ Conflict by Relationship Quality

### **Intimacy** as a Function of **Conflict**: Raw Data and Model Predictions for the *Low* Relationship Quality Group

![LRQ Pred Panel](https://github.com/matt-j-murphy/DyadicData/blob/511ce7bfbdff001ed5b648ee8cf886a5f6f76d36/lrq-pred-panels.png) 

### **Intimacy** as a Function of **Conflict**: Raw Data and Model Predictions for the *High* Relationship Quality Group

![HRQ Pred Panel](https://github.com/matt-j-murphy/DyadicData/blob/1de03d433a4f4963778dbdc1be85176fe022a7d9/hrq-pred-panels.png) 


