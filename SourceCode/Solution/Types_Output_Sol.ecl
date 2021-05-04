
#WORKUNIT('NAME','Types_Output_Sol');

//Define firstName that only takes 5 characters 
//TODO: Assign yourName to firstName
STRING5 firstName := '';


//TODO: Define lastName and assign a value to it
lastName := 'sunny world!';

//TODO: oncatenate firstName and lastName, save it to fullName
//Result should look like: Hello World
fullName := firstName + ' ' + lastName;

//print fullName
OUTPUT(fullName, NAMED('fullName'));

//define num1 as an INTEGER2 and assign 234 to it
num1 := 234;
       
//define num2 as an INTEGER and assign 345 to it
num2 := 345;

//type cast Num1 and num2 to STRING and then concatenate them. Save result to concatMe
concatMe := (STRING) num1 + (STRING) num2;

//display concatMe result
OUTPUT(concatMe, NAMED('concateMe'));
       

//What's the result of following with sum being the first operation to execute:
// 100 + 200 * 2
orderOfOper := (100 + 200) * 2;
OUTPUT(orderOfOper, NAMED('orderOfOper'));
