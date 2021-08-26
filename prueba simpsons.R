personaje <- c('Marge', 'Homerito26', 'Lisa', 'Apu', 'Bart')
personaje2 <- c('Marge', 'Homerito26', 'Lisa', 'Apu', 'Bart','KITTEN','mickey','trucha')

if(length(personaje) >  length(personaje2)){
  personaje = personaje[-c(length(personaje2):length(personaje))]
}
if(length(personaje2) >  length(personaje)){
  personaje2 = personaje2[-c(length(personaje):length(personaje2))]
}
personaje2