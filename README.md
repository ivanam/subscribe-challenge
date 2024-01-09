# Sales Tax Calculator - Challenge Subscribe

This application calculates the receipt details for shopping baskets, considering basic sales tax and import duty. The basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical products that are exempt. Import duty is an additional sales tax applicable to all imported goods at a rate of 5%, with no exemptions.

## Problem Statement

When you purchase items, the application will provide a receipt listing the name of all the items, their prices (including tax), and the total cost of the items. Additionally, the receipt includes the total amounts of sales taxes paid. The rounding rules for sales tax dictate that for a tax rate of n%, a shelf price of p contains (np/100, rounded up to the nearest 0.05) amount of sales tax.

## Input

The application expects input in the following format:

**Input 1:**
```
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

**Input 2:**
```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

**Input 3:**
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

## Output

The application produces output in the following format:

**Output 1:**
```
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

**Output 2:**
```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```

**Output 3:**
```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

## Dependencies

```ruby 3.1.4```

```'minitest', '~> 5.12.0'```

## Setup

Run ```bundle install```

## Usage

Run ```ruby main.rb``` 

## Run Tests

Run ```ruby ./test/run.rb``` 
