# README

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

We need an API that can return the total sales commissions for a given sales representative. We want to persist our sales data in a database as well.

## Setup

```
bundle install
bundle exec rails db:create
```

Use `bundle exec rspec` to run tests

