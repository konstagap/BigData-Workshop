
#WORKUNIT('name', 'Sample Roxie');
IMPORT Layout.Vaccine_Recs;

// Create the query
_location := '' : STORED('location');
result := Vaccine_Recs.Vac_DS_Raw(location = _location);

OUTPUT(CHOOSEN(result, 100), NAMED('result'));

// Run this job on Roxie cluster.
// Once created the query, publish it via ECL Watch.
// The published query can be accessed via http://40.76.26.67:8002