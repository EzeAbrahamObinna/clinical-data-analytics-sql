select * from `admissionsz`;
select* from `d_icd_diagnosesz`;
select*from `diagnoses_icdz`;
select*from `patientsz`;

-- Show the number of patients by gender
select gender,count(subject_id) numberofpatients from `patientsz`
group by gender;

-- Count patients by age group
select case 
           when anchor_age< 30 then 'under 30'
           when anchor_age <40 then '30-49'
           when anchor_age<50 then '40-49'
           when anchor_age<60 then '50-59'
           when anchor_age<70 then '60-69'
           else '70+'
   End As agegroup,
   count(*) as patients from `patientsz`
   group by agegroup
   order by 
   case
when agegroup = 'under 30' then 1
           when agegroup='30-49'then 2
           when agegroup='40-49'then 3
           when agegroup = '50-59'then 4
           when agegroup ='60-69' then 5
        when agegroup ='70+' then 6
        end;
   
   -- Percentage of patients in each age group
   select case
           when anchor_age< 30 then 'under 30'
           when anchor_age <40 then '30-49'
           when anchor_age<50 then '40-49'
           when anchor_age<60 then '50-59'
           when anchor_age<70 then '60-69'
           when anchor_age>70 then '70+'
           end as agegroup,
           concat(round(count(*)*100.0/ (select count(*) from patientsz),2),'%') as percentageAge
           from `patientsz`
           group by agegroup
           