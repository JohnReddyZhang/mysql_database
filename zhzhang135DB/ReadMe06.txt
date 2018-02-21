The data are in data folder, ending with "_large.txt"
But don't worry,
Populate_db_large will do the job itself loading all large datas
Relative path of all load files are saved in that file as "data/<file_name>"
Count has two queries, one is simple but generates APPROXIMATE count of each table
But it takes shorter time (only 3ms without "ANALYZE TABLE")
The other is longer, and is slower (83-ish ms)
But it generates Exact data.
