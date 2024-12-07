-- Create the students table

CREATE TABLE students (

id SERIAL PRIMARY KEY, -- Unique ID for each student

name VARCHAR(50) NOT NULL -- Name of the student

);

-- Create the courses table

CREATE TABLE courses (

id SERIAL PRIMARY KEY, -- Unique ID for each course

name VARCHAR(100) NOT NULL -- Name of the course

);


-- Create the enrollments table

CREATE TABLE enrollments (

id SERIAL PRIMARY KEY, -- Unique ID for each enrollment record

student_id INT REFERENCES students(id), -- Foreign key linking to the students table

course_id INT REFERENCES courses(id) -- Foreign key linking to the courses table

);

-- Insert sample data into the students table

INSERT INTO students (name) VALUES

('Ali'),

('Sarah'),

('Ahmed'),

('Fatima');


-- Insert sample data into the courses table

INSERT INTO courses (name) VALUES

('Mathematics'),

('Physics'),

('Computer Science');


-- Insert sample data into the enrollments table

INSERT INTO enrollments (student_id, course_id) VALUES

(1, 1), -- Ali enrolled in Mathematics

(2, 1), -- Sarah enrolled in Mathematics

(3, 2), -- Ahmed enrolled in Physics

(4, 1), -- Fatima enrolled in Mathematics

(3, 3); -- Ahmed enrolled in Computer Science


-- Retrieve courses with more than one enrollment using a subquery

SELECT c.name, sub.enrollments

FROM courses c

JOIN (

-- Subquery to count the number of enrollments per course

SELECT course_id, COUNT(id) AS enrollments

FROM enrollments

GROUP BY course_id

) sub ON c.id = sub.course_id

WHERE sub.enrollments > 1; -- Filter to include only courses with more than one enrollment


-- Retrieve all courses with their enrollment counts (optional)

SELECT c.name, COUNT(e.id) AS enrollments

FROM courses c

LEFT JOIN enrollments e ON c.id = e.course_id

GROUP BY c.id; -- Group by course ID to calculate enrollments for each course


create view all_enrollments(StudentName , CourseName)
as 
select s.name , c.name
from students s join enrollments e on s.id= e.student_id join courses c on c.id = e. course_id


select *
from all_enrollments

create view Courses_NoEnrollmentd(coursename)
as
select c.name
from courses c left join enrollments e on c.id = e. course_id
where e. course_id is null


create view Students_Enrollments(StudentName , NumberOFEnrollments)
as 
select s.name , Count(e.id)
from students s left join enrollments e on s.id= e.student_id
group by s.name

select *
from Students_Enrollments

-- -- Create a view for popular courses with more than 2 enrollments
create view PopularCourses(CourseName , NumberOfEnrollments)
as 
select c.name , count(e.id)
from enrollments e right join courses c on c.id = e. course_id
group by c.name
having count(e.id)>2

drop view courses_with_more_than_2enrollment
drop view courses_without_enrollment
drop view number_of_enrolments_for_student