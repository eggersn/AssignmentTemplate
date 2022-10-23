# AssignmentTemplate
Latex assignment template with automated assignment creating, reducing the risk of merge conflicts.

This project is based on [spethso/Abgabentemplate](https://github.com/spethso/Abgabentemplate).

# Setup
Simply run
```
./initialize
```
You will be able to specify the project/assignment title and manage (i.e. add, modify, delete) authors. Afterwards, the file *config.txt* should be created containing the specified information. 

# Create New Assignment
After initial setup, you can run
```
./create_assignment
```
You will be able to specify the sheet number and the number of exercises. 

# Example
## Setup
```
$ ./initialize 
Manage your Repository
[0] Set Title [1] Manage Authors [2] Set Group [3] Exit
0
Set Title:
AwesomeProject
-----------------------------------------------------------
Manage your Repository
[0] Set Title [1] Manage Authors [2] Set Group [3] Exit
1
The following Authors are known:

[0] Add Author [1] Edit Author [2] Delete Author
0
Name:
MaxMustermann
Student Number:
1234567
-----------------------------------------------------------
Manage your Repository
[0] Set Title [1] Manage Authors [2] Set Group [3] Exit
3
Exiting...
```

## New Assignment
```
$ ./create_assignment 
Sheet Number:
1
Number of Exercises:
5
```
Then, the following folder structure will be created:
```
assignment_01/
├── exercise_01
│   └── ex_01.tex
├── exercise_02
│   └── ex_02.tex
├── exercise_03
│   └── ex_03.tex
├── exercise_04
│   └── ex_04.tex
├── exercise_05
│   └── ex_05.tex
└── main
    └── MaxMustermann_Assignment01.tex
```
