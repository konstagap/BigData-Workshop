
EXPORT getCars := MODULE
		// Create a layout
    EXPORT cars_layout := RECORD
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

    //create dataset: file is a csv format
    EXPORT carsDS := DATASET('~usa::cars::csv', //File name
                             cars_layout,       // Record definition
                             CSV(HEADING(1))); //File type with indicator that row one is the header

END;
