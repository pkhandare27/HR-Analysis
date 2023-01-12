use project_group5;
show tables;
select * from hr1;
select * from hr2;

/* Date Of Joining */
/* Unable to create a proper date column from the year, month and date columns because of the inbuilt function (MAKEDATE) available in My SQL permits 
to pass only the year and date as arguments in the function */
select employeeid, makedate(yearofjoining,dayofjoining) from hr2;     

/* A. Year: Unable to extract the Year from the date of joining since a proper date column could not be created */

/* B. Month Number: Unable to extract the Month Number from the date of joining since a proper date column could not be created */

/* C. Month Name: Unable to extract the Month Name from the date of joining since a proper date column could not be created */

/*D. Quarter: Unable to extract the Quarter from the date of joining since a proper date column could not be created */

/*E. YearMonth (YYYY-MMM) Unable to extract the date in the required format since a proper date column (for date of joining) could not be created */
select employeeid, yearofjoining, monthofjoining, concat(yearofjoining,"-",monthofjoining) from hr2;

/* 1. Average Attrition rate for all Departments */
select department as Department, count(attrition)*100/50000 as Attrition_Rate from hr1 join hr2 
	on employeenumber=employeeid 
		where attrition="Yes" 
			group by department;

/* 2. Average Hourly rate of Male Research Scientist */
select avg(hourlyrate) from hr1 join hr2 
	on employeenumber=employeeid
		where gender="Male" and jobrole="Research Scientist";
        
/* 3. Attrition rate Vs Monthly income stats */

SET GLOBAL log_bin_trust_function_creators = 1; /* HAD TO USE THIS TO MITIGATE ERROR CODE 1148 WHILE CREATING A FUNCTION*/
/*Unable to use the function created for identifying the income bucket in the query*/
select employeeid, monthlyincome, income_bucket(monthlyincome) from hr2;

select income_bucket(monthlyincome), count(attrition)*100/50000 from hr1 join hr2
	on employeenumber-employeeid
		where attrition="Yes"
			group by income_bucket(monthlyincome)
				limit 10;

/* 4. Average working years for each Department */
select department as Department, avg(yearsatcompany) as Average_Years_Worked from hr1 join hr2 
	on employeenumber=employeeid
		group by department;
        
/* 5. Departmentwise No of Employees */
select department as Department, count(employeecount) as Employee_Count from hr1 join hr2 
	on employeenumber=employeeid
		group by department;

/* 6. Count of Employees based on Educational Fields */
select educationfield as Education_Field, count(employeecount) as Employee_Count from hr1 join hr2 
	on employeenumber=employeeid
		group by educationfield;
        
/* 7. Job Role Vs Work life balance */
select jobrole as Job_Role, avg(worklifebalance) as Average_Worklife_Balance from hr1 join hr2
	on employeenumber=employeeid
		group by jobrole;
        
/* 8. Attrition rate Vs Year since last promotion relation */
select yearssincelastpromotion as Years_Since_Last_Promotion, count(attrition)*100/50000 as Attrition_Rate from hr1 join hr2
	on employeenumber=employeeid
		where attrition="Yes"
			group by yearssincelastpromotion
				order by yearssincelastpromotion;
                
/* 9. Gender based Percentage of Employee */
select gender as Gender, count(employeecount)*100/50000 as Employee_Count_Percentage from hr1 group by gender;

/* 10. Monthly New Hire vs Attrition Trendline */


/* 11. Deptarment / Job Role wise job satisfaction */
select department as Department, avg(jobsatisfaction) as Average_Job_Satisfaction from hr1 join hr2
	on employeenumber=employeeid
		group by department
			order by avg(jobsatisfaction) desc;
            
select jobrole as Job_Role, avg(jobsatisfaction) as Average_Job_Satisfaction from hr1 join hr2
	on employeenumber=employeeid
		group by jobrole
			order by avg(jobsatisfaction) desc;