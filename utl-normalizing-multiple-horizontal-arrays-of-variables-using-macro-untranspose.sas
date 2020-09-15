Normalizing wide data is a critical function and should be in everyones toolbox.                                                        
                                                                                                                                        
github                                                                                                                                  
https://tinyurl.com/yyensv43                                                                                                            
https://github.com/rogerjdeangelis/utl-normalizing-multiple-horizontal-arrays-of-variables-using-macro-untranspose                      
                                                                                                                                        
SAS Forum                                                                                                                               
https://tinyurl.com/y679ppma                                                                                                            
https://communities.sas.com/t5/SAS-Procedures/Proc-Transpose-and-add-days/m-p/683396                                                    
                                                                                                                                        
This is a more interesting variation of Art's solution to the SAS Forum problem.                                                        
                                                                                                                                        
It is slightly more interesting because 'proc transpose' cannot transpose                                                               
multiple arrays of variables. This also hilites the 'var_first' and 'missing' options.                                                  
                                                                                                                                        
Fast algorithms, like Art et all, for normalizing wide data is a critical function and                                                  
should be in everyones toolbox.                                                                                                         
                                                                                                                                        
Thanks Art et all                                                                                                                       
                                                                                                                                        
/*                   _                                                                                                                  
(_)_ __  _ __  _   _| |_                                                                                                                
| | `_ \| `_ \| | | | __|                                                                                                               
| | | | | |_) | |_| | |_                                                                                                                
|_|_| |_| .__/ \__,_|\__|                                                                                                               
        |_|                                                                                                                             
*/                                                                                                                                      
                                                                                                                                        
optiond missing=.;                                                                                                                      
data have;                                                                                                                              
input UUID $ Vent_day_0 Vent_day_1 Vent_day_2 Vent_day_3 Rent_day_0 Rent_day_1 Rent_day_2 Rent_day_3;                                   
cards;                                                                                                                                  
UU0300 0 1 1 0 0 1 1 0                                                                                                                  
UU0301 0 0 1 1 0 0 1 1                                                                                                                  
UU0305 . 1 1 1 . 1 1 1                                                                                                                  
;;;;                                                                                                                                    
run;quit;                                                                                                                               
                                                                                                                                        
/*                                                                                                                                      
WORK.HAVE total obs=3                                                                                                                   
                                                                                                                                        
           Vent_    Vent_    Vent_    Vent_    Rent_    Rent_    Rent_    Rent_                                                         
  UUID     day_0    day_1    day_2    day_3    day_0    day_1    day_2    day_3                                                         
                                                                                                                                        
 UU0300      0        1        1        0        0        1        1        0                                                           
 UU0301      0        0        1        1        0        0        1        1                                                           
 UU0305      .        1        1        1        .        1        1        1                                                           
*/                                                                                                                                      
                                                                                                                                        
/*           _               _                                                                                                          
  ___  _   _| |_ _ __  _   _| |_                                                                                                        
 / _ \| | | | __| `_ \| | | | __|                                                                                                       
| (_) | |_| | |_| |_) | |_| | |_                                                                                                        
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                       
                |_|                                                                                                                     
*/                                                                                                                                      
                                                                                                                                        
WORK.WANT total obs=12                                                                                                                  
                                                                                                                                        
                   Not possible                                                                                                         
                   with 'proc transpose'                                                                                                
                   ============                                                                                                         
                                                                                                                                        
                   vent_    rent_                                                                                                       
   UUID     seq     day_     day_                                                                                                       
                                                                                                                                        
  UU0300     0       0        0                                                                                                         
  UU0300     1       1        1                                                                                                         
  UU0300     2       1        1                                                                                                         
  UU0300     3       0        0                                                                                                         
  UU0301     0       0        0                                                                                                         
  UU0301     1       0        0                                                                                                         
  UU0301     2       1        1                                                                                                         
  UU0301     3       1        1                                                                                                         
  UU0305     0       .        .                                                                                                         
  UU0305     1       1        1                                                                                                         
  UU0305     2       1        1                                                                                                         
  UU0305     3       1        1                                                                                                         
                                                                                                                                        
/*         _       _   _                                                                                                                
 ___  ___ | |_   _| |_(_) ___  _ __                                                                                                     
/ __|/ _ \| | | | | __| |/ _ \| `_ \                                                                                                    
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                                                   
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                                                   
                                                                                                                                        
*/                                                                                                                                      
                                                                                                                                        
options missing=.;                                                                                                                      
filename ut url 'http://tiny.cc/untranspose_macro';                                                                                     
%untranspose(data=have, out=want ,  by=UUID, id=seq,                                                                                    
  var=vent_day_ rent_day_, missing=yes, var_first=yes);                                                                                 
                                                                                                                                        
                                                                                                                                        
