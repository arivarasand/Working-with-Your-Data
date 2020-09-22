/*A local company has recently updated human resources information on their employees from a
paper-based system into an actual database where the data can be manipulated and reviewed more
efficiently. The raw data file Employees.dat contains information on employees including a deidentified
Social Security number, name, date of birth, pay grade, monthly salary, and job title.
a. Examine the raw data file Employees.dat and read it into SAS.
b. Ensure that the date of birth is a readable date when viewed or printed rather than appearing
as a SAS date value.
c. Suppose that the company conducts their annual review in December. Calculate the age of each
employee as of the last day of the current year, and report it in years as a whole number.
d. Using the following information, create variables for the minimum and the maximum annual
pay that each employee can receive.
GradeMinimum Maximum
GR20 $50,000.00 $70,000.00
GR21 $55,000.00 $75,000.00
GR22 $60,000.00 $85,000.00
GR23 $70,000.00 $100,000.00
GR24 $80,000.00 $120,000.00
GR25 $100,000.00$150,000.00
GR26 $120,000.00$200,000.00
*/

data employees;
infile "/folders/myfolders/sasuser.v94/Employees.dat" truncover;
input ssn $ 1-11 name $ 16-46 dob DATE9. pay_grade $ monthly_salary DOLLAR10.2 job_title $ 73-99 ;
Age_At_Revew = INT(YRDIF(dob, TODAY(), "AGE"));

if pay_grade = "GR20" THEN DO;
	MinSalary = 50000.00;
	MaxSalary = 70000.00;
END;

else if pay_grade = "GR21" THEN DO;
	MinSalary = 55000.00;
	MaxSalary = 75000.00;
END;

else if pay_grade = "GR22" THEN DO;
	MinSalary = 60000.00;
	MaxSalary = 85000.00;
END;

else if pay_grade = "GR23" THEN DO;
	MinSalary = 70000.00;
	MaxSalary = 100000.00;
END;

else if pay_grade = "GR24" THEN DO;
	MinSalary = 80000.00;
	MaxSalary = 120000.00;
END;	

else if pay_grade = "GR25" THEN DO;
	MinSalary = 100000.00;
	MaxSalary = 150000.00;
END;	

else if pay_grade = "GR26" THEN DO;
	MinSalary = 120000.00;
	MaxSalary = 200000.00;
END;

ELSE DO
	MinSalary = .;
	MaxSalary = .;
END;

IF (monthly_salary * 12 * 1.025) > MaxSalary THEN 
	Expected_Salary = MaxSalary;
ELSE 
	Expected_Salary = (monthly_salary * 12 * 1.025);

* Give a $1000.00 bonus to leads, directors, and managers.;
IF FINDW(job_title, "Lead") THEN DO;
	Expected_Salary = Expected_Salary + 1000.00;
	Bonus = "Yes";
END;

ELSE IF FINDW(job_title, "Manager") THEN DO;
	Expected_Salary = Expected_Salary + 1000.00;
	Bonus = "Yes";
END;

ELSE IF FINDW(job_title, "Director") THEN DO;
	Expected_Salary = Expected_Salary + 1000.00;
	Bonus = "Yes";
END;
	
ELSE DO;
	Expected_Salary = Expected_Salary;
	Bonus = "No";
END;
	
FORMAT 
	dob DATE9.
	monthly_salary DOLLAR10.2
	MinSalary DOLLAR10.2
	MaxSalary DOLLAR10.2
	Expected_Salary DOLLAR10.2