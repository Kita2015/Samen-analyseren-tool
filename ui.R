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
htmlTemplate("./www/template_samenmeten.wide.html",
             pageTitle=paste("Prototype Samen Analyseren tool: project ", projectnaam),
             
             aboutSite=div(
               
               h3("Gebruik"),
               
               h5("Sensoren selecteren"),
               p("Je kan één of meer sensoren selecteren door deze op de kaart aan te klikken. Je deselecteert een sensor door er nogmaals op te klikken. Ook kan je alle geselecteerde sensoren deselecteren door op de knop 'Reset selectie' te klikken."),
               
               h5("Sensoren groeperen"),
               p("  Het is ook mogelijk een groep sensoren aan te maken. Meestal zeggen de metingen van een enkele sensor niet zo veel. 
                 Door de metingen van meerdere sensoren te combineren, ontstaat er een duidelijker beeld. Zo kan je sensoren rondom één locatie, bijvoorbeeld een wijk of bron, groeperen.
                 Geef de groep sensoren een naam. Zet vervolgens een vinkje in het vakje voor 'Maak een groep.' Vervolgens kan je een groepsselectie maken met de cirkel of het vierkant aan de linkerzijde van de kaart. Ook kan je meerdere sensoren los aanklikken.
                 Als je een tweede groep wilt maken, klik dan het vinkje eerst weg. Nadat je een nieuwe naam invult, zet je weer een vinkje en kan je opnieuw sensoren naar keuze selecteren."),
                   
                   h5("De tijdrange aanpassen"),
                   p("Met de schuifbalk onderaan het dashboard kan je tot op de dag nauwkeurig selecteren voor welke periode je de data wilt bekijken."),
                   
                   h5("Keuze tussen PM10 of PM2,5"),
                   p("Linksonder kan je een keuze maken tussen PM10, de grovere fijnstofdeeltjes, en PM2,5, de kleinere fijnstofdeeltjes. Beide keuzes hebben het achtervoegsel '_kal', wat een afkorting is voor 'gekalibreerd'. Voor meer informatie, zie het kopje 'Gekalibreerde waarden'."),
                   
                   h5("Verschillende plots bekijken"),
                   p("Als je één of meer sensoren en de gewenste periode heb geselecteerd, zijn er tabbladen waar je verschillende plots van de data kan bekijken. Voor elke plot wordt een korte toelichting met voorbeeld gegeven."),
                   
                   h5("Filteren van data met hoge luchtvochtigheid"),
                   p("In deze tool is het mogelijk om de meetwaarden van uren waarbij de luchtvochtigheid 97% of hoger is, uit de dataset te filteren. Dit kan je doen door het vinkje voor het vakje 'Filter hoge rh' aan te zetten."),
                   
               
               h3("Verantwoording"),
                           
                           p("Dit dashboard is door het ", a("RIVM", href = "https://rivm.nl", target = 'blank'), "ontwikkeld voor snelle analyse van sensordata.
                             Het maakt gebruik van de R-package",
                             a("openair.", 
                               href = "http://davidcarslaw.github.io/openair/", target="_blank"),
                             
                             p("Het huidige dashboard is een prototype en nog volop in ontwikkeling. 
                               Het wordt gebruikt om verschillende analyses en visualisaties te testen.
                               De broncode van de tool is te vinden via",
                              a("GitHub",
                                href = "https://github.com/rivm-syso/Samen-analyseren-tool", target = "_blank"),
                                ", zodat we samen met jullie het dashboard verder kunnen ontwikkelen."),
                             
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
                             )),
                           h3("Nieuw in deze tool"),
                           p("De tool is nog in ontwikkeling. Hieronder vindt u de laatste aanpassingen (sinds 12 juni 2020):"),
                            tags$ul(tags$li("Layout: grotere kaart beschikbaar"),
                           tags$li("Tijdreeksselectie: makkelijker vanaf een specifieke dag te filteren"),
                           tags$li("Groepsselectie: makkelijker de sensoren te clusteren in een groep zodat groepsgemiddeldes kunnen worden vergeleken"))
                           ),
             
  # Vanaf hier begint de tool zelf
  fluidPage=fluidPage(
    
  # wellPanel voor grijze boxing
  wellPanel(
  # Sidebar layout met input en output definities
  sidebarLayout(
    # Sidebar panel voor leaflet map om sensoren te selecteren
    sidebarPanel(width=3,
      
      # Button om de alles wat geselecteerd is te resetten
      actionButton("reset_all", "Reset alle sensoren"),
      br(),
      # Input: Selecteer de component uit de choices lijst
      selectInput(inputId = "Var", label = "Kies component:", choices = choices, selected = NULL, multiple = FALSE,
                selectize = TRUE, width = NULL, size = NULL),
      
      # Input: Blokjes voor de datum
      dateInput("DateStart", label="Selecteer begin tijdreeks:", format='dd-mm-yyyy',value = min(input_df$date), 
                min = min(input_df$date), max = max(input_df$date)),
      dateInput("DateEind", label="Selecteer einde tijdreeks:", format='dd-mm-yyyy', value = max(input_df$date), 
                min = min(input_df$date), max = max(input_df$date)),
      checkboxInput('filter_rh','Filter hoge rh.', width = NULL, value = TRUE),
      
      br(),

      # Input: Tekst voor de groepselectie
      textInput(inputId = "Text_groep",'Maak nieuwe groep:', value = ''),
      # Input: kies groep uit lijst bestaande groepen (gaat via een selectInput)
      uiOutput("bestaande_groep"),
      # Button: knop om de selectie aan de groep toe te voegen
      actionButton("groeperen", "Groepeer selectie"),
      
      # Button om de huidige selectie van sensoren te resetten
      actionButton("reset_huidig", "Reset selectie"),
      
      # Output: tabel met de geslecteerde kitids, voor toekenning aan groep
      tableOutput("huidig")
      ),
    
    # Main panel voor outputs
    mainPanel(width=9,
      #Output: Leaflet map voor sensorselectie
      leafletOutput("map", height = "300px"),
      # Output: Tabset voor openair plots, zie voor de inhoud het script: tabPanels.R
      tabsetPanel(type = "tabs",
                  tpGrafiek(),
                  tpKalender(),
                  tpTimevariation(),
                  tpPolarPlot(),
                  tpPercentileRose(),
                  tpPollutionRose(),
                  tpWindRose(),
                  tpOverzicht(),
                  tpVerantwoording()
      )
      
    ) 
    ),
  )
)
)
