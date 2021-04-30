
#WORKUNIT('NAME','ViewRaw_Covid_Files');

IMPORT $.Layout.Vaccine_Recs;
IMPORT $.Layout.Population_Recs;

//Display the first 250 rows
OUTPUT(Vaccine_Recs.Vac_DS_Raw, NAMED('Vaccine_RawFormat'));
OUTPUT(Population_Recs.PopDS_Raw, NAMED('Population_RawFormat'));