import React from 'react'
import { SmallText,BigText } from './InfoSectionDecararion'

const index = () => {
  return (
      <SmallText>
        <BigText>O projekcie</BigText>
        Celem aplikacji jest zbieranie podpisanych zdjęć żywności,
        które potem użyjemy do uczenia modelu sieci neuronowej, której zadaniem
        będzie rozpoznawanie jedzenia na podstwie zdjęć.
        Dziękujemy za wkład i poświęcony czas. <br></br><br></br>
        <BigText>Instrukcja</BigText>
        W podstronie "Dodaj potrawę", znajduję się przycisk "Wybierz zdjęcie", użyj go aby
        wybrać zdjęcie z galerii albo zrobić je aparatem. Następnie podpisz zdjęcie używając pola do wprowadzania
        tekstu. Jeśli nazwa potrawy, którą chcesz wprowadzić znajduję się w panelu sugestii, skorzystaj z podpowiedzi.
        Po wprowadzeniu nazwy i obrazka, kliknij przycisk wyślij.
        <br>
        </br>
        <br>
        </br>
        <br>
        </br>
        <br>
        </br>
      </SmallText>
  )
}

export default index