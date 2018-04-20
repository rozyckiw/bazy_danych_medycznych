USE oddzial_okulistyczny;

CALL stworzPacjenta( 	'Wojciech', 'Różycki', '01020304051', 'Tomasz, Aneta', 'Dowód osobisty', 'ALU121314', '1995-06-07', 'Łódź', 'M', 
						'123456789', 'Polska', 'Łódź', 'Uliczna', 1, '11-111', 'Łódź', 'łódzkie' );
                        
CALL stworzPacjenta( 	'Dominika', 'Wójcik', '01020304052', 'Wiktor, Julia', 'Dowód osobisty', 'ALU121315', '1995-07-06', 'Łódź', 'K', 
						'123456788', 'Polska', 'Łódź', 'Wieczna', 2, '11-112', 'Łódź', 'łódzkie' );
                        
CALL stworzPacjenta( 	'Mieczysław', 'Donoga', '01020304053', 'Aleksander, Witkoria', 'Dowód osobisty', 'ALU121316', '1990-01-02', 'Łódź', 'M', 
						'123456787', 'Polska', 'Aleksandrów Łódzki', 'Traktorowa', 5, '11-113', 'Aleksandrów Łódzki', 'łódzkie' );
			
CALL stworzPacjenta( 	'Joanna', 'Starsza', '01020304054', 'Tomasz, Aleksandra', 'Dowód osobisty', 'ALU121317', '1985-03-12', 'Warszawa', 'K', 
						'123456786', 'Polska', 'Zgierz', 'Fabryczna', 15, '11-114', 'Zgierz', 'łódzkie' );
                        
CALL stworzPacjenta( 	'Ania', 'Młodsza', '01020304055', 'Marek, Joanna', 'Dowód osobisty', 'ALU121318', '1987-12-12', 'Łódź', 'K', 
						'123456785', 'Polska', 'Łódź', 'Piotrkowska', 25, '11-115', 'Łódź', 'łódzkie' );
                        
CALL stworzPacjenta( 	'Marek', 'Mirecki', '01020304056', 'Tobiasz, Joanna', 'Dowód osobisty', 'ALU121319', '1997-2-2', 'Jelenia Góra', 'M', 
						'123456784', 'Polska', 'Łódź', 'Włókniarzy', 5, '11-116', 'Łódź', 'łódzkie' );
                        
CALL stworzPacjenta( 	'Maximiliam', 'Endershultz', '', 'Maximiliam, Carol', 'Paszport', 'ALU121320', '1991-1-29', 'Berlin', 'M', 
						'123456783', 'Germany', 'Berlin', 'Strutze', 2, '111-116', '', '' );
                        
CALL stworzPacjenta( 	'Monika', 'Miła', '01020304057', 'Jacek, Milena', 'Dowód osobisty', 'ALU121321', '1990-3-25', 'Łódź', 'K', 
						'123456782', 'Polska', 'Łódź', '3 Maja', 26, '11-117', 'Łódź', 'łódzkie' );
                        
CALL stworzPacjenta( 	'Elżbieta', 'Boguszewska', '01020304058', 'Michał, Renata', 'Dowód osobisty', 'ALU121322', '1999-11-1', 'Pabianice', 'K', 
						'123456783', 'Polska', 'Pabianice', '1 Maja', 16, '11-118', 'Pabianice', 'łódzkie' );
                        
CALL stworzPacjenta( 	'Michał', 'Rozejmowski', '01020304059', 'Michał, Beata', 'Dowód osobisty', 'ALU121323', '2001-10-2', 'Łódź', 'M', 
						'123456782', 'Polska', 'Łódź', 'Strykowska', 23, '11-119', 'Łódź', 'łódzkie' );
                        
CALL stworzPracownika( 1, '2017-01-02', 'L' );
CALL stworzPracownika( 2, '2017-01-03', 'P' );
CALL stworzPracownika( 3, '2018-12-03', 'P' );
CALL stworzPracownika( 4, '2011-12-03', 'L' );

CALL stworzUbezpieczenie( 1, 'CUK', '12345678910', '2016-01-01', '2026-01-01' );
CALL stworzUbezpieczenie( 2, 'AXA', '12345678911', '2015-12-5', '2025-12-5' );
CALL stworzUbezpieczenie( 3, 'PZU', '12345678912', '2014-12-5', '2024-12-5' );
CALL stworzUbezpieczenie( 4, '4LifeDirect', '12345678913', '2011-12-5', '2021-12-5' );
CALL stworzUbezpieczenie( 5, 'Prudental', '12345678914', '2005-12-5', '2015-12-5' );
CALL stworzUbezpieczenie( 6, 'Aviva', '12345678915', '2015-12-15', '2025-12-15' );
CALL stworzUbezpieczenie( 7, 'Allianz', '12345678916', '2014-10-26', '2024-10-26' );
CALL stworzUbezpieczenie( 8, 'Concordia', '12345678917', '2013-2-6', '2023-2-6' );
CALL stworzUbezpieczenie( 9, 'Compensa', '12345678918', '2011-11-2', '2021-11-2' );
CALL stworzUbezpieczenie( 10, 'AXA', '12345678919', '2009-12-30', '2019-12-30' );

CALL stworzEpizod( 4, 3 );
CALL stworzEpizod( 4, 5 );
CALL stworzEpizod( 4, 6 );
CALL stworzEpizod( 1, 7 );

CALL stworzSkierowanie( 1, 192, '2015-02-15', 'Niezbornosc');
CALL stworzSkierowanie( 2, 77, '2017-12-5', 'Starczowzrocznosc');
CALL stworzSkierowanie( 3, 9, '2018-04-7', 'Zaburzenia refrakcji, nie okreslone');
CALL stworzSkierowanie( 4, 18, '2016-11-1', 'Różnowzroczność (anisometropia) i różnica wielkości obrazów na siatkówce (aniseikonia)');

CALL stworz_Diagnoze( 'H52.2', '-', 1);
CALL stworz_Diagnoze( 'H52.4', '-', 2);
CALL stworz_Diagnoze( 'H52.7', 'H01.9', 3);
CALL stworz_Diagnoze( 'H52.3', '-', 4);