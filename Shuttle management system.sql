use Shuttle_Management_System;
select *from bus 

SELECT COUNT(*) as passengers
FROM Ticket
WHERE idroute = 14;

SELECT * FROM shuttle_management_system.bus where Capacity > 45;

SELECT bus.*, driver.license_number, person.first_name, person.last_name
FROM bus
JOIN driver ON bus.iddriver = driver.iddriver
JOIN person ON driver.idperson = person.idperson;

#To retrieve the details of the garages with the most buses assigned to them(Nested)
SELECT garage.name, garage.location, COUNT(*) as total_buses
FROM garage
JOIN bus ON garage.idgarage = bus.idgarage
GROUP BY garage.idgarage
HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM bus GROUP BY idgarage);


#Retrieve the details of the oldest bus and its driver (Correlated)
SELECT *
FROM bus b
JOIN driver d ON b.iddriver = d.iddriver
WHERE b.year = (
    SELECT MIN(year)
    FROM bus
) ;


#Retrieve the details of all buses and garages(Union)
SELECT idbus, capacity, iddriver, idgarage, make, model, year, NULL as location
FROM Bus
UNION
SELECT NULL as idbus, NULL as capacity, NULL as iddriver, idgarage, NULL as make, NULL as model, NULL as year, location
FROM Garage;


#Subquery in FROM clause to retrieve the details of all passengers who have bought a ticket for a certain route(Subquery in select and from)
SELECT p.idperson, p.first_name, p.last_name, p.email, p.phone_number
FROM person p
INNER JOIN (SELECT DISTINCT idpassenger FROM ticket WHERE idroute = '14') t ON p.idperson = t.idpassenger;


#average capacity of buses in each garage: (aggregate)
SELECT g.name, AVG(b.capacity) AS avg_capacity
FROM garage g
INNER JOIN bus b ON g.idgarage = b.idgarage
GROUP BY g.name
ORDER BY avg_capacity DESC;

