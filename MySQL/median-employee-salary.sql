# Time:  O(nlogn)
# Space: O(n)

select Id, Company, Salary from
(
select e.Id, e.Salary, e.Company,  if (@Prev = e.Company , @Rank := @Rank + 1, @Rank := 1) as Rank, @Prev := e.Company
from Employee e , (select @Rank := 0, @prev := 0) as Temp order by e.Company, e.Salary, e.Id
) Ranking
INNER JOIN
(
select count(*) as TotalCount, Company as Name from Employee e2 group by e2.Company
) CompanyCount
on CompanyCount.Name = Ranking.Company
where Rank = floor((TotalCount+1)/2) or Rank = floor((TotalCount+2)/2)
