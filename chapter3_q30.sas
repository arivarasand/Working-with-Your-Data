/*******************************************************************************************
The new management of a local hotel decided to update their recently acquired (and very
outdated) property by installing wireless Internet service for their guests. They are also considering
updating their billing system because the method used by the previous owner seems faulty. In
order to conduct a billing analysis, they would like some calculations about the guests who stayed
with them during the first part of February (this was the first month after the change of ownership).
The raw data file Hotel.dat contains variables with information on room number, number of guests,
check-in month, day, year, check-out month, day, year, use of wireless Internet service, number of
days of Internet use, room type, and room rate.
a. Examine the raw data file Hotel.dat and read it into SAS.
b. Create date variables for the check-in and check-out dates, and format them to display as
readable dates.
c. Create a variable that calculates the subtotal as the room rate times the number of days in the
stay, plus a per person rate ($10 per day for each person beyond one guest), plus an Internet
service fee ($9.95 for a one-time activation and $4.95 per day of use).
d. Create a variable that calculates the grand total as the subtotal plus sales tax at 7.75%. The
result should be rounded to two decimal places.
********************************************************************************************/

data Hotel;
infile "/folders/myfolders/sasuser.v94/Hotel.dat" dlm=' ' truncover;
input room_number guests
check_in_month check_in_day check_in_year check_out_month check_out_day check_out_year wifi_service $ 42-47 no_days_wifi room_type $ 53-68  room_rate ;
check_in_date= input(catx('-',check_in_day,check_in_month,check_in_year),ddmmyy10.);
check_out_date= input(catx('-',check_out_day,check_out_month,check_out_year),ddmmyy10.);
no_days=check_out_date-check_in_date;
added_guest_fee = (guests - 1) * 10 * no_days;
internet_fee = 9.95 + (no_days_wifi * 4.95);
total_charges = sum(room_rate, added_guest_fee, internet_fee);
grand_total = total_charges + (total_charges * 0.075);
format check_in_date ddmmyy10. check_out_date ddmmyy10. total_charges dollar ;
run;
