
#WORKUNIT('NAME','Vacc_Analyze');


IMPORT STD;
IMPORT Layout.Vaccine_Recs;
IMPORT Layout.Metrics_Rec;
IMPORT Layout.Population_Recs;

/* Based on the metrics layout design,
   we need to find out how many people are vaccinated 
   in a state, we can use the JOIN pattern 
 */

metrics_base := JOIN(Vaccine_Recs.Vac_DS_Clean,Population_Recs.PopDS_Clean, 
  LEFT.location=RIGHT.location
  ,TRANSFORM(Metrics_Rec.Metric_Rec,
            //TODO: partially_vaccinated is total_vaccinations - people_fully_vaccinated

            //TODO: fully_vaccinated gets the value of people_fully_vaccinated
            
             SELF.population_fully_vaccinated := ROUND(LEFT.people_fully_vaccinated * 100 / RIGHT.population, 3);
             SELF.population_partially_vaccinated := ROUND((LEFT.total_vaccinations - LEFT.people_fully_vaccinated) * 100 / RIGHT.population, 3);    
             SELF.population := RIGHT.population;
             SELF := LEFT;
             SELF := []),
             LEFT OUTER);

OUTPUT(metrics_base[..750],named('metrics_base')); //Output a sample to the workunit
             
    