/*
A regional SAS conference will be held in a few weeks time. The raw data file Conference.dat
contains information about the registered attendees: first name, last name, attendee ID, business
phone, home phone, mobile phone, OK to contact attendee at business (Yes/No), OK to contact at
home (Yes/No), OK to contact at mobile (Yes/No), registration rate, will attend Wednesday mixer,
will attend Thursday lunch, whether willing to volunteer at the conference, and eating restrictions
(if any).
a. Examine the raw data file Conference.dat and read it into SAS.
b. Using the following registration rates, create a variable that groups attendees as Regular, Early,
or On-Site.
Academic Regular$350
Student Regular $200
Regular $450
Academic Early $295
Student Early $150
Early $395
On-Site $550
c. Create a variable that represents the participant's area code using the business phone number
first. If the business phone number is missing the area code, then use the mobile phone number.
If the mobile phone number is missing the area code, then use the home phone number.
30
d. The catering committee has already ordered food that does not contain nuts or shellfish, and all
meals are kosher, but they need to figure out how many attendees need the special vegetarian
or vegan meal. Create a variable that flags the attendees that require a vegan or vegetarian
meal as a 1, and as a 0 otherwise.
e. View the resulting data set. In a comment in your program, state the values for the registration
grouping, participant area code, and special meal flag for Tina Gonzales (attendee ID 1082) and
Patrick Anderson (attendee ID 1083).
*/
data Conference;
	infile "/folders/myfolders/sasuser.v94/Conference.dat" truncover;
	input first_name $
	last_name $
	attendee_id business_phone $ 47-59 home_phone $ 61-73 mobile_phone $ 75-87 
		ok_business $
	ok_home $
	ok_mobile $
	registration_rate wednesday_mixer $
	thursday_lunch $
	will_volunteer $
	dietary_restrictions $ 117-150;

	IF registration_rate=350 THEN
		attendee_type="Academic Regular";
	ELSE IF registration_rate=200 THEN
		attendee_type="Student Regular";
	ELSE IF registration_rate=450 THEN
		attendee_type="Regular";
	ELSE IF registration_rate=295 THEN
		attendee_type="Academic Early";
	ELSE IF registration_rate=150 THEN
		attendee_type="Student Early";
	ELSE IF registration_rate=395 THEN
		attendee_type="Early";
	ELSE IF registration_rate=550 THEN
		attendee_type="On-Site";
	ELSE
		attendee_type="Unknown";
	area_code=substr(business_phone, 2, 3);

	if missing(business_phone) then
		area_code=substr(home_phone, 2, 3);
	else
		area_code=substr(mobile_phone, 2, 3);

	if findw(dietary_restrictions, 'vegan') THEN
		vegan_veg_meal_flag=1;
	else if findw(dietary_restrictions, 'vegetarian') THEN
		vegan_veg_meal_flag=1;
	else
		vegan_veg_meal_flag=0;
run;

PROC PRINT data=conference;
	var registration_rate attendee_type area_code vegan_veg_meal_flag;
	WHERE attendee_id IN (1082, 1083);
RUN;