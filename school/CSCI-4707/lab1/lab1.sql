-- Russell Bunch Lab 1 4707 Fall 2014

-- 1
CREATE TABLE STUDENT 
(
    SID INTEGER DEFAULT 0 NOT NULL,
    STUDENT_NAME VARCHAR(20) NOT NULL,
    MAJOR VARCHAR(50),
    GRADE_YEAR CHAR(2),
    AGE INTEGER NOT NULL,
    PRIMARY KEY (SID) ENABLE
);

CREATE TABLE ENROLLED 
(
    SID INTEGER NOT NULL,
    CLASS_NAME VARCHAR(50) NOT NULL,
    PRIMARY KEY (CLASS_NAME, SID) ENABLE,
    FOREIGN KEY (SID) REFERENCES STUDENT(SID) ON DELETE CASCADE ENABLE,
    FOREIGN KEY (CLASS_NAME) REFERENCES CLASS(CLASS_NAME) ENABLE 
);

-- 2
CREATE TABLE CLASS 
(
    CLASS_NAME VARCHAR(50) NOT NULL,
    CLASS_TIME VARCHAR(50),
    ROOM VARCHAR(10),
    PRIMARY KEY (CLASS_NAME) ENABLE,
    UNIQUE (CLASS_TIME, ROOM) ENABLE
);

-- 3
CREATE TABLE ENROLLED 
(
    SID INTEGER NOT NULL,
    CLASS_NAME VARCHAR(50) NOT NULL,
    PRIMARY KEY (CLASS_NAME, SID) ENABLE,
    FOREIGN KEY (SID) REFERENCES STUDENT(SID) ON DELETE CASCADE ENABLE,
    FOREIGN KEY (CLASS_NAME) REFERENCES CLASS(CLASS_NAME) ENABLE 
);


-- 4
INSERT ALL
INTO STUDENT (SID, STUDENT_NAME, MAJOR, GRADE_YEAR, AGE) VALUES
    (051135593, 'Maria White', 'English', 'SR', 21)
INTO STUDENT (SID, STUDENT_NAME, MAJOR, GRADE_YEAR, AGE) VALUES
    (060839453, 'Charles Harris', 'Architecture', 'SR', 22)
INTO STUDENT (SID, STUDENT_NAME, MAJOR, GRADE_YEAR, AGE) VALUES
    (099354543, 'Susan Martin', 'Law', 'JR', 20)
INTO STUDENT (SID, STUDENT_NAME, MAJOR, GRADE_YEAR, AGE) VALUES
    (112348546, 'Joseph Thompson', 'Computer Science', 'SO', 19)
INTO STUDENT (SID, STUDENT_NAME, MAJOR, GRADE_YEAR, AGE) VALUES
    (115987938, 'Christopher Garcia', 'Computer Science', 'JR', 20)
INTO STUDENT (SID, STUDENT_NAME, MAJOR, GRADE_YEAR, AGE) VALUES
    (132977562, 'Angela Martinez', 'History', 'SR', 20)
INTO STUDENT (SID, STUDENT_NAME, MAJOR, GRADE_YEAR, AGE) VALUES
    (269734834, 'Thomas Robinson', 'Psychology', 'SO', 18)
INTO STUDENT (SID, STUDENT_NAME, MAJOR, GRADE_YEAR, AGE) VALUES
    (280158572, 'Margaret Clark', 'Animal Science', 'FR', 18)
SELECT * FROM dual;

-- 5
INSERT ALL
INTO CLASS (CLASS_NAME, CLASS_TIME, ROOM) VALUES
    ('Data Structures', 'MWF 10:00-11:00', 'R128')
INTO CLASS (CLASS_NAME, CLASS_TIME, ROOM) VALUES
    ('Database Systems', 'MWF 12:30-1:45', '1320 DCL')
INTO CLASS (CLASS_NAME, CLASS_TIME, ROOM) VALUES
    ('Operating System Design', 'TuTh 12-1:20', '20 AVW')
INTO CLASS (CLASS_NAME, CLASS_TIME, ROOM) VALUES
    ('Archaeology of the Incas', 'MWF 3-4:15', 'R128')
SELECT * FROM dual;

-- 6
INSERT ALL
INTO ENROLLED (SID, CLASS_NAME) VALUES
    (051135593, 'Data Structures')
INTO ENROLLED (SID, CLASS_NAME) VALUES
    (060839453, 'Data Structures')
INTO ENROLLED (SID, CLASS_NAME) VALUES
    (051135593, 'Database Systems')
INTO ENROLLED (SID, CLASS_NAME) VALUES
    (060839453, 'Database Systems')
INTO ENROLLED (SID, CLASS_NAME) VALUES
    (051135593, 'Operating System Design')
INTO ENROLLED (SID, CLASS_NAME) VALUES
    (099354543, 'Operating System Design')
INTO ENROLLED (SID, CLASS_NAME) VALUES
    (112348546, 'Operating System Design')
SELECT * FROM dual;

 -- 7
INSERT INTO STUDENT (SID, STUDENT_NAME, MAJOR, GRADE_YEAR, AGE) VALUES
    (112348546, 'Juan Rodriguez', 'Psychology', 'JR', 20)
;

-- 8
INSERT INTO CLASS (CLASS_NAME, CLASS_TIME, ROOM) VALUES
    ('Algorithms', 'MWF 12:30-1:45', '1320 DCl')
;

-- 9
INSERT INTO ENROLLED (SID, CLASS_NAME) VALUES
    (561254634, 'Data Structures')
;
INSERT INTO ENROLLED (SID, CLASS_NAME) VALUES
    (051135593, 'Communication Networks')
;

-- 10

-- Shows records befor
SELECT * FROM CLASS;

DELETE FROM CLASS
WHERE CLASS_NAME='Data Structures'
;
-- Shows records after
SELECT * FROM CLASS;


-- 11

-- Shows records before
SELECT * FROM ENROLLED;

DELETE FROM STUDENT
WHERE SID=051135593
;
-- Shows records after
SELECT * FROM ENROLLED;

-- 12
drop table enrolled;
drop table class;
drop table student;