
# Paises ------------------------------------------------------------------

unique(data_raw$`Country Name`)

paises <- split(data_raw, data_raw$`Country Name`)

Afghanistan <- paises$Afghanistan
Albania <- paises$Albania
Algeria <- paises$Algeria
Angola <- paises$Angola
Antigua_and_Barbuda <- paises$`Antigua and Barbuda`
Argentina <- paises$Argentina
Armenia <- paises$Armenia
Australia <- paises$Australia
Azerbaijan <- paises$Azerbaijan
Bahamas_The <- paises$`Bahamas, The`
Bahrain <- paises$Bahrain
Bangladesh <- paises$Bangladesh
Barbados <- paises$Barbados
Belarus <- paises$Belarus
Belgium <- paises$Belgium
Belize <- paises$Belize
Benin <- paises$Benin
Bhutan <- paises$Bhutan
Bolivia <- paises$Bolivia
Bosnia_and_Herzegovina <- paises$`Bosnia and Herzegovina`
Botswana <- paises$Botswana
Brazil <- paises$Brazil
Brunei_Darussalam <- paises$`Brunei Darussalam`
Bulgaria <- paises$Bulgaria
Burkina_Faso <- paises$`Burkina Faso`
Burundi <- paises$Burundi
Cabo_Verde <- paises$`Cabo Verde`
Cambodia <- paises$Cambodia
Cameroon <- paises$Cameroon
Canada <- paises$Canada
Central_African_Republic <- paises$`Central African Republic`
Chad <- paises$Chad
Chile <- paises$Chile
China <- paises$China
Chittagong <- paises$Chittagong
Colombia <- paises$Colombia                       
Comoros <- paises$Comoros                        
Congo_Dem_Rep <- paises$`Congo, Dem. Rep.`             
Congo_Rep <- paises$`Congo, Rep.`
Costa_Rica <- paises$`Costa Rica`                    
Cote_d_Ivoire <- paises$`C\xf4te d'Ivoire` #este nombre me dio muchos problemas tuve que usar backticks
Croatia <- paises$Croatia
Cyprus <- paises$Cyprus
Czech_Republic <- paises$`Czech Republic`
Delhi <- paises$Delhi
Denmark <- paises$Denmark
Dhaka <- paises$Dhaka                              
Djibouti <- paises$Djibouti                         
Dominica <- paises$Dominica
Dominican_Republic <- paises$`Dominican Republic`             
Ecuador <- paises$Ecuador
Egypt_Arab_Rep <- paises$`Egypt, Arab Rep.`                  
El_Salvador <- paises$`El Salvador`                       
Equatorial_Guinea <- paises$`Equatorial Guinea`              
Eritrea <- paises$Eritrea
Estonia <- paises$Estonia
Eswatini <- paises$Eswatini                    
Ethiopia <- paises$Ethiopia
Fiji <- paises$Fiji                               
Finland <- paises$Finland                        
France <- paises$France
Gabon <- paises$Gabon                           
Gambia_The <- paises$`Gambia, The`
Georgia <- paises$Georgia                           
Germany <- paises$Germany
Ghana <- paises$Ghana                           
Greece <- paises$Greece                            
Grenada <- paises$Grenada                         
Guatemala <- paises$Guatemala
Guinea <- paises$Guinea                            
Guinea_Bissau <- paises$`Guinea-Bissau`
Guyana <- paises$Guyana                           
Haiti <- paises$Haiti
Honduras <- paises$Honduras                          
Hungary <- paises$Hungary                           
Iceland <- paises$Iceland
India <- paises$India                            
Indonesia <- paises$Indonesia
Iran_Islamic_Rep <- paises$`Iran, Islamic Rep.`            
Iraq <- paises$Iraq
Ireland <- paises$Ireland                           
Israel <- paises$Israel
Italy <- paises$Italy
Jamaica <- paises$Jamaica
Japan <- paises$Japan
Jordan <- paises$Jordan                            
Kazakhstan <- paises$Kazakhstan
Kenya <- paises$Kenya                             
Kiribati <- paises$Kiribati
Korea_Rep <- paises$`Korea, Rep.`
Kosovo <- paises$Kosovo
Kuwait <- paises$Kuwait                            
Kyrgyz_Republic <- paises$`Kyrgyz Republic`
Lao_PDR <- paises$`Lao PDR`                        
Latvia <- paises$Latvia
Lebanon <- paises$Lebanon                          
Lesotho <- paises$Lesotho
Liberia <- paises$Liberia                           
Libya <- paises$Libya
Liechtenstein <- paises$Liechtenstein                     
Lithuania <- paises$Lithuania
Luxembourg <- paises$Luxembourg                        
Madagascar <- paises$Madagascar                       
Malawi <- paises$Malawi
Malaysia <- paises$Malaysia
Maldives <- paises$Maldives
Mali <- paises$Mali                             
Malta <- paises$Malta
Marshall_Islands <- paises$`Marshall Islands`                 
Mauritania <- paises$Mauritania
Mauritius <- paises$Mauritius                         
Mexico <- paises$Mexico
Micronesia_Fed_Sts <- paises$`Micronesia, Fed. Sts.`
Moldova <- paises$Moldova                           
Mongolia <- paises$Mongolia
Montenegro <- paises$Montenegro                       
Morocco <- paises$Morocco                         
Mozambique <- paises$Mozambique                      
Myanmar <- paises$Myanmar                        
Namibia <- paises$Namibia
Nepal <- paises$Nepal                             
Netherlands <- paises$Netherlands                                              
New_Zealand <- paises$`New Zealand`
Nicaragua <- paises$Nicaragua
Niger <- paises$Niger
Nigeria <- paises$Nigeria                          
North_Macedonia <- paises$`North Macedonia`
Norway <- paises$Norway                            
Oman <- paises$Oman                                                         
Pakistan <- paises$Pakistan
Palau <- paises$Palau                            
Panama <- paises$Panama
Papua_New_Guinea <- paises$`Papua New Guinea`                 
Paraguay <- paises$Paraguay
Peru <- paises$Peru                            
Philippines <- paises$Philippines
Poland <- paises$Poland                           
Portugal <- paises$Portugal
Puerto_Rico <- paises$`Puerto Rico`                      
Qatar <- paises$Qatar                                            
Romania <- paises$Romania
Russian_Federation <- paises$`Russian Federation`
Rwanda <- paises$Rwanda
Samoa <- paises$Samoa
San_Marino <- paises$`San Marino`                      
Sao_Tome_and_Principe <- paises$`S\xe3o Tom\xe9 and Principe`
Saudi_Arabia <- paises$`Saudi Arabia`                    
Senegal <- paises$Senegal
Serbia <- paises$Serbia                            
Seychelles <- paises$Seychelles                         
Sierra_Leone <- paises$`Sierra Leone`
Singapore <- paises$Singapore                        
Slovak_Republic <- paises$`Slovak Republic`                  
Slovenia <- paises$Slovenia                          
Solomon_Islands <- paises$`Solomon Islands`
Somalia <- paises$Somalia                          
South_Africa <- paises$`South Africa`
South_Sudan <- paises$`South Sudan`                      
Spain <- paises$Spain                             
Sri_Lanka <- paises$`Sri Lanka`                         
St_Kitts_and_Nevis <- paises$`St. Kitts and Nevis`
St_Lucia <- paises$`St. Lucia`                       
St_Vincent_and_the_Grenadines <- paises$`St. Vincent and the Grenadines`   
Sudan <- paises$Sudan                             
Suriname <- paises$Suriname
Sweden <- paises$Sweden                            
Switzerland <- paises$Switzerland
Syrian_Arab_Republic <- paises$`Syrian Arab Republic`
Taiwan_China <- paises$`Taiwan, China`
Tajikistan <- paises$Tajikistan                        
Tanzania <- paises$Tanzania
Thailand <- paises$Thailand                          
Timor_Leste <- paises$`Timor-Leste`
Togo <- paises$Togo                             
Tonga <- paises$Tonga 
Trinidad_and_Tobago <- paises$`Trinidad and Tobago`
Tunisia <- paises$Tunisia                         
Turkey <- paises$Turkey
Uganda <- paises$Uganda                            
Ukraine <- paises$Ukraine
United_Arab_Emirates <- paises$`United Arab Emirates`
United_Kingdom <- paises$`United Kingdom`
United_States <- paises$`United States`
Uruguay <- paises$Uruguay
Uzbekistan <- paises$Uzbekistan                       
Vanuatu <- paises$Vanuatu
Venezuela_RB <- paises$`Venezuela, RB`                  
Vietnam <- paises$Vietnam                           
West_Bank_and_Gaza <- paises$`West Bank and Gaza`                
Yemen_Rep <- paises$`Yemen, Rep.`
Zambia  <- paises$Zambia                           
Zimbabwe <- paises$Zimbabwe          








# Ciudades ----------------------------------------------------------------

Hong_Kong_China <- paises$`Hong Kong, China`
Jakarta <- paises$Jakarta
Beijing <- paises$Beijing
Kano <- paises$Kano
Karachi <- paises$Karachi
Lagos <- paises$Lagos
Lahore <- paises$Lahore
Los_Angeles <- paises$`Los Angeles`
Mexico_City <- paises$`Mexico City`
Monterrey <- paises$Monterrey
Moscow <- paises$Moscow
Mumbai <- paises$Mumbai
New_York <- paises$`New York`
Osaka <- paises$Osaka
Rio_de_Janeiro <- paises$`Rio de Janeiro`
Sao_Paulo <- paises$`Sao Paulo`
Shanghai <- paises$Shanghai
St_Petersburg <- paises$`St. Petersburg`
Surabaya <- paises$Surabaya
Tokyo <- paises$Tokyo