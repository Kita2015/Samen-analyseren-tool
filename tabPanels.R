## ---------------------------------------------------------
## R Script voor interactieve data-analyse van sensordata, met o.a. R package openair, leaflet en shiny.
## Deze Samen Analyseren Tool bestaat uit meerdere scripts. Dit is het tabPanels script.
## Auteur: Henri de Ruiter en Elma Tenner namens het Samen Meten Team, RIVM. 
## Laatste versie: april 2020
## Contact: info@samenmeten.nl 
## ---------------------------------------------------------
## Opmerkingen: 
## In dit script worden de verschillende tabbladen gemaakt
## ---------------------------------------------------------

tpGrafiek <- function(){
  
  library(shiny)
  
  tp <-  tabPanel("Tijdreeks",
                  helpText("Selecteer een sensor. In deze grafiek kan je meerdere (groepen) sensoren en het LML-station vergelijken."),
                  plotlyOutput("grafiek"),
                  h4("Toelichting"),
                  p("Als je één of meerdere sensoren aanklikt, zie je een tijdreeks van de uurlijkse sensorwaarden voor de geselecteerde periode.
                    Deze waarden kan je vergeleken met station Vredepeel of Horst a/d Maas van het landelijk luchtmeetnet. Zo wordt het mogelijk om een gebiedsgemiddelde te vergelijken met de metingen van een referentiestation.
                    Op de x-as zie je de geselecteerde tijdsperiode; op de y-as staat de concentratie PM10 of PM2,5 in ug/m3
                    ",
                    style = "font-size:12px")
                  
  )
  
  return(tp)
} 

