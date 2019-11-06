# Econometric-textbook-stata-replication

Hello everyone, I've been replicating results in some well-known econometrics textbooks using stata here to help you learn basic to advance stata programming in econometric. 

## [Mostly Harmless Econometrics](http://www.mostlyharmlesseconometrics.com/)
Book Author: Joshua D. Angrist and Jörn-Steffen Pischke 
![Book](https://github.com/Econtech/-Econometric-textbook-stata-replication/blob/master/Introductory%20Econometrics%20A%20Modern%20Approach/book%20picture.jpg)

### Dataset and replication files
Most of the datasets and some of the replication programs come from [MHE Data Archive](http://economics.mit.edu/faculty/angrist/data1/mhe) and [Angrist Data Archive](http://economics.mit.edu/faculty/angrist/data1/data). I also reference the replication files of [vikjam](https://github.com/vikjam/mostly-harmless-replication). His work is amazing but I still find some mistakes and update them in my replications.

#### Chapters







## [Introductory Econometrics: A Modern Approach, 6th Edition](https://www.cengage.com/c/introductory-econometrics-a-modern-approach-6e-wooldridge/9781305270107/)
Book Author: Jeffrey M. Wooldridge 

### Dataset and replication files

Please download dataset from [Boston college](http://fmwww.bc.edu/ec-p/data/wooldridge/datasets.list.html) and save them into your stata working directory (To find your stata working directory, please type `pwd` in stata)

Then whenever you want to use the data, just type `use dataset_name`, such as `use WAGE1`

Or else, you can install `bcuse` command in stata using `ssc install bcuse`

Then you can use the dataset directly from the website above such as `bcuse WAGE1`. For more details, please see `help bcuse`

I referenced previous replication work by [Boston college](http://fmwww.bc.edu/gstat/examples/wooldridge/wooldridge.html)

However, this work is for 1st and 2nd edition of the book, and we have Stata 16 now, so I update previous work and try to replicate the results in the new book. From chapter 2 to 18, each chapter contains about nine to ten examples.

My replication work is updated in [Introductory Econometrics: A Modern Approach](https://github.com/Econtech/-Econometric-textbook-stata-replication/tree/master/Introductory%20Econometrics%20A%20Modern%20Approach). Please feel free to try the do files and correct my potential errors among them.  

