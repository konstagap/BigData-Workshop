IMPORT STD;

EXPORT Vaccine_Recs := MODULE
    
    /*
        1.Get the data here
          https://github.com/owid/covid-19-data/blob/master/public/data/vaccinations/us_state_vaccinations.csv
        2.Upload the file to the landing zone of an HPCC cluster using ECL Watch
        3.Spray the data on cluster by using the delimited option with the following parameters
            scope=~univ::covid19::file::raw::owid
            name=us_state_vaccinations.csv     
    */

    EXPORT VacPath_Raw := '~univ::covid19::file::raw::owid::us_state_vaccinations.csv';
    
    EXPORT VacRec_Raw := RECORD
        STRING date;
        STRING location;
        UNSIGNED4 total_vaccinations;
        UNSIGNED4 total_distributed;
        UNSIGNED4 people_vaccinated;
        DECIMAL people_fully_vaccinated_per_hundred;
        DECIMAL total_vaccinations_per_hundred;
        UNSIGNED4 people_fully_vaccinated;
        DECIMAL people_vaccinated_per_hundred;
        DECIMAL distributed_per_hundred;
        UNSIGNED4 daily_vaccinations_raw;
        UNSIGNED4 daily_vaccinations;
        DECIMAL daily_vaccinations_per_million;
        DECIMAL share_doses_used;
    END;

    EXPORT Vac_DS_Raw := DATASET(VacPath_Raw, VacRec_Raw, CSV(HEADING(1)));

    //**************************************************************
    //** Clean Format

    EXPORT VacPath_Clean := '~univ::covid19::file::public::owid::us_states_vaccinations.flat';

    EXPORT VacRec_Clean := RECORD
        STD.Date.Date_t date;
        STRING location;
        UNSIGNED4 total_vaccinations;
        UNSIGNED4 total_distributed;
        UNSIGNED4 people_vaccinated;
        DECIMAL people_fully_vaccinated_per_hundred;
        DECIMAL total_vaccinations_per_hundred;
        UNSIGNED4 people_fully_vaccinated;
        DECIMAL people_vaccinated_per_hundred;
        DECIMAL distributed_per_hundred;
        UNSIGNED4 daily_vaccinations_raw;
        UNSIGNED4 daily_vaccinations;
        DECIMAL daily_vaccinations_per_million;
        DECIMAL share_doses_used;
    END;


    EXPORT Vac_DS_Clean := DATASET(VacPath_Clean, VacRec_Clean, flat);


END;