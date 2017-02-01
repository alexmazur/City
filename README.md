# City

Searching for answers on the internet is perfectly acceptable, but key references should be recorded.
These exercises are to demonstrate knowledge of OO techniques, so please use them wherever possible.
 

1) Take as source the Cities provided at the end of the file and write a script city_info.pl that when 
   passed the city name via:

 	    city_info.pl --city <city name> [--filename <optional filename holding the city info>]

   it will print out a small summary of the details of the city. 

   Please write this entirely using OO techniques.  Please write this in as few statements as possible.
   There is no limitation on the Perl Modules you can use, but avoid of using deprecated modules like Switch etc.


2) Take the city example above and provide summary information for all cities
   Please load, construct and display all city objects from a data file in as few lines as possible.
   Plus the file must be loaded into a string in one operation. (To test knowledge of Perl's idioms).
   Implement this functionality as the mandatory.

 
3) The data set for the cities including ID, City, Country, and Population, however when a 
   city is a capital city, it should output additionally the population of the country. How to do it - it is up to you.
   E.g. you can get this data from public sources, Internet and so forth.
