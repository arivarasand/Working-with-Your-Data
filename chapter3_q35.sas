/****************************************************************************************
The data in the file BenAndJerrys.dat represent various ice cream flavors and their nutritional
information. The variables are flavor name, portion size (g), calories, calories from fat, fat (g),
saturated fat (g), trans fat (g), cholesterol (mg), sodium (mg), total carbohydrate (g), dietary fiber
(g), sugars (g), protein (g), year introduced, year retired, content description, and notes.
a. Examine the raw data file BenAndJerrys.dat and read it into SAS.
b. Subset the data keeping only flavors that can be purchased at the grocery store (in other words
not retired flavors and not Scoop Shop Exclusives as described in the notes variable).
c. Create a variable that calculates the calories in one tablespoon (TB) of ice cream. Assume that 1
TB = 15 g. Subset the data again keeping only flavors that have this information.
d. Calculate the total calories you would consume if you were to eat one TB of each flavor of ice
cream. Your final total for this variable should appear in the row of the last observation.
e. Create a variable that identifies the highest number of calories in any one flavor. The result for
this variable will appear in the row of the last observation.
f. View the resulting data set. In a comment in your program, state the final values for total
calories consumed and the highest number of calories.
 ****************************************************************************************/
Data benadnjerrys;
	infile "/folders/myfolders/sasuser.v94/BenAndJerrys.dat" dlm=',' dsd truncover;
	INPUT flavor :$200. portion_size_g calories calories_fat fat_g saturated_fat_g 
		trans_fat_g cholesterol_mg sodium_mg carbs_g fiber_g $ sugar_g protein_g 
		introduced_year retired_year description :$200. notes :$200.;
run;

DATA icecream_current;
	SET benadnjerrys;

	IF (retired_year > .) THEN
		DELETE;

	IF (INDEX(notes, "Scoop Shop") > 0) THEN
		DELETE;
RUN;

DATA calories_tbs;
	SET icecream_current;
	Tbs_Per_Serving=portion_size_g / 15;
	calories_tbs=calories / Tbs_Per_Serving;

	IF calories_tbs=. THEN
		DELETE;
RUN;

DATA cumulative_sampling;
	SET calories_tbs;
	cumulative_calories + calories_tbs;
RUN;

DATA highest_calories;
	SET cumulative_sampling;
	RETAIN MaxCalories;
	MaxCalories=MAX(MaxCalories, calories);
RUN;