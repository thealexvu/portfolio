# 🏈 NFL Player Statistics for Fantasy Football

*Last Updated: July 31, 2023*

## Usage:
- Select a player or team defense from the *Select Player* dropdown list
	- The player's information and selected statistics are displayed in the tables
	- The selected statistics will dynamically change based on the player's position
- Select a Fantasy Football Scoring Method to calculate the selected player's total fantasy football points for the seasons listed.
	- The options include Standard (no points/reception), Half PPR (0.5 points per reception), and Full PPR (1 point per reception)
- In the Player Statistics table, there are two custom columns that can be used to view other statistical categories for the player, based on his position.
- In the League Average table, the user can select to compare the selected player's statistics with the entire league, or only players of his same position.
	- Additionally, the user can enter a minimum numeric qualifier for any of the listed statistics to compare the selected player with other players of similar quality.
- Data visualization is provided that displays the selected player's fantasy football performance as compared to the league average.
	- Additionally, there are column charts for each listed statistical category that compares the selected player with the league average. This will dynamically change based on the selected player and his position.

![image](https://github.com/thealexvu/portfolio/assets/12503011/41201b61-7c1a-490c-806e-2af3cacc4961)

## Purpose
- In anticipation of the 2023 NFL Fantasy Football season, I want to create a dashboard in Microsoft Excel that can display all position-relevant statistics for any given player from previous seasons.
- Important Considerations:
	- This dashboard will assume a standard fantasy football league system, which typically includes a segment of relevant positions that are scored
		- These positions are QB, RB, WR, TE, K, and Team Defense
			- There are leagues that utilize individual defensive players, but for the purpose of this dashboard, I'll be ignoring individual defensive statistics since I have never played in a league like that (maybe in a v2!)
- The dashboard should include:
	- Player selection selector
	- Key metrics for selected player, based on position
	- General information about selected player
	- Data visualization that displays selected player metrics compared to other players in same position and/or eligible players with selected metric
	- Dynamic table showing similar players based on selected metric
- Wishlist:
	- Functionality to calculate selected player's fantasy football point totals based on custom scoring formats

## Data Collection
- The statistics to be used will be for the previous 2 seasons (2021 - 2022), which can be found from Pro Football Reference: https://www.pro-football-reference.com
	- For example, the 2022 Passing stats for all players can be found at https://www.pro-football-reference.com/years/2022/passing.htm
	- The reason of having the 2021 as the earliest season is because that is the first season in which the NFL introduced a 17-game season. Earlier seasons were 16-game seasons, and including those could potentially alter calculations.
- Player statistics were pulled for Passing, Rushing, Receiving, and Kicking stats. For Defense, the team defense statistics were pulled, as fantasy football scores defenses as a total team unit.
- Pro Football Reference allows for export of the statistics to comma-separated values, which were then pasted into a Microsoft Excel worksheet using the **Data > Text to Columns** feature.
	- The worksheets hold the statistical datasets for Passing, Rushing, Receiving, Defense, and Kicking, as these are the most relevant statistics for fantasy football purposes.
- I immediately inserted a new column for each statistic sheet noting the **Season** of either 2021 or 2022.

## Data Prep

### Data Cleaning
#### Observations
- Header abbreviations are difficult to understand. These will need to be updated to be more easily readable and referenced.
- There are many cells that are empty. However, I can't assume that these can be equated to a value of 0 since doing so can alter calculations going forward
- The `Rk` column doesn't hold any real value. On Pro Football Reference, this just refers to the rank number based on the sorted statistic, but I don't believe this will serve much of a purpose for my use case.
- Some players have the value `2TM` in the `Tm` column, which notes that they played for multiple teams during the season.
- Some players have extra symbols in the `Player` column to note that they were selected to the Pro Bowl or All-Pro teams. Currently, I don't believe this information will need to be used, but maybe I will add additional fields to note these achievements so that I can remove the symbols from those cells.
- The `QBrec` column has many cells that are being auto-formatted as dates.

#### Actions
- All worksheets
	- Removing `Rk` column from all worksheets
	- Use search and replace to remove any special characters in the `Player` columns
	- Updating all column names for every statistic to differentiate between one another
		- Every column name will be relevant for position. For Passing, `TD` will be renamed to `Pass TDs`
		- When relevant, names will be spelled out completely, i.e., `Tm` to `Team`
		- Updating `Player-additional` to `Player Key`
	- Removing all players who are NOT of the following positions: QB, RB, WR, TE, K, or Team Defense
	- Format all percentage statistics as percentages
	- Formatting all worksheets as Tables so that I can reference columns as named ranges
		- In Name Manager, I'm renaming each Table1, Table2, Table3, etc as the worksheet name for easier reference
	- For `Player Key` column in all worksheets, I will be updating the values to be the concatenation of the player's name and the season (i.e., "Aaron Rodgers 2021") in order to assist with data reference
- In Passing worksheet
	- Removing `QB Record` column - this stat does not seem relevant for fantasy football purposes as we only care about statistical performance, whereas QB record can be affected by other factors.
	- Removing `AY/A` column - for adjusted yards gained per pass attempt. I believe this statistic is redundant based on the values that the rest of the data set already has.
	- Removing `QBR` column - I am going to use the standard NFL quarterback rating metric as set in the original column of `Rate`.
	- Add Position values, if missing
	- Fix issue with QB Record showing as date values
- In Rushing worksheet
	- Add Position values, if missing. This is a manual process by searching the player and his position.
- In Receiving worksheet,
	- Add Position values, if missing. This can be accomplished partially by using a VLOOKUP function to search the player's name from the Rushing worksheet and populate any found player's position.
- In Kicking worksheet
	- Removing all Kickoff-related columns, as these are not scored in the standard system, and thus irrelevant.
	- For all blank values, rather than entering a 0, I am going to set those cells with a "-" value so that it will not affect any future calculations (averages)
- In Defense worksheet
	- Renaming Washington Football Team in 2021 to match updated name of Washington Commanders
	- Add `Position` column of DEF
- Creating new worksheet called **Players**, which will hold the list of all players and team information
	- Columns B:F (Player, Team, Age, Position) from the **2022** season is copied from each worksheet and pasted
	- Duplicates are removed with the Remove Duplicates feature
- Creating new worksheet called **Teams**, which will hold the common abbreviations for teams
	- The original abbreviations were slightly off the common abbreviations that may be seen from TV broadcasts, so I wanted to dynamically update all current abbreviations to their more commonly known ones.
		- Adding separate column in each worksheet and using VLOOKUP to populate new abbreviation based on old abbrevation, then commit new values

## Creating the Dashboard
- Create Player Selection
	- Use data validation as a list with the source being the `Player` column from **Players** worksheet (includes the `Defense` column for team defenses from the **Defense** worksheet)
	- Define name of *SelectedPlayer* to the player selection cell
- Add basic information for *SelectedPlayer* 's team, age, and position.
	- Define name of *Position* as *SelectedPlayer* 's position
- Add table of *SelectedPlayer* 's statistics that are relevant for fantasy football purposes.
	- Ideally, all statistics for a specific position would live in the relevant worksheet (i.e., all QB stats in the **Passing** worksheet), but QBs also have Rushing stats, and RBs have Receiving stats, so the selected statistic column headers will need to be more hard-coded rather than fully dynamic.
	- QBs
		- Pass Yards, Pass TDs, Pass Interceptions, Rush Yards, Rush TDs
	- RBs
		- Rush Yards, Rush TDs, Receptions, Receiving Yards, Receiving TDs, Fumbles
	- WRs/TEs
		- Receptions, Receiving Yards, Receiving TDs
	- Ks
		- FGM, XPM
	- DEF
		- Points Allowed, Pass TDs Allowed, Rush TDs Allowed, Takeaways
- Add two table columns to allow for custom selection of player's statistics
	- For now, this will be resigned to the SelectedPlayer's position
		- If SelectedPlayer is QB, the custom selections will only be for the Passing statistics
		- If SelectedPlayer is RB, the custom selections will only be for the Rushing statistics
	- **TODO:** Allow for this custom selector to be dynamic across multiple worksheets
- Calculate the average for other players in the league for each of the SelectedPlayer's statistics
	- On the initial passthrough, this average included every eligible player in the dataset, which skewed the results and may not have been a helpful metric to use.
		- Ex: There were many RBs who did not have much playing time and had minimal numbers for the statistical categories, which brought the average down
	- To counter this, I've added a custom entry box and a data-validated list selector of the current statistics so that the user of the dashboard can set a minimum numeric qualifier for a given statistic.
		- This lets the user compare the Selected Player's statistics to other players who are starter-level players, allowing for a more even comparison between statistics.
	- **TODO?:** Allow for a maximum qualifier?
- Add data visualization to display statistics for Selected Player as compared to League Average
	- For each statistic, compare the player's statistics vs. the league average, using column charts
- Add functionality to select fantasy football scoring system and display the Selected Player's fantasy football point totals
	- The scoring systems to be used are Standard, Half PPR, Full PPR (taken from Yahoo Sports fantasy football default scoring)
	- Create new tables to display the fantasy football point totals for each statistic, as well as for the league average
	- Create a bar chart displaying the Selected Player's fantasy football point totals as compared to the league average
	- Create a pie chart to display the ratio of fantasy football points for each of the player's statistical categories
