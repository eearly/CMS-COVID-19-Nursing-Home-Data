/*
- Data Split into Months
	- submitted_data = yes
	- passed_quality_assurance = yes
*/

select to_char(week_ending, 'YYYY-MM') as month_of_year
	, federal_provider_number
	, provider_name
	, provider_city
	, provider_state
	, number_of_all_beds as maximum_occupancy
from nursing_data
where submitted_data = 'Y'
AND passed_quality_assurance_check = 'Y'
group by to_char(week_ending, 'YYYY-MM')
	, federal_provider_number
	, provider_name
	, provider_city
	, provider_state
	, number_of_all_beds 

-- Avg. nursing home occupancy per month 

	select provider_name
		, to_char(week_ending, 'YYYY-MM') as month_of_year
		, round(avg(total_number_of_occupied_beds),2)  as avg_num_of_occupied_bed_per_month
	from nursing_data
	where submitted_data = 'Y'
	AND passed_quality_assurance_check = 'Y'
	group by provider_name, to_char(week_ending, 'YYYY-MM')


/*
- total confirmed patient cases of covid-19 over a year/ per month
- staff confirmed cases of covid-19 over a year/ per month
- total covid-19 resident deaths within the year/ per month 
*/
	
select provider_name
	, to_char(week_ending, 'YYYY-MM') as month_of_year
	, sum(residents_weekly_confirmed_covid19) as residents_confirmed_positive
	, sum(staff_weekly_confirmed_covid19) as staff_confirmed_positive
	, sum (residents_weekly_covid19_deaths) as resident_covid19_deaths
from nursing_data
where submitted_data = 'Y'
AND passed_quality_assurance_check = 'Y'
group by provider_name, to_char(week_ending, 'YYYY-MM')

/*	
- percentage of resident that are up-to-date with vaccinations
- percentage of staff that are up-to-date with vaccinations
*/
	
select provider_name
	, to_char(week_ending, 'YYYY-MM') as month_of_year
	, avg(percentage_of_current_healthcare_personnel_up_to_date_with_covi) as percent_staff_vaccinated
	, avg(percentage_of_current_residents_up_to_date_with_covid19_vac) as percent_resident_vaccinated
from nursing_data
where submitted_data = 'Y'
AND passed_quality_assurance_check = 'Y'
group by provider_name, to_char(week_ending, 'YYYY-MM')






