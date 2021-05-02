#WORKUNIT('NAME','Clean_Vaccine');


IMPORT Layout.Vaccine_Recs;
IMPORT STD;

/* 
   Convert the raw data from a raw.layout to public.layout 
   If you are converting every record in the dataset to another record in the new dataset, you
   will use the PROJECT function in ECL   
*/

OUTPUT(Vaccine_Recs.Vac_DS_Raw(location = 'New York State'),,NAMED('Raw_NY'));//Output sample clean to workunit output for debugging purposes


//Using STD functions to clean the dataset
cleanDS := PROJECT(Vaccine_Recs.Vac_DS_Raw, TRANSFORM(Vaccine_Recs.VacRec_Clean,
                                  SELF.Date := Std.Date.FromStringToDate(LEFT.Date, '%Y-%m-%d'),
                                  //TODO: convert New York State to NEW YORK else make it upper case
                                  //SELF.location:= 
                                  SELF := LEFT));

//OUTPUT(cleanDS,,NAMED('data_cleaned'));//Output sample clean to workunit output for debugging purposes
OUTPUT(cleanDS(location = 'NEW YORK'),,NAMED('data_cleaned_NY'));//Output sample clean to workunit output for debugging purposes



