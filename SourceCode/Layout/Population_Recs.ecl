EXPORT Population_Recs := MODULE

    /*
        Get the data here:    
        https://www2.census.gov/programs-surveys/popest/tables/2010-2018/state/asrh/sc-est2018-agesex-civ.csv

        2.Upload the file to the landing zone of an HPCC cluster using ECL Watch
        3.Spray the data on cluster by using the delimited option with the following parameters
                scope=~univ::covid19::file::raw::census
                name=us_state_population.csv     

        Data dictionary: https://www2.census.gov/programs-surveys/popest/technical-documentation/file-layouts/2010-2018/sc-est2018-agesex-civ.pdf         
    */


    EXPORT PopPath_Raw := '~univ::covid19::file::raw::census::sc-est2018-agesex-civ.csv';  
                        

    EXPORT PopRec_Raw := RECORD
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

    /*

            The key for SUMLEV is as follows:
            010 = Nation
            040 = State and/or Statistical Equivalent

            The key for REGION is as follows:
            0 = United States Total
            1 = Northeast
            2 = Midwest
            3 = South
            4 = West
            
            The key for DIVISION code is as follows:
            0 = United States Total
            1 = New England
            2 = Middle Atlantic
            3 = East North Central
            4 = West North Central
            5 = South Atlantic
            6 = East South Central
            7 = West South Central
            8 = Mountain
            9 = Pacific

            The key for SEX is as follows:
            0 = Total
            1 = Male
            2 = Female

            AGE is single-year of age (0, 1, 2, ...84, 85+ years) and 999 is used to indicate total population.


    */


    EXPORT PopDS_Raw := DATASET(PopPath_Raw, PopRec_Raw, CSV(HEADING(1)));  

    //**************************************************
    // Population clean format

    EXPORT PopPath_Clean := '~univ::covid19::file::public::census::us_states_population.flat';
                       

    EXPORT PopRec_Clean := RECORD
        STRING location;
        REAL population;
    END;

    EXPORT PopDS_Clean := DATASET(PopPath_Clean, PopRec_Clean, THOR);  

END;

