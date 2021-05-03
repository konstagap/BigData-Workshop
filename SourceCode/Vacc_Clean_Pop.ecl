
#WORKUNIT('NAME','Clean_Population');

IMPORT STD;
IMPORT ^.Layout.Vaccine_Recs; //^: Root acccess
IMPORT ^.Layout.Population_Recs;

//Filter so that we only have state population
statesOnlyDS := Population_Recs.PopDS_Raw (state <> '0');

//now transform to clean dataset ROLLUP state level population for all groups
//We just need location (aka state) and total population. Remeber the raw data is much more 
//granular and you need to summarize it at the state level. Hence, you use the ROLLUP pattern

statesGroupedDS := GROUP(SORT(statesOnlyDS, name), name);// GROUP the data by name

statesDS := ROLLUP(statesGroupedDS, GROUP, 
                   TRANSFORM(Population_Recs.PopRec_Clean, 
                             SELF.population := SUM(ROWS(LEFT), (REAL)POPEST2018_CIV) ,

                             // TODO: For location conver name to upper case and assign it
                             //SELF.location := Std.Str.ToUpperCase(LEFT.name)

                             SELF := []
                             ));

//NOTE: You could also accomplish this with a TABLE pattern but ROLLOUP is more approproate if you are applying 
//complex transformations


/*
OUTPUT(statesDS,,Population_Recs.PopPath_Clean,
   thor,compressed,overwrite,expire(10),named('state_population'));

*/

OUTPUT(statesDS, NAMED('state_population'));


