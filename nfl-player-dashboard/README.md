# NFL Player Statistics for Fantasy Football

*Last Updated: July 30, 2023*

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

![image](https://github.com/thealexvu/portfolio/assets/12503011/41201b61-7c1a-490c-806e-2af3cacc4961)

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
	- Use data validation as a list with the source being the `Player` column from **Players** worksheet
	- Define name of *SelectedPlayer* to the player selection cell
