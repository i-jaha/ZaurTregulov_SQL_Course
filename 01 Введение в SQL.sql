-- 1. Получите описание таблицы REGIONS, используя её полное имя
DESC HR.REGIONS; 
/*

Name        Null?    Type         
----------- -------- ------------ 
REGION_ID   NOT NULL NUMBER       
REGION_NAME          VARCHAR2(25) 

*/

-- 2. Получите описание таблицы COUNTRIES, используя её полное имя.
DESC HR.COUNTRIES;
/*

Name         Null?    Type         
------------ -------- ------------ 
COUNTRY_ID   NOT NULL CHAR(2)      
COUNTRY_NAME          VARCHAR2(60) 
REGION_ID             NUMBER       

*/

-- 3. Получите описание таблицы JOBS, используя её короткое имя.
DESC HR.JOBS;
/*

Name       Null?    Type         
---------- -------- ------------ 
JOB_ID     NOT NULL VARCHAR2(10) 
JOB_TITLE  NOT NULL VARCHAR2(35) 
MIN_SALARY          NUMBER(6)    
MAX_SALARY          NUMBER(6)    

*/

-- 4. Получите описание таблицы LOCATIONS, используя её короткое имя.
DESC HR.LOCATIONS;
/*

Name           Null?    Type         
-------------- -------- ------------ 
LOCATION_ID    NOT NULL NUMBER(4)    
STREET_ADDRESS          VARCHAR2(40) 
POSTAL_CODE             VARCHAR2(12) 
CITY           NOT NULL VARCHAR2(30) 
STATE_PROVINCE          VARCHAR2(25) 
COUNTRY_ID              CHAR(2)      

*/
