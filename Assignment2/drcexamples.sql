0. After login to openstack or OracleVM,just type
$ drc  
1.  Display the student relation
	{S, N, A | Student(S, N, A)}; 
	Student;

2.	Find student names and ages
	{N, A |(exists S)(Student(S, N, A))}; 

3. Find students taking the DB course
	{N | (exists S, C)(Student(S, N, _) and  
		 (Course(C, 'DB', _) and Grade(S,C,_)))};

4.  Get student name pairs for students with the same age
	{N1, N2 | (exists S1, S2, A) 
	(Student(S1,N1,A) and Student(S2, N2, A)  and N1!= N2);

5.	Get student name pairs for students with the same age
	{N1, N2 |(exists S1,S1)(Student(S1,N1,_) and Student(S2,N2,_))};

6.	Find Johns age
	{A | (exists S)(Student(S, 'John', A) };

7.	Find students taking courses.
	{N |(exists S,A,C,M)(Student(S,N,A) and Grade(S,C,M))};

8.	Find students not taking courses.
	{N | (exists S,A)(Student(S,N,A) and not (exists C,M)(Grade(S,C,M)))};
	{N | (exists S)(Student(S, N, _) and not Grade(S, _, _))};

9.	Find students taking all courses.
	{N | (exists S) (Student(S,N,_) and
		 (forall C)(not Course(C,_,_) or Grade(S,C,_)))}; 

11. Find students taking all courses except AL.
	{N | (exists S)(Student(S,N,_) and 
   (forall C)
   (not (exists M)(Course(C,M,_) and M != 'AL' or Grade(S,C,_)))
    or 
   (not (exists M)(Course(C,M,_) and M = 'AL' or not Grade(S,C,_))))};

12. Find students taking all courses that Kate takes
	 { N | (exists S1, S)(Student(S1,N,_) and N != ‘Kate’ and
          (Student(S, 'Kate',_) and 
	       (forall C)( not Grade(S,C,_)) or Grade(S1,C,_)))};


13. Find students taking the same courses that Kate takes
    { N | (exists S1, S)(Student(S1,N,_) and N != ‘Kate’ and
          (Student(S, 'Kate',_) and 
	       (forall C)
	       (not Grade(S,C,_) or Grade(S1,C,_)) and
	      （Grade(S,C,_) or not Grade(S1,C,_))};

1.	Find students older than 20
	{N |(exists A)(Student(_, N, A) and A > 20) };

2. Find student # for students with mark >= 80 
	{S | (exists M)(Grade(S,_,M) and M >= 80)};

3. Find all student name andcourse name combinations
	{SN, CN|(Student(_,SN,_) and Course(_,CN,_))};

4.	List student name and course name pairs such that the indicated student takes the indicated course
	{SN, CN|(exists S,C)(Student(S,SN,_) and Course(C,CN,_)
	 		  and Grade(S,C,_))};

5.	List student name, course name, and grade such that the indicated student takes the indicated course with the grade
	{SN, CN, G|(exists S,C)(Student(S,SN,_) and Course(C,CN,_)
	           and Grade(S,C,G))};

6.	List student name and course name pairs such that the indicated student does not take the indicated course
	{SN, CN |(exists S,C) (Student(S,SN,_) and Course(C,CN,_) 
		     and not (exists M)(Grade(S,C,M))};
	{SN, CN |(exists S,C) (Student(S,SN,_) and Course(C,CN,_) 
		     and not Grade(S,C,_))};

7.  Find students taking the CS305 course  
	{ N | (exists S)(Student(S, N,_) and Grade(S, 'CS305',_))};

8. Find students taking more than one course
	{ N | (exists S,C1,C2)(Student(S,N,_) and
         Grade(S,C1,_) and Grade(S,C2,_) and C1 != C2)};
	
9. Find students taking both DB and OS
   { N | (exists S,C1,C2)(Student(S,N,_) and
        Grade(S,C1,_) and Course(C1, 'DB', _) and
        Grade(S,C2,_) and Course(C2, 'OS', _))}

1.  List student number and the number of courses the student takes
	{S, count(*) | Grade(S, _, _) };
2. 	List student number and the average mark
	{S, avg(M) | Grade(S, _, M)};
3. 	List the min and max marks for all courses
	{min(M), max(M) | Grade(_, _, M)};
4. 	List the min and max marks for CS300
	{min(M), max(M) | Grade(_, 'CS300',M)};
5. 	List the min, max and avg marks for OS course 
	{min(M), max(M), avg(M)|(exists C)(Grade(_,C,M) 
		  and (Course(C, 'OS' ,_)}
6.  List the student and the number of courses  
	  the student takes
	{N, count(*)|(exists S)(student(S, N, _) and grade(S, _, _))};
7. 	List the course and the highest mark of the course
	{N, max(M) | (exists C)(Course(C, N, _) and Grade(_, C, M))}; 
8. 	List the location that have more than one course.
	T1(loc, c) := {L, count(*) | Course(_, _, L)};
	{L | T1(L, C) and C > 1 };
9.	List the student taking more than one course 
	T(sname, c) := {N, count(*)| (exists S)(Student(S, N, _) 
				      and Grade(S, C, _))};
	{ N |(exists C) (T(N, C) and C > 1)};
10. List the course with more than one student
	T(cname, c):= {N, count(*)|(exists C)(Course(C, N, _) and Grade(_, C, _)};
	{N | (exists C)(T(N, C) and C > 1)};
1.	List the Grade relation ordered by s# DESC and mark DESC
	{S, C, M | Grade(S, C, M)} order by S DESC, M ASC








