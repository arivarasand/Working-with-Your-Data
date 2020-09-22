/****************************************************************************************
A local gym runs a New Year’s membership offer that is available to anyone who joins the gym on
January 1st. The promotion states that if the new member continues to work out for at least 30
minutes a day for the first four months of the year, then they will have the $150 start-up fee
refunded. This year, 245 people signed up for the offer. Members were tracked automatically via
the computer check-in system when they arrived and left the gym. The raw data file NewYears.dat
contains variables for the member ID, and check-in times for the first 119 days of the year,
followed by the check-out times for the first 119 days of the year.
a. Examine the raw data file NewYears.dat and read it into SAS.
b. Create new variables for the time (in minutes) that the member spent at the gym each day.
c. Create a flag that identifies whether members are eligible for the refund. Members are eligible if
they worked out for at least 30 minutes a day for all 119 days.
d. Calculate the overall average time spent at the gym for each new member.
e. View the resulting data set. In a comment in your program, state the values for refund eligibility
and overall average time for members 330 and 331.
 ******************************************************************************************/
data new_year;
	infile "/folders/myfolders/sasuser.v94/NewYears.dat" dlm=',' truncover;
	input id (in1-in119 out1-out119) (:TIME8.);
	FORMAT in1-in119 TIME8. out1-out119 TIME8.;
RUN;

DATA visitlength (KEEP=id gym_visit1-gym_visit119);
	SET new_year;
	ARRAY in {119} in1-in119;
	ARRAY out {119} out1-out119;
	ARRAY diff {119} gym_visit1-gym_visit119;

	DO n=1 TO 119;

		IF out{n} > . THEN
			diff{n}=(out{n} - in{n}) / 60;
	END;
RUN;

DATA discount (KEEP=id Has_Discount Visits_Over_30_Min Mean_Duration);
	SET visitlength;
	Visits_Over_30_Min=0;
	Mean_Duration=MEAN(of gym_visit1-gym_visit119);
	ARRAY disc {119} gym_visit1-gym_visit119;

	DO i=1 to 119;

		IF disc{i} > 30 THEN
			Visits_Over_30_Min + 1;
	END;

	IF Visits_Over_30_Min=119 THEN
		Has_Discount=1;
	ELSE
		Has_Discount=0;
RUN;