# Sales Commission Kata

## Purpose

These coding exercises are meant to help Spiff gain insight into how you would tackle actual feature requests by the product team. The exercises are relatively simple, but you are encouraged to treat them as if you were working on the Spiff codebase. **This means applying the same attention to code quality, tests, pull requests, commits, etc as you normally would.**

**_Quality is valued above quantity. We value simple and readable code_**

## Instructions

You have been hired to work on a commission calculator for a sales team. The commission is calculated based on the total sales made by the team and the individual sales made by each sales representative. The commission rates are as follows:

If the total sales made by the team are less than $100,000, the commission rate is 10%.
If the total sales made by the team are between $100,000 and $200,000, the commission rate is 15%.
If the total sales made by the team are greater than $200,000, the commission rate is 20%.
In addition, each sales representative has an individual commission rate based on their performance:

If the sales representative's individual sales are less than $10,000, their commission rate is 5%.
If the sales representative's individual sales are between $10,000 and $20,000, their commission rate is 7.5%.
If the sales representative's individual sales are greater than $20,000, their commission rate is 10%.
The commission for each sales representative is calculated by multiplying their individual commission rate by their individual sales.

You have been given a Ruby program that calculates the commission for each sales representative based on the total sales made by the team and their individual sales. The code is working, but it is hard to read, difficult to understand, and hard to maintain. Your task is to refactor the code to make it easier to read and maintain while preserving its behavior.

## Setup

1. Clone the repo (don't fork)
2. Point the remote origin to a new repo under your account
3.

```
bundle install
bundle exec rspec
```

4. Refactor, testing and committing along the way
4. Create a pull request on your repo when finished

## Guidelines

* Please leave any comments that will help the reader understand important decisions you made, shortcuts taken, or things you would do differently in the future.
* Please talk out loud while pairing, explaining your intentions and decision making.

# Changes

I decided to not hardcoded the commission rates and the commission equation and instead use a configuration file with some defauts values. This way, if the commission rates change, we can just change the configuration file and the code will still work. Aditionally we can pass them as parameters to the class.

My second decision was to use a string equation that we can transform in a function to calculate the commission for the sales representative.

We can use some variables to make the equation more readable and easier to understand.

`team_rate`: is the commission rate for the team (0.1, 0.15, 0.2)
`individual_rate`: is the commission rate for the individual (0.05, 0.075, 0.1)
`total_sales`: is the total amount from all sales
`individual_sales`: is the individual sales for each sales representative

The default equation is: `"team_rate * total_sales + individual_rate * individual_sales"`, but we can pass any equation we want to calculate the commission.

Some exemples of use:
```
# Changing the team rates
team_rates = {
                (0..9_999.99) => 0.1,
                (10_000..59_999.99) => 0.15,
                (60_000..Float::INFINITY) => 0.2,
            }

SalesCommission::Calculator.new(50_000, sales_representatives, team_rates: team_rates)

# Changing the individual rates
individual_rates =  {
                        (0..999.99) => 0.05,
                        (1_000..1_999.99) => 0.075,
                        (2_000..Float::INFINITY) => 0.1,
                    }

SalesCommission::Calculator.new(50_000, sales_representatives, individual_rates: individual_rates) 

# Changing the equation
SalesCommission::Calculator.new(50_000, sales_representatives, personalized_equation: "individual_sales * team_rate * individual_rate")
```