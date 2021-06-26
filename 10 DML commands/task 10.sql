CREATE TABLE locations2 AS 
    (SELECT * FROM locations WHERE 1=2);

INSERT INTO locations2 
(location_id, street_address, city, country_id)
(select location_id, street_address, city, country_id from locations where country_id = 'IT');

select * from locations2;

commit;

INSERT INTO locations2
VALUES (1200, '23423 Eifeleva le Bashnya', 12421, initcap('paris'), (null), upper('FR'));
INSERT INTO locations2
VALUES (1300, '2352 Gotham City', 31415, initcap('Shampan'), (null), upper('FR'));

commit;

INSERT INTO LOCATIONS2
(SELECT * FROM LOCATIONS WHERE LENGTH(STATE_PROVINCE) > 9);

commit;

CREATE TABLE locations4europe AS (SELECT * FROM locations WHERE 1=2); 

INSERT ALL
WHEN 1=1 THEN
INTO LOCATIONS2 VALUES (location_id, street_address, postal_code, city, state_province, country_id)
WHEN REGION_ID = 1 THEN
INTO LOCATIONS4EUROPE VALUES (location_id, street_address, postal_code, city, state_province, country_id)
(SELECT location_id, street_address, postal_code, city, state_province, l.country_id, c.region_id
FROM locations l join countries c on (l.country_id = c.country_id));
-- Нет сил переписать, но он в решении не джойнил, а использовал subquery 
-- во втором When

select * from locations2;
select * from locations4europe;

commit;

update locations2
set
postal_code = 24590
where postal_code is null;

rollback;

update locations2
set
postal_code = (select postal_code from locations where location_id = 2600)
where postal_code is null;

commit;

delete from locations2
where country_id = 'IT';

savepoint s1;

update locations2
set
street_address = 'Sezam st. 18'
where location_id > 2500;

savepoint s2;

delete from locations2
where street_address = 'Sezam st. 18';

rollback to savepoint s1;

commit;