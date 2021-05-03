
#WORKUNIT('NAME','Set_Math');

//Defining record layout
Layout_Person := RECORD
  UNSIGNED  personID;
  STRING15  firstName;
  STRING25  lastName;
  BOOLEAN   isEmployed;
  UNSIGNED  avgHouseIncome; 
  INTEGER   empGroupNum;
END;

//Inline dataset
empDS := DATASET([ {1102,'Fred','Smith', FALSE, 1000, 900},
                       {1102,'Fact','Smith', TRUE, 200000, 100},
                       {1012,'Joe','Blow', TRUE, 11250, 200},
                       {1085,'Blue','Moon', TRUE, 185000, 500},
                       {1055,'Silver','Jo', FALSE, 5000, 900},
                       {1265,'Darling','Jo', TRUE, 5000, 100},
                       {1265,'Blue','Silver', TRUE, 75000, 200},
                       {1333,'Jane','Smith', FALSE, 50000, 900},
                       {1023,'Alex','Donny',TRUE, 102000, 200},
                       {1024,'Nancy','Alp', TRUE, 201100, 700},
                       {1025,'Sunny', 'Alp', FALSE, 20055, 300},
                       {1025,'Jack', 'Smith', TRUE, 34455, 300},
                       {1025,'River', 'Blue', FALSE, 45667, 700},
                       {1025,'Math', 'Fun', TRUE, 21000, 200},                       
                       {1025,'Zack', 'Foo', FALSE, 87200, 600},                       
                       {1025,'Sarah', 'Cream', TRUE, 56000, 400},
                       {1025,'Mary', 'Foo', FALSE, 45500, 700},
                       {1025,'Dan', 'Jo', FALSE, 23500, 600},
                       {1025,'Nancy', 'Sunlight', TRUE, 90000, 800},
                       {1025,'Don', 'Sunlight', TRUE, 105000, 800},
                       {1333,'Funny','Joke', FALSE, 31450, 103}]
                        ,Layout_Person);

//Create a set of values containing following values
// 10000, 12000, 13000, 8000, 8500, 20055, 11250
lowerRange := [10000, 12000, 13000, 8000, 8500, 20055, 11250];

//TODO: Create a set of values containing following values
// 90000, 80000, 75000, 23500, 31450
//upperRange 

//Value called upperBand and assign 100000
upperBand := 100000;

//Value called lowerBand and assign 10000
lowerBand := 10000;

//Print all avgHouseIncome that falls between lowerRange and upperRange
midRangeIncome := empDS(avgHouseIncome BETWEEN lowerBand and upperBand);
OUTPUT(midRangeIncome, NAMED('midRangeIncome'));

//TOD: Print all avgHouseIncome that are not in lowerRange
//lowRangeIncome := 
//OUTPUT(lowRangeIncome, NAMED('lowRangeIncome'));

//TODO: Print all avgHouseIncome that are  in upperRange
// Call it upperRangeIncome
//OUTPUT(), 
//           NAMED('upperRangeIncome'));

//Print and count the members of Jo family
//Call ir JoFamily
OUTPUT(COUNT(empDS(lastName = 'Jo')),
                NAMED('JoFamily'));

//TODO: Calculate the average income of all employed people.
//Round result by 2 decimal points
//Name it: roundIt
/*
isEmp   := empDS(isEmployed);
*/

//TODO: Get max & min value of empGroupNum
//Print the result like following:
//Max Group Number:   , Min Group Num: 
//Mame it: Max_Min_GroupNum
