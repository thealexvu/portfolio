# Movie Rental Business Acquisition

## Situation
A business owner is interested in purchasing your movie rental business. As he primarily works in other industries, he is interested in understanding the details of your business.

## Objective
Use SQL to extract and analyze data from the movie rental database to answer the acquirer's questions.

## Requests and Deliverables

> [!NOTE]
> All deliverables were acquired with the statements as run in [movie-business-sale.sql](movie-business-sale.sql)

**1. My partner and I want to come by each of the stores in person and meet the managers. Please send over the managers' names at each store, with the full address of each property(street address, district, city, and country please)**

CSV: [Manager Information List](./csv/1.csv)

**2. I would like to get a better understanding of all of the inventory that would come along with the business. Please pull together a list of each inventory item you have stocked, including the store_id number, the inventory_id, the name of the film, the film's rating, its rental rate and replacement cost.**

CSV: [Inventory Counts by Store](./csv/2.csv)

**3. From the same list of films you just pulled, please roll that data up and provide a summary level overview of your inventory. We would like to know how many inventory items you have with each rating at each store.**

CSV: [Inventory by Rating](./csv/3.csv)

**4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to see how big of a hit it would be if a certain category of film beceame unpopular at a certain store. We would like to see the number of films, as well as the average replacement cost, and total replacement cost, sliced by store and film category.**

CSV: [Inventory Replacement Costs by Category](./csv/4.csv)

**5. We want to make sure you folks have a good handle on who your customers are. Please provide a list of all customer names, which store they go to, whether or not they are currently active, and their full addresses - street address, city, and country.**

CSV: [Customer Information](./csv/5.csv)

**6. We would like to understand how much your customers are spending with you, and also to know who your most valuable customers are. Please pull together a list of customer names, their total lifetime rentals, and the sum of all payments you have collected from them. It would be great to see this ordered on lifetime value, with the most valuable customers at the top of the list.**

CSV: [Customer Lifetime Value](./csv/6.csv)

**7. My partner and I would like to get to know your board of advisors and any current investors. Could you please provide a list of advisor and investor names in one table? Could you please note whether they are an investor or an advisor, and for the investors, it would be good to include which company they work with.**

CSV: [List of Advisors and Investors](./csv/7.csv)

**8. We're interested in how well you have covered the most-awarded actors. Of all the actors with three types of awards, for % of them do we carry a film? And how about for actors with two types of awards? Same questions. Finally, how about actors with just one award?**

CSV: [Inventory by Award-Winning Actors](./csv/8.csv)