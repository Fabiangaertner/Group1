#Eksamensoppgave for gruppe 1. RMED901
#Forfattere: Fabian Gartner, Anna Kleppe Moe og Silje Johansen
#Opprettet 09.09.24
#Sist oppdatert 09.09.24
.

1.Lage felles repository og nytt prosjekt i R-studi. Systematisere filene i en naturlig struktur med tilgang for alle;
# Ene gruppemedlemet opprettet et nytt repository på github; kalt group1
# Gruppeoppretter deler med øvrig medlemmer
# Samtlige gruppemeldlemmer ser at det er registrert og mottatt innbydelse i github. 
# Ene gruppemedlem åpner nytt prosjekt i R studio, Group1, via version control og bruker SSH-kode funnet i github ved repository
# Øvrig medlem åpner nytt prosjekt og henter da samme versjon via SSH nøkkel og version control.
# Se til at alle har et R psojekt med samme titulering av versjon, vanligvis master
# Ene gruppemedlem laster ned samtlige filer fra nett som hører til oppgave
# Ulike filer lagres i ulike mapper systematisk.Fx egen datafil
# Ene gruppemedlem lager en ny scriptfil koding samt en README fil for beskrivelse
# Samtlige filer krysses av i git for staged- comit og til slutt push
# Øvrig gruppemedlem ser oppdatert versjon i github.
# Øvrig gruppemedlem kan pull via git i R studio og få siste versjon av filer og mappesortering

2.Lese og rydde datasettet;
# Åpne aktuelle bibliotek for å rydde aktuelt datasett
# I eksamensoppgave library(tidyverse) og library(here)
# read funksjon for å lese datasettet. 
# here bibliotek lager forkortet veg som må presiseres for hvor finne datasett, se kode for spesifikasjon
# Lag et eget navn på nytt objekt som inneholder nedlastet data
# se at data, med eget nytt navn(her; dataset) kjem som obejekt i environment

# Få oversikt på nedlastet data og utføre endringer for bedre struktur
# I datasettet er noen pasienter ført flere ganger, bla pga variabelen feature type som inneholder både race og sex
# Endrer variabelnavn for å hindre dobbeltføring
# 