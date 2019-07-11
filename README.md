# Econometric-textbook-stata-replication

Hello everyone, I will replicate results in some well-known textbooks using stata in this repository to help you learn basic stata programming in econometric. These textbooks are amazing for us to taste the secret sauce of econometrics. 

## Introductory Econometrics: A Modern Approach, 6th Edition

Book Author: Jeffrey M. Wooldridge 

### Dataset 

Please download dataset from [Boston college](http://fmwww.bc.edu/ec-p/data/wooldridge/datasets.list.html) and save them into your stata working directory, then whenever you want to use the data, just type `use dataset_name`, such as `use WAGE1`

Or else, you can install `bcuse` command in stata using `ssc install bcuse`
Then you can use the dataset directly from the website above such as `bcuse WAGE1`. For more details, please see `help bcuse`

### Replication files for each chapter

I referenced previous replication work by [Boston college](http://fmwww.bc.edu/gstat/examples/wooldridge/wooldridge.html)

However, this work is for 1st and 2nd edition of the book, and we have even Stata 16 now, so I update previous work and try my best to replicate results in the new book. I may make some mistakes since I need to replicate all examples from chapter 2 to chapter 18 (Generally, each chapter contains nine to ten examples). If you find some mistakes in my work, please contact me or just update them in the repository by your contributions.  

My replication work is updated in [Introductory Econometrics: A Modern Approach](https://github.com/Econtech/-Econometric-textbook-stata-replication/tree/master/Introductory%20Econometrics%20A%20Modern%20Approach) and feel free to try the do files and correct my potential errors among them.  

