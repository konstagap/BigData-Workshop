IMPORT STD;

EXPORT Metrics_Rec := MODULE
    
    /* Here we design what we think would be the most useful 
       metrics. % of population vaccinated, people_vaccinated, how effective the state government 
       w.r.t vaccinations?, is there a realtion between cases and vaccinations?....  
     */  
    EXPORT Metric_Rec := RECORD
       STD.Date.Date_t date;
       STRING location;
       REAL partially_vaccinated;
       REAL fully_vaccinated;
       REAL population_fully_vaccinated;  
       REAL population_partially_vaccinated;    
       REAL population;    
    END;

END;