tpTimeplot <- function(){ #deze plot staat uit in de benb tool
  
  library(shiny)
  
  tp <-  tabPanel("Sensor vs LML",
                  
                  sidebarLayout(
                    sidebarPanel(id = "sidebar",
                                 
                                 h4("Toelichting"),
                                 p("Als je een sensor aanklikt, zie je een tijdreeks van de uurlijkse sensorwaarden voor de geselecteerde periode.
                                   Deze waarden worden vergeleken met het dichtstbijzijnde meetstation van het landelijk luchtmeetnet.
                                   Dit maakt het mogelijk om de sensorwaarden snel te vergelijken met de referentiemetingen.
                                   ", style = "font-size:12px"),
                                 
                                 width = 3),
                    mainPanel(
                      helpText("Per grafiek wordt één sensor vergeleken met het LML-station."),
                      plotOutput("timeplot"),
                      width = 9),
                    position = "right",
                    fluid = TRUE)
                  )
  
  return(tp)
} 

tpKalender <- function(){
  
  library(shiny)
  
  tp <-  tabPanel("Kalender",
                  helpText("Deze grafiek laat het gemiddelde van de (groep) sensor(en) zien per dag."),
                  plotOutput("calendar"),
                  h4("Toelichting"),
                  p("Als je één of meer sensoren aanklikt, wordt de gemiddelde concentratie per dag getoond in een standaard kalenderformaat.
                    Dit maakt het mogelijk om snel inzicht te krijgen op welke dagen de concentraties hoog (of laag) waren.
                    Op dit moment wordt het kleurverloop gekozen op basis van een schaal van 0 tot 150 ug/m3.
                    Dit betekent dat licht gekleurde dagen gemiddeld een lage concentratie hadden; donkerpaarse dagen geven aan dat de concentratie die dag hoog was.",
                    style = "font-size:12px")
                  
  )
  
  return(tp)
} 

tpTimevariation <- function(){
  
  library(shiny)
  
  tp <-  tabPanel("Gemiddelden",
                  helpText("Deze grafieken laten het gemiddelde zien voor verschillende tijdsperioden per sensor of sensorgroep."),
                  plotOutput("timevariation"),
                  h4("Toelichting"),
                  p("Als je een sensor aanklikt, wordt de gemiddelde concentratie per tijdsperiode getoond. 
                    De bovenste grafiek laat de gemiddelde uurwaarde, uitgesplitst naar weekdag, zien.
                    Onder zie je de gemiddelde concentratie op elk uur van de dag (links). 
                    In het midden zie je de gemiddelde concentratie per maand en
                    rechts zie je de gemiddelde concentratie per dag van de week.
                    ", style = "font-size:12px")
                  )
  
  
  return(tp)
} 

tpPolarPlot<- function(){
  
  library(shiny)
  
  tp <-  tabPanel("Polarplot",
                  helpText("Deze grafiek toont de herkomst van PM10 of PM25 per sensor of sensorgroep op basis van windrichting en -snelheid."),
                  plotOutput("polarplot"),
                  h4("Toelichting"),
                  p("Als je een sensor aanklikt, wordt een polarplot getoond.
                    Deze toont de variatie in de gemiddelde concentraties van PM10 of PM25 op basis van windrichting en -snelheid.
                    Hierdoor is het mogelijk om inzicht te krijgen in de windrichtingen waarbij hoge en lage concentraties gemeten worden. Dit geeft inzicht in of bronnen dichtbij zijn, of dat er sprake is van grootschalige patronen. De grijze, gestreepte cirkels geven de windsnelheid aan.
                    Het kleurverloop in de legenda geeft de concentratie PM aan. Op dit moment worden de kleuren gekozen op basis van een schaal van 0 tot 50 ug/m3. 
                    Lage concentraties worden donkerblauw; hoge concentraties worden donkerrood.
                    Voorbeeld: een rode kleur aan de rechterbuitenrand van de kleurvlek geeft aan dat er bij hogere windsnelheid uit het oosten, hogere concentraties worden gemeten.
                    Het kan soms even duren voordat de grafiek zichtbaar is.
                    Let op: voor PM10 wordt een schaal gebruikt van 0 tm/ 60 ug/m3; voor PM25 wordt een schaal gebruikt van 0 t/m 30 ug/mc", 
                    style = "font-size:12px")
                  
  )
  
  
  return(tp)
} 

tpWindRose<- function(){
  
  library(shiny)
  
  tp <-  tabPanel("Windroos",
                  helpText("Deze grafiek toont per windrichting hoe vaak en hoe hard de wind waaide per sensor of sensorgroep."),
                  plotOutput("windplot"),
                  h4("Toelichting"),
                  p("Als je een sensor aanklikt, wordt een windroos getoond.
                    Deze windroos laat de windsnelheid en -richting zien van het dichtstbijzijnde KNMI-station. Voor elke windsector toont de 
                    grafiek in hoeveel procent van de tijd de wind vanuit die richting waaide.  
                    De gekleurde blokken geven de windsnelheid aan. Bijvoorbeeld: wanneer de wind voornamelijk uit het zuidwesten komt, 
                    ziet u de langste blokken linksonder (tussen zuid en west in). Als u wilt weten hoe hard de wind waaide, 
                    bekijkt u de kleur van de blokken. Hoe donkerder de kleur, hoe harder de wind.",
                    style = "font-size:12px")
  )
  
  
  return(tp)
} 


tpPercentileRose<- function(){
  
  library(shiny)
  
  tp <-  tabPanel("Pollutieroos",
                  helpText("Deze grafiek toont de gemiddelde concentratie per windrichting."),
                  plotOutput("percentileplot"),
                  h4("Toelichting"),
                  p("Als je een sensor aanklikt, wordt een pollutieroos getoond. 
                    Deze toont per windsector het gemiddelde van de sensormetingen wanneer de wind uit die richting waaide.
                    Voorbeeld: als aan de rechterbovenzijde van de grafiek de grijze lijntjes op de streep voor 20 ug/m3 ligt en aan de linkerbovenzijde op 10 ug/m3, dan betekent dit dat bij wind van het noordoosten de concenetraties hoger zijn dan bij wind vanuit het noordwesten.",
                    style = "font-size:12px")
                  
  )
  
  return(tp)
} 

tpPollutionRose<- function(){
  
  library(shiny)
  
  tp <-  tabPanel("Pollutieroos (%)",
                  helpText("Deze grafiek toont per windrichting de relatieve bijdrage aan de totale gemiddelde concentratie per sensor of sensorgroep."),
                  plotOutput("pollutionplot"),
                  h4("Toelichting"),
                  p("Als je een sensor aanklikt, wordt een gewogen pollutieroos getoond. 
                    Deze berekent per windsector het aandeel (in %) van deze sector in de totale gemiddelde concentratie.
                    De gemiddelde concentratie per sector wordt hiervoor gewogen naar hoe vaak deze windrichting voorkomt.
                    Voorbeeld: als er linksonder een driehoek ligt op de grijze lijn met 15% met een grote lichtpaarse vulling en een hele kleine donkerpaarse vulling, betekent dit dat de wind zo'n 15% van de tijd uit het zuidwesten waait en grotedeels lage concentraties (lichtpaarse vulling) brengt en slechts af en toe een hoge concenetratie (donkerpaarse vulling).
                    ", style = "font-size:12px")
                  
                  )
  
  return(tp)
} 

tpOverzicht <- function(){
  
  library(shiny)
  
  tp <-  tabPanel("Overzicht",
                  helpText("Per sensor of groep sensoren wordt het gemiddelde getoond."),
                  plotlyOutput("overzichtplot"),
                  h4("Toelichting"),
                  p("Als je een sensor of groep sensoren selecteert, zie je het gemiddelde voor de geselecteerde tijdreeks. Vanaf een jaar data wordt het mogelijk om een jaargemiddelde concenetratie te berekenen.
                    ", style = "font-size:12px")
                  
                  )
  
  return(tp)
} 


