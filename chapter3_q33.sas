/*
The Rose Bowl is a college football tradition that dates back to the early 1900s. The raw data file
RoseBowl.dat contains records on the winning and losing teams during the Rose Bowl's history. The
variables in this file are game date, winning team, winning score, losing team, and losing score.
These data are sorted by winning team and then by date.
a. Examine the raw data file RoseBowl.dat and read it into SAS.
b. Create a variable that calculates the difference in points between the two teams.
c. Present the game date using a format that includes the day of the week.
d. Create a cumulative counter variable that tracks the total number of Rose Bowl games.
e. Create another cumulative counter variable that tracks the number of wins for each team.
f. View the resulting data set. In a comment in your program, state the values for the game date
and score difference of the first Rose Bowl won by Southern California.
*/
data rosebowl;
	infile "/folders/myfolders/sasuser.v94/RoseBowl.dat" truncover;
	input game_date date9.
winning_team $ 12-37 winning_score losing_team $ 41-66 losing_score 
		score_diff=winning_score-losing_score;
	FORMAT game_date WEEKDATE29.;
run;

proc sort data=rosebowl OUT=date_sort;
	by game_date winning_team;
run;

DATA number_games;
	SET date_sort;
	total_games + 1;
RUN;

PROC SORT DATA=number_games OUT=team_sort;
	BY winning_team game_date;
RUN;

DATA cumulative_team_wins;
	SET team_sort;
	BY winning_team;

	IF first.winning_team THEN
		total_wins=0;
	total_wins + 1;

	IF last.winning_team THEN
		total_wins=total_wins;
RUN;

PROC PRINT data=cumulative_team_wins;
RUN;