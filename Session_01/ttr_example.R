## Lese die ganze Datei als eine Sammlung von Zeilen ein.
lines <- readLines('../data/t_990505_47.xml')

## Finde die Positionsnummern von allen Tokens
## (d.h. Zeilen, die mit "<t " beginnen).
token.indexes <- grep('<t ', lines)

## W�hle alle Zeilen mit Tokens aus.
tokens <- lines[token.indexes]

## L�sche alles vor dem Lemma.
junk.lemmas <- sub(".+ lemma=\"", "", tokens)

## L�sche alles nach dem Lemma.
lemmas <- sub("\".+", "", junk.lemmas)

## Anzahl der Types ist gleich Null.
types.count <- 0

## Noch keine Types gesehen.
seen.types <- NULL

## Lege eine Liste f�r Typesanzahl f�r jede Stelle im Text an.
types.on.position <- vector(length = length(lemmas))

## F�r jede Lemmanummer
for (i in seq_along(lemmas)) {

    ## suche das ensprechende Lemma,
    lemma <- lemmas[i]

    ## und, falls es noch nicht gesehen wurde,
    if (!(lemma %in% seen.types)) {

        ## z�hle es als neu mit,
        types.count <- types.count + 1
        ## und lege es in die Liste der gesehenen Lemmata ab.
        seen.types <- c(seen.types, lemma)
    }

    ## F�ge die Anzahl f�r die aktuelle Lemmanummer in die Liste ein.
    types.on.position[i] <- types.count
}

## Zeichne eine Graphik.
plot(types.on.position, type = 'l',
     ylab = "Anzahl der einmaligen Lemmata",
     xlab = "Laufende Wortform",
     col = 'red')
