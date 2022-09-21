CREATE TABLE public.interest (
	id serial primary key,
	title varchar
);

-- POPULATE city, state, and country into LOCATION table
INSERT INTO public.location (city, state, country) 
VALUES ('Nashville', 'Tennessee', 'United States'), 
	('Memphis', 'Tennessee', 'United States'),
	('Phoenix', 'Arizona', 'United States'),
	('Denver', 'Colorado', 'United States');

-- POPULATE firstName, lastName, age, and location_id into PERSON table
INSERT INTO public.person ("firstName", "lastName", age, location_id) 
VALUES ('Chickie', 'Ourtic', '21', '1'),
	('Hilton', 'O''Hanley', '37', '1'),
	('Barbe', 'Purver', '50', '3'),
	('Reeta', 'Sammons', '34', '2'),
	('Abbott', 'Fisbburne', '49', '1'),
	('Winnie', 'Whines', '19', '4'),
	('Samantha', 'Leese', '35', '2'),
	('Edouard', 'Lorimer', '29', '1'),
	('Mattheus', 'Shaplin', '27', '3'),
	('Donnell', 'Corney', '25', '3'),
	('Wallis', 'Kauschke', '28', '3'),
	('Melva', 'Lanham', '20', '2'),
	('Amelina', 'McNirlan', '22', '4'),
	('Courtney', 'Holley', '22', '1'),
	('Sigismond', 'Vala', '21', '4'),
	('Jacquelynn', 'Halfacre', '24', '2'),
	('Alanna', 'Spino', '25', '3'),
	('Isa', 'Slight', '32', '1'),
	('Kakalina', 'Renne', '26', '3');

-- POPULATE title into INTEREST table
INSERT INTO public.interest (title) 
VALUES ('Programming'),
	('Gaming'),
	('Computers'),
	('Music'),
	('Movies'),
	('Cooking'),
	('Sports');
	
-- POPULATE person_id and interest_id into PERSON_INTEREST table
INSERT INTO public.person_interest (person_id, interest_id)
VALUES ('1', '1'),
	('1', '2'),
	('1', '6'),
	('2', '1'),
	('2', '7'),
	('2', '4'),
	('3', '1'),
	('3', '3'),
	('3', '4'),
	('4', '1'),
	('4', '2'),
	('4', '7'),
	('5', '6'),
	('5', '3'),
	('5', '4'),
	('6', '2'),
	('6', '7'),
	('7', '1'),
	('7', '3'),
	('8', '2'),
	('8', '4'),
	('9', '5'),
	('9', '6'),
	('10', '7'),
	('10', '5'),
	('11', '1'),
	('11', '2'),
	('11', '5'),
	('12', '1'),
	('12', '4'),
	('12', '5'),
	('13', '2'),
	('13', '3'),
	('13', '7'),
	('14', '2'),
	('14', '4'),
	('14', '6'),
	('15', '1'),
	('15', '5'),
	('15', '7'),
	('16', '2'),
	('16', '3'),
	('16', '4'),
	('17', '1'),
	('17', '3'),
	('17', '5'),
	('17', '7'),
	('18', '2'),
	('18', '4'),
	('18', '6'),
	('19', '1'),
	('19', '2'),
	('19', '3'),
	('19', '4'),
	('19', '5'),
	('19', '6'),
	('19', '7');



-- UPDATE PERSON table to update specific people's age by 1
SELECT * FROM public.person
ORDER BY id;

SELECT "firstName", "lastName"
FROM public.person
WHERE id IN (1, 4, 5, 6, 8, 12, 14, 18);

UPDATE public.person
SET age = age + 1
WHERE id IN (1, 4, 5, 6, 8, 12, 14, 18)
RETURNING *;



-- DELETE specific users info from all tables
DELETE FROM public.person_interest
WHERE person_id IN (2, 17);

DELETE FROM public.person
WHERE id IN (2, 17);

SELECT *
FROM public.person
ORDER BY id ASC;



-- SELECT firstName and lastName from person table
SELECT firstName, lastName
FROM public.person;


-- SELECT firstName and lastName of people who live in Nashville, TN
SELECT p.firstName, p.lastName, l.city, l.state
FROM public.person p
JOIN public.location l
ON l.id = p.location_id;


-- SELECT how many people live in each of the 4 cities
SELECT city, COUNT (p.id)
FROM public.location l
JOIN public.person p
ON p.location_id = l.id
GROUP BY city;


-- SELECT how many people are interested in each of the 7 interests
SELECT i.title, COUNT (p.id)
FROM public.interest i
JOIN public.person_interest pi
ON pi.interest_id = i.id
JOIN public.person p
ON p.id = pi.person_id
GROUP BY title;


-- SELECT all names of people who live in Nashville, TN and are interested in programming
SELECT p."firstName", p."lastName", l.city, l.state, i.title
FROM public.interest i
JOIN public.person_interest pi
ON pi.interest_id = i.id
JOIN public.person p
ON p.id = pi.person_id
JOIN public.location l
ON l.id = p.location_id
WHERE l.id = 1
AND i.title = 'Programming';


-- **BONUS** SELECT how many people are in the following age ranges: (20-30), (30-40), (40-50)
SELECT CASE 
WHEN p.age BETWEEN 20 and 30 THEN '20-30'
WHEN p.age BETWEEN 30 and 40 THEN '30-40'
WHEN p.age BETWEEN 40 and 50 THEN '40-50'
END AS "range",
COUNT (*)
FROM public.person p
GROUP BY "range"
ORDER BY "range";
