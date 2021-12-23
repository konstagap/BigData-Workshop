EXPORT files := MODULE

    /*
        Get the data here:    
        https://www2.census.gov/programs-surveys/popest/tables/2010-2018/state/asrh/sc-est2018-agesex-civ.csv

        2.Upload the file to the landing zone of an HPCC cluster using ECL Watch
        3.Spray the data on cluster by using the delimited option with the following parameters
            scope=~hpccsystems::opendata::population::us::raw
            name=sc-est2018-agesex-civ.csv  
        Data dictionary: https://www2.census.gov/programs-surveys/popest/technical-documentation/file-layouts/2010-2018/sc-est2018-agesex-civ.pdf         
    */


    EXPORT rawPath := '~hpccsystems::opendata::population::us::raw::sc-est2018-agesex-civ.csv';  
                        

    EXPORT rawLayout := RECORD
        STRING SUMLEV; //Geographic Summary Level 
        STRING REGION; //Census Region code
        STRING DIVISION;//Census Division code 
        STRING STATE;//State FIPS code 
        STRING NAME;//State Name 
        STRING SEX;//Sex
        STRING AGE;//Age
        STRING ESTBASE2010_CIV;//4/1/2010 civilian population estimates base
        STRING POPEST2010_CIV;//7/1/2010 civilian population estimate
        STRING POPEST2011_CIV;//7/1/2011 civilian population estimate 
        STRING POPEST2012_CIV;//7/1/2012 civilian population estimate 
        STRING POPEST2013_CIV;//7/1/2013 civilian population estimate
        STRING POPEST2014_CIV;//7/1/2014 civilian population estimate 
        STRING POPEST2015_CIV;//7/1/2015 civilian population estimate 
        STRING POPEST2016_CIV;//7/1/2016 civilian population estimate
        STRING POPEST2017_CIV;//7/1/2017 civilian population estimate
        STRING POPEST2018_CIV;//7/1/2018 civilian population estimate
    END;



    EXPORT rawDS := DATASET(rawPath, rawLayout, CSV(HEADING(1)));  



    EXPORT statesFilePath := '~hpccsystems::opendata::population::us::clean::states_population.flat';
                       

    EXPORT statesFileLayout := RECORD
        STRING location;
        REAL population;
    END;

    EXPORT statesDS := DATASET(statesFilePath, statesFileLayout, THOR);  

END;

