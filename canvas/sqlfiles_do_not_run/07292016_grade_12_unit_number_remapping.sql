--Grade 12 unit remapping

begin transaction;

--Unit 5 (24) to unit 2 (13)
update canvas_unit_info
set unit_number = 2
where id = 24;

--Unit 2 (13) to unit 3 (16)
update canvas_unit_info
set unit_number = 3
where id = 13;

--Unit 3 (16) to unit 4 (15)
update canvas_unit_info
set unit_number = 4
where id = 16;

--Unit 4 (15) to unit 5 (24)
update canvas_unit_info
set unit_number = 5
where id = 15;

/*
select * from canvas_curriculum where grade_id = 4 and unit_id = 24
select * from canvas_curriculum where grade_id = 4 and unit_id = 13 and id not in (95, 100, 101)
select * from canvas_curriculum where grade_id = 4 and unit_id = 16 and id not in (28, 31, 32, 33)
select * from canvas_curriculum where grade_id = 4 and unit_id = 15 and id not in (63, 79, 80)
*/