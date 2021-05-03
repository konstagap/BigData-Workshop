
#WORKUNIT('NAME','Vacc_Analyze_Sol');



IMPORT STD;
IMPORT Layout.Vaccine_Recs;
IMPORT Layout.Metrics_Rec;
IMPORT Layout.Population_Recs;


//**********      PART ONE    ****************/


/* Based on the metrics layout design,
   we need to find out how many people are vaccinated 
   in a state, we can use the JOIN pattern 
 */

metrics_base := JOIN(Vaccine_Recs.Vac_DS_Clean,Population_Recs.PopDS_Clean, 
  LEFT.location=RIGHT.location
  ,TRANSFORM(Metrics_Rec.Metric_Rec,
             SELF.partially_vaccinated:= LEFT.total_vaccinations - LEFT.people_fully_vaccinated;
             SELF.fully_vaccinated := LEFT.people_fully_vaccinated;
             SELF.population_fully_vaccinated := ROUND(LEFT.people_fully_vaccinated * 100 / RIGHT.population, 3);
             SELF.population_partially_vaccinated := ROUND((LEFT.total_vaccinations - LEFT.people_fully_vaccinated) * 100 / RIGHT.population, 3);    
             SELF.population := RIGHT.population;
             SELF := LEFT),LEFT OUTER);

OUTPUT(metrics_base[..750],named('metrics_base')); //Output a sample to the workunit

             
//**********      PART TWO    ****************/


//A Simple Aggregate to calculate all the vaccinated people on a specific date

vacc_by_date := TABLE(metrics_base, 
                  {
                    date, 
                    REAL8 vaccinated_sum := SUM(GROUP, fully_vaccinated)
                  }, 
                  date);

OUTPUT(vacc_by_date,named('vacc_by_date'));             


//**************************************************************//
//**************     EXPLORE ON YOUR OWN     *******************//
//How can you find out the sum for a month in a year or week in a year? 
//NOTE of Caution: You are dealing with cumilative sums. 
//Hence, just summing within a month will not work    
//**************************************************************//
