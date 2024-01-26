0. After login to openstack or OracleVM, just type
$ trc
1. Display the student relation
	{S.s#, S.sname, S.age | S in Student}; 
	{S.* | S in Student};
	Student;

2. List student name and age
	{S.sname, S.age | S in Student};

3. Find Johns age
	{S.age | S in Student and S.sname = 'John'}

4. List student name pairs for students with the same age
	{S1.sname, S2.sname | 
	 S1 in Student and S2 in Student and 
	 S1.age = S2.age};

5. List the student names and c# that students take.
	{S.sname, G.c# | S in Student and G in Grade and S.s#=G.s#};

6. List the student names for students taking courses.
	{S.sname | S in Student and (exists G in Grade )(S.s# =G.s#)};

7. List the student names for students not taking any course.
	{S.sname | S in Student and (forall G in Grade)(S.S# <> G.S#)};
	{S.sname | S in Student and not (exists G in Grade)(S.s# =G.s#)};

8. List the student names for students taking all courses.
	{S.sname | S in Student and (forall C in Course) (
	(exists G in Grade )(S.S# =G.S# and G.c#=C.c#))};
	{S.sname | S in Student and not (exists C in Course)
	(not (exists G in Grade )(S.s# =G.s# and G.c#=C.c#))};

9. Find students taking courses except AL
{	S.sname | S in Student and (exists C in Course)
          (C.cname = 'AL' and
          not (exists G in Grade)(S.S# = G.s# and C.c# = G.c#))};
			
10.Find students taking all courses except AL.
	{S.sname | S in Student and (forall C in Course)(
	(C.cname = 'AL' 
	not (exists G in Grade )(S.s# =G.s# and G.c#=C.c#)) 
	or
    (C.cname != 'AL' 
	(exists G in Grade)(S.s# =G.s# and G.c#=C.c#)))}
Not working

11.Find students taking all courses Kate takes 
	{S1.sname | S1 in student and S1.sname != 'Kate'  and
	(exists S in student)(S.sname = 'Kate' and
   (forall C in course) (
	(exists G in grade, G1 in grade)
	(S.S#=G.S# and G.C#=C.C# and S1.S#=G1.S# and G1.C#=C.C#)
	or	
	not (exists G in grade)(S.S#=G.S# and G.C#=C.C#)))}    
 Not working

12.Find students taking exactly the same courses that Kate takes
	{S1.sname | S1 in student and S1.sname != 'Kate' and
	(exists S in student)(S.sname = 'Kate' and
   (forall C in course)
	(exists G in grade, G1 in grade)
	(S.S#=G.S# and G.C#=C.C# and S1.S#=G1.S# and G1.C#=C.C#) or	
	not (exists G in grade, G1 in grade)
	(S.S#=G.S# and G.C#=C.C# and S1.S#=G1.S# and G1.C#=C.C#))}  
Not working

Aggregate Functions
1. Find the number of students
	{count(S.S#) | S in Student }; 
	{count(S.*)  | S in Student }; 

2. Find the highest mark in Grade
	{max(G.mark) | G in Grade }; 

3. Find the average mark in Grade
	{avg(G.mark) | G in Grade }; 

4. Find the number of students and their average ages
	{count(S.*), avg(S.age) | S in Student}; 

5. Find the student name and the number of courses the student takes
	{S.sname, count(G.c#) | 
	 S in student and G in grade and S.s# = G.s#};

6. Find student number and the number of course the student takes
	{G.s#, count(G.C#) | G in Grade };

7. Find the min, max and avg marks for CS305
	{min(G.mark), max(G.mark), avg(G.mark)| G in Grade and G.c# = 'CS305'};

8. Find the min, max and avg marks for DB course 
	{min(G.mark), max(G.mark), avg(G.mark) | 
		 G in Grade and (exist C in Course)(G.C# = C.C# and C.Cname = 'DB')};
	not working

9. Find the course name and the highest mark of the course
	{C.cname, max(G.mark)  | C in Course and G in Grade and C.c# = G.c# };

10.Find the names of students taking more than one course 
   {S.sname | S in Student and 
	(exists G1 in Grade, G2 in Grade)
	(S.S#=G1.S# and S.S#=G2.S# and G1.C# != G2.C#)}; 
	not working
   T :=  {S.sname, count(G.c#) as C | S in Student and 
		G in Grade 	and S.S# = G.S#}; 
  	{ S.sname | S in T and S.C > 1 };  
Temporary relation not working

11.For each student, find the numbers of students and the average marks ordered by their averages
	{G.s#,  avg(G.mark) | G in Grade} order by avg(G.mark)
	order by not working

12. Display student table and rename sname to name
    {S#, S.Sname as Name, Age | S in Student}
	rename not working

13. Set operations
	{S.* | S in S1 and S in S2};
	{S.* | S in S1 and S in S2};
	{S.* | S in S1 and not S in S2};
results are wrong

14.Times
	{S.*,C.*| S in Student and C in Course};

Additional Examples
1.	Find the names of students or courses (Temporary relations)
	T1 (name) := {X.sname | X in Student};
	T2 (name) := {X.cname | X in Course};
	{X.name | X in T1 or X in T2};

2. Find the names of courses that John and Kate both take.
	{C.cname | C in course and (
	(exists S1 in Student, G1 in Grade)(S1.sname= 'John' and
     S1.s#=G1.s# and C.c#=G1.c#) and
	(exists S2 in Student, G2 in Grade)(S2.sname= 'Kate' and
     S2.s#=G2.s# and C.c#=G2.c#)) };
	(exists S in Student, G in Grade)(S.sname= 'John' and
     S.s#=G.s# and C.c#=G.c#) and
	(exists S in Student, G in Grade)(S.sname= 'Kate' and
     S.s#=G.s# and C.c#=G.c#)) };

3. Find the names of courses that John or Kate takes.
	{C.cname | C in course and (
	(exists S1 in student, G1 in grade)(S1.sname= 'John' and
   S1.s#=G1.s# and C.c#=G1.c#) or
	(exists S2 in student, G2 in grade)(S2.sname= 'Kate' and
   S2.s#=G2.s#  and C.c#=G2.c#)) };
	(exists S1 in student, G in grade)(S1.sname= 'John' and
   S1.s#=G.s# and C.c#=G.c#) and
	(exists S2 in student, G in grade)(S2.sname= 'Kate' and
   S2.s#=G.s#  and C.c#=G.c#)) };

	{C.cname | C in course and (
	(exists S1 in student, G in grade)(S1.sname= 'John' and
   S1.s#=G.s# and C.c#=G.c#) and
	(exists S2 in student, G in grade)(S2.sname= 'Kate' and
   S2.s#=G.s#  and C.c#=G.c#)) };

4. Find the names of courses that John takes but Kate does not take
 	{C.cname | C in course and (
	(exists S1 in student, G1 in grade)(S1.sname= 'John'  and
   S1.s#=G1.s# and C.c#=G1.c#) and not
	(exists S2 in student, G2 in grade)(S2.sname= 'Kate'  and
   S2.s#=G2.s# and C.c#=G2.c#)) };

   (exists S in student, G in grade)(S.sname= 'John'  and
   S.s#=G.s# and C.c#=G.c#) and not
	(exists S in student, G in grade)(S.sname= 'Kate'  and
    S.s#=G.s# and C.c#=G.c#)) };

	{C.cname | C in course and (
 	(exists S in student, G in grade)(S.sname= 'John'  and
    S.s#=G.s# and C.c#=G.c#) and not
	(exists S in student, G in grade)(S.sname= 'Kate'  and
    S.s#=G.s# and C.c#=G.c#)) };















