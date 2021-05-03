
#WORKUNIT('NAME','Vacc_Clean');


IMPORT Layout.Vaccine_Recs;
IMPORT STD;



/************ PART ONE   ******************/


/* 
   Convert the raw data from a raw.layout to public.layout 
   If you are converting every record in the dataset to another record in the new dataset, you
   will use the PROJECT function in ECL   
*/

//Using STD functions to clean the dataset
cleanDS := PROJECT(Vaccine_Recs.Vac_DS_Raw, TRANSFORM(Vaccine_Recs.VacRec_Clean,

                                  //TODO: convert date to '%Y-%m-%d'
                                  //Replace your solution with []
                                  SELF.Date := [];
                                  SELF.location := IF(LEFT.location = 'New York State', 'NEW YORK', Std.Str.ToUpperCase(LEFT.location)),
                                  SELF := LEFT));

//OUTPUT(cleanDS,,NAMED('data_cleaned'));//Output sample clean to workunit output for debugging purposes
OUTPUT(cleanDS(location = 'NEW YORK'),, NAMED('data_cleaned_NY'));//Output sample clean to workunit output for debugging purposes



/************ PART TWO   ******************/

/* While this looks great, we still have a problem with. If you//////////////////////////////
   look at the data you can observe that we are getting daily staus of the
   vaccine rollout in many of the columns. For example, total_vaccinations is 
   total count of vaccinations that have been given until that date. 
   However, you can also see that for several days, the values are zero or blank. 
   This would be an incorrect status to report for that day. To overcome this issue,
   we will carry forward the non zero data from the previous time it was reported. 
   ECL has the perfect pattern for this and it is called as ITERATE */


fixNoDataDS := ITERATE(SORT(cleanDS, location, date), //Make sure it is sorted so that we have the correct adjacent record
                  TRANSFORM(Vaccine_Recs.VacRec_Clean, 

                           //TODO: If the current record and the next record have the same location and the value of the current record field is zero, replace the field value with the next records value
                           //SELF.total_vaccinations := IF (// Provide the if condition, LEFT.total_vaccinations, RIGHT.total_vaccinations),

                            SELF.total_distributed := IF (RIGHT.location = LEFT.location and RIGHT.total_distributed = 0, LEFT.total_distributed, RIGHT.total_distributed),
                            SELF.people_fully_vaccinated := IF (RIGHT.location=LEFT.location and RIGHT.people_fully_vaccinated  = 0, LEFT.people_fully_vaccinated , RIGHT.people_fully_vaccinated ),
                            //This SELF = RIGHT is super convinient. It copies every element as it is on the RIGHT other than the above
                            SELF := RIGHT
                            ));  

OUTPUT(fixNoDataDS,,NAMED('data_nodata_fix'));//Output no data fixed dataset to workunit output for debugging purposes                            

//Create the cleaned file
//NOTE: If this job is not run and the dataset is accessed via layouts.public.owid.ds, you will get an error that file does not exist

/*
OUTPUT(fixNoDataDS,,Vaccine_Recs.VacPath_Clean,
           THOR, COMPRESSED, OVERWRITE, EXPIRE(10),
           NAMED('vaccine_clean'));
*/

OUTPUT(fixNoDataDS, NAMED('vaccine_clean'));
