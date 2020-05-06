## ---------------------------------------------------------
## R Script voor interactieve data-analyse van sensordata, met o.a. R package openair, leaflet en shiny.
## Deze Samen Analyseren Tool bestaat uit meerdere scripts. Dit is het ui.R script.
## Auteur: Henri de Ruiter en Elma Tenner namens het Samen Meten Team, RIVM. 
## Laatste versie: april 2020
## Contact: info@samenmeten.nl 
## ---------------------------------------------------------
## Opmerkingen: 
## Het eerste gedeelte bevat de opmaak/styling
## ---------------------------------------------------------

# HTML template voor de opmaak/styling
htmlTemplate("template.wide.html",
             pageTitle=paste("Prototype Samen Analyseren tool: project ", projectnaam),
             
             aboutSite=div(h3("Verantwoording"),
                           
                           p("Dit dashboard is door het ", a("RIVM", href = "https://rivm.nl", target = 'blank'), "ontwikkeld voor snelle analyse van sensordata.
                             Het maakt gebruik van de R-package",
                             a("openair.", 
                               href = "http://davidcarslaw.github.io/openair/", target="_blank"),
                             
                             p("Het huidige dashboard is een prototype en nog volop in ontwikkeling. 
                               Het wordt gebruikt om verschillende analyses en visualisaties te testen.
                               In 2020 zullen we de broncode openbaar maken, zodat we samen met jullie het dashboard verder kunnen ontwikkelen."),
                             
                             h4("Data"),
                             p("De getoonde sensordata zijn afkomstig uit de", 
                               a("Samen Meten database.",
                                 href = "https://samenmeten.rivm.nl/dataportaal/", target = 'blank'),
                               "De sensormetingen die in dit prototype gevisualiseerd worden, zijn gedaan met goedkope fijnstofsensoren van het project",
                               a("Hollandse Luchten.",
                                 href = "https://hollandseluchten.waag.org/", target = 'blank'),
                               "De gegevens worden eens per maand ge-update. De getoonde waarden geven een indicatie van de fijnstofconcentratie. 
                               De data zijn niet geschikt om te toetsen aan grenswaarden."
                             ),
                             p("Elke sensor kan worden vergeleken met het dichtstbijzijnde meetstation van het", a("Luchtmeetnet",
                                                                                                                  href = "https://luchtmeetnet.nl", target = 'blank'), ".
        De windgegevens voor het berekenen van de windroos komen van het dichtstbijzijnde weerstation van het ", a("KNMI",
                                                                                                                  href = "https://knmi.nl", target = 'blank'),".
        De locaties van de gebruikte luchtmeetnet- en weerstations worden met icoontjes op de kaart getoond."),
                             h4("Gekalibreerde waarden"),
                             p("Details over de kalibratieprocedure zijn te vinden op het", 
                               a("Samen Meten Kennisportaal.",
                                 href = "https://www.samenmetenaanluchtkwaliteit.nl/dataportaal/kalibratie-van-fijnstofsensoren", target = 'blank'),
                               "De kalibratie is nog niet met terugwerkende kracht uitgevoerd. Hierdoor kan er minder gekalibreerde data aanwezig zijn. 
        We krijgen steeds meer begrip van situaties waarin sensoren – ook na kalibratie – minder betrouwbare waarden geven. 
        Dit zijn bijvoorbeeld situaties met zeer hoge luchtvochtigheid (vanaf 97 à 98% zoals gemeten op KNMI stations). 
        Met name in de wintermaanden in de nacht en vroege ochtend kan de luchtvochtigheid zeer hoog kan zijn. 
        Maar het kan ook gaan om sensoren die altijd of vaak afwijken van de patronen die andere sensoren laten zien.  
        Het is op dit moment nog niet mogelijk om de meetwaarden van deze uren of sensoren uit de gegevens te filteren. Daar werken we wel aan.
        "
                             ))),
             
  # Vanaf hier begint de tool zelf
  fluidPage=fluidPage(
    
  # wellPanel voor grijze boxing
  wellPanel(
  # Sidebar layout met input en output definities
  sidebarLayout(
    # Sidebar panel voor leaflet map om sensoren te selecteren
    sidebarPanel(
      
      #Output: Leaflet map voor sensorselectie
      leafletOutput("map", height = "300px"),
      br(),
      
      fluidRow(
        column(7,# Input: Selecteer de component uit de choices lijst
               selectInput(inputId = "Var", label = "Kies component", choices = choices, selected = NULL, multiple = FALSE,
                           selectize = TRUE, width = NULL, size = NULL)
        ),
        column(5, # Button om de selectie van sensoren te resetten
               actionButton("reset", "Reset selectie")
        )
        
        
      ),
      
      fluidRow(
        column(7,# Input: Tekst voor de groepselectie
               textInput(inputId = "Text_groep",'Vul groepsnaam in', value = 'groep1')
        )
        ,
        column(5, # Input: Checkbox om aan te vinken om de sensoren in een groep te plaatsen
               checkboxInput('A_groep','Voeg selectie toe aan groep')
        )
      )
      ,
      # Input: Slider voor het genereren van de tijdreeks
      sliderInput("TimeRange", label = "Selecteer tijdreeks",
                  min = min(input_df$date),
                  max = max(input_df$date),
                  step=60*60*24,
                  value = c(min(input_df$date),
                            max(input_df$date)
                            
                  ),
                  width = '100%'
      )
    ),
    
    
    # Main panel voor outputs
    mainPanel(
      # Output: Tabset voor openair plots, zie voor de inhoud het script: tabPanels.R
      tabsetPanel(type = "tabs",
                  tpTimeplot(),
                  tpKalender(),
                  tpTimevariation(),
                  tpPercentileRose(),
                  tpPollutionRose(),
                  tpWindRose()
      )
    ) 
    ),
  )
)
)