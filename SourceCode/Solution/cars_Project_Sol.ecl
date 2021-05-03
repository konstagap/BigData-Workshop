
#WORKUNIT('NAME','Cars_Project_Sol');


IMPORT $.getCars;

//For this practice we will be using getCars module.
//2- Define the dark colors using following:
//'gray', 'black', 'charcoal', 'brown', 'shadow black',  and 'super black'
//3- Define invalidColors as 'color:' and 'no_color'
//4- Create a new dataset containing following fields:
/*
STRING  name;
STRING  state;
BOOLEAN Old_Exp;
STRING  colorType;
*/
//5- Values should be defined as
/*
name: band + model
Old_Exp: IF price >= 10000 AND year <= 2012, then it's pricey
colorType: color is part invalidColors then 'Invalid Entry', part of darkColors then 'Dark', 
                            else is 'Light' color
*/
//6- Create the new dataset using standalone transform
//7- Create the new dataset using in-line transform 
//In 6 and 7 you are creating the result twice using two different style 
//8- Write two test cases for validations


           

//Set dark colors
darkColors := ['gray', 'black', 'charcoal',
               'brown', 'shadow black', 'super black'];

//Set invalid colors
invalidColors := ['color:', 'no_color'];

carsRec := RECORD
  STRING  name;
  STRING  state;
  BOOLEAN Old_Exp;
  STRING  colorType;
END;

carsRec xForm (getCars.cars_layout Le) := TRANSFORM
  SELF.name := Le.brand + ' ' + Le.model;
  SELF.Old_Exp := Le.price >= 10000 AND Le.year <= 2012;
  SELF.colorType := MAP(Le.color IN invalidColors => 'Invalid Entry', 
                            Le.color IN darkColors => 'Dark', 
                            'Light');
  SELF := Le;
END;

carsRes_Standalone := PROJECT(getCars.carsDS,
                   xForm(LEFT));

OUTPUT(carsRes_Standalone, NAMED('carsRes_Standalone'));

carsRes_Inline := PROJECT(getCars.carsDS,
                            TRANSFORM(carsRec,
                                SELF.name    := LEFT.brand + ' ' + LEFT.model;
                                SELF.Old_Exp := LEFT.price >= 10000 AND LEFT.year <= 2012;
                                SELF.colorType := MAP(LEFT.color IN invalidColors => 'Invalid Entry', 
                                        LEFT.color IN darkColors => 'Dark', 
                                        'Light');
                                SELF := LEFT;
                            ));

OUTPUT(carsRes_Inline, NAMED('carsRes_Inline'));