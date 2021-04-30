cars_layout := RECORD
      INTEGER  carID;
      INTEGER  price;
      STRING   brand;
      STRING   model;
      INTEGER  year;
      STRING   title_status;
      REAL     mileage;
      STRING   color;
      INTEGER  vin;
      INTEGER  lotNum;
      STRING   state;
      STRING   country;
      STRING   condition;
    END;

//Create dataset: file is a csv format
carsDS := DATASET('~usa::cars::csv', //File name
                             cars_layout,       // Record definition
                             CSV(HEADING(1))); //File type with indicator that row one is the header

//Output the first 200 rows
OUTPUT(CHOOSEN(carsds, 200));

//Starting from row 150, display the next 50 rows.
someRowTwo  := CHOOSEN(carsds,50, 150); 
OUTPUT(someRowTwo, NAMED('someRowTwo'));

//*****************************************************************
//Save and display all 2008 cars. 
year2008 := carsDS(year = 2008);
OUTPUT(year2008, NAMED('year2008'));

//Sort the result of the 2008 cars ascendingly by "Brand"
//Display the result
aceSort := SORT(year2008, brand);
OUTPUT(aceSort, NAMED('aceSort'));


//Filter out all 2008 cars with title_status "clean vehicle"
//Sort the result  descendingly  by model
cleanCars := carsDS(year = 2008 AND 
                    title_status = 'clean vehicle');
OUTPUT(SORT(cleanCars, -model), NAMED('cleanCars_Sorted'));


//Display all cars between price range of 10000 and 15000 that are made after 2018
getPrice := carsDS(price BETWEEN 10000 AND 
                    15000 AND
                    year > 2018);

OUTPUT(getPrice, NAMED('getPrice'));



