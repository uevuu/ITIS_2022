# Домашняя/классая работа

https://www.figma.com/file/ixe7KnsqQUqHIBcj55X3jv/Untitled?node-id=0%3A1

1. Экран входа (должна быть валидация пароля/логина)
2. После авторизации модально показываем таб бар с двумя табами
3. Первый таб — {tab: home}, 
    * по нажатию на Browse catalog пушим в navigation stack экраны “Catalog, Page: {x}”, где x - номер экрана в очереди
    * по нажатию на “Animal images” появляется модалка с какой-нибудь картинкой из Assets
4. Второй таб — {tab: exit} — экран, на котором пишется ваш юзернейм и есть кнопка, которая
закрывает модально показанный таб бар

Чтобы показать алерт, вам пригодится [UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
