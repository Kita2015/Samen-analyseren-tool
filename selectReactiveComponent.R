## ---------------------------------------------------------
## R Script voor interactieve data-analyse van sensordata, met o.a. R package openair, leaflet en shiny.
## Deze Samen Analyseren Tool bestaat uit meerdere scripts. Dit is het functie script.
## Auteur: Henri de Ruiter en Elma Tenner namens het Samen Meten Team, RIVM. 
## Laatste versie: april 2020
## Contact: info@samenmeten.nl 
## ---------------------------------------------------------
## Opmerkingen: 
## In dit script worden 1 functie gemaakt die het interactieve gedeelte
## van de componentkeuze maken.
## ---------------------------------------------------------

selectReactiveComponent <- function(input){ 
  
  comp <- switch(input$Var, 
                 "pm10_kal" = "pm10_kal",
                 "pm25_kal" = "pm25_kal")
  
  return(comp)
} 

