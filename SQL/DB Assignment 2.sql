1.	How many films does NetFilms offer?

select count(id) as 'Number of Films offered by NetFilms ' from film;

   1 Row Returned

2.	List all films of genre ‘Documentary’  

select Title from film inner join Genre on film.Genre=Genre.id where name='Documentary';

 362 Rows Returned

3. How many films in our list were released during the 1990s?

select count(ID) as 'Number of films' from Film where ReleaseYear>=1990 and ReleaseYear<2000;

  1 Row Returned

4. List all of our R-rated comedy films. Show the title and year of release of each film, and order by title.
select Film.Title,Film.ReleaseYear from Film inner join Genre on Film.Genre=Genre.Id where Genre.name='Comedy' and Film.Classification='R'order by Title;

 334 Rows Returned

5. List all films directed by Steven Spielberg

select Film.Id,Film.Title from Film where Id in 
(select Film from Production where 
exists(select * from Role where Production.Role=Role.Id and Name='Director')
and exists
(select*from CastAndCrew where CastAndCrew.Id=Production.CastAndCrew and FirstName='Steven' and LastName='Spielberg'));

 16 Rows Returned

6. List all of the directors and how many films each has made.

select FirstName, LastName,count(*) as 'Number of Directing Films' from Production inner join Role inner join CastAndCrew on Role.Id=Production.Role and Production.CastAndCrew=CastAndCrew.Id where Role.Name='Director'group by CastAndCrew.Id order by count(*) DESC;

  2460 Rows Returned

7. Who has acted in the most films?

select FirstName,LastName,count(*) as 'Number of Acting Films' from Production inner join CastAndCrew inner join Role on Production.Role=Role.Id and Production.CastAndCrew=CastAndCrew.Id where Role.Name='Actor' group by CastAndCrew.Id order by count(*) DESC limit 1;

  1 Row Returned

8. Which are the 5 most-watched films?

select Film.Id,Film.Title, count(*) as 'WatchedTimes' from Watch inner join Film on Watch.Film=Film.Id group by Watch.Film order by count(*) DESC limit 5;

 5 Rows Returned

9. Which customers have not viewed any films yet

select FirstName,LastName from Customer where Customer.Id not in (select Customer from Watch);

 14 Rows Returned

10. On which day of the week do most people watch films? 

select DayName(WhenViewed) as 'Day of Week',count(*) as 'Number of Watching People' from Watch group by DayName(WhenViewed) order by count(*) DESC limit 1;

 1 Row Returned

11. How many different films have been watched by customers in post code 3053? 

select count(distinct film) as 'Number of Films Watched by Customers in 3053' from Watch inner join Customer on Watch.Customer=Customer.Id and Postcode=3053;

 1 Row Returned

12. List the top 8 films as ranked by our customers. For each, show the title, and average rank, and order the list by rank. Only include films that have been ranked by at least 5 customers. 

select Film.Title,AVG(Rating) as AverageRank from Film inner join Watch on Watch.Film=Film.Id group by Watch.Film having count(distinct Customer)>=5 order by AVG(Rating) DESC limit 8;

 8 Rows Returned

13. Which films has customer Steven Kloves watched? List the films along with how many times he has watched them.

select Film.Id, Film.Title,count(*) as WatchTimes from Film inner join Watch inner join Customer on Watch.Film=Film.Id  and Customer.Id=Watch.Customer where Customer.FirstName='Steven' and Customer.LastName='Kloves' group by Watch.Film order by WatchTimes DESC;

 24 Rows Returned

14. Which genres of films have been watched the most in postcode 3053? List the top 3 genres for that postcode.

select Genre.Name,count(*) as WatchedTimes from Watch inner join Film inner join Customer inner join Genre on Watch.Film=Film.Id and Watch.Customer=Customer.Id and Film.Genre=Genre.Id where Postcode=3053 group by Genre.Name order by count(*) DESC limit 3;

  3 Rows Returned

15. Which films are making a profit for NetFilms?(Profit is the net takings from viewings minus the wholesale cost of the film.) 

select Film.Id, Film.Title,(PricePerView*count(*)-CostWholesale) as Profit from Watch inner join Film on Watch.Film=Film.Id group by Watch.Film having profit>0 order by Profit DESC;


 46 Rows Returned
