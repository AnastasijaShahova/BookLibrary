# BookLibrary

Приложение имеет несколько экранов: 

1.Экран логина (см screen1)    

Экран имеет два поля: email и password. После ввода логин и пароль, происходит обращение к keyChain для сопоставления данных, а так же проверка на существование юзера. Так же добавлена обработка ввода пустых строк.    
После успешной авторизации пользователь попадает на Экран3

2.Экран регистрации (см screen2)    

Экран имеет два поля: email и password. После ввода логин и пароль, происходит обработка корректности email, password,а так же на существования юзера в keyChain.        
После успешной регистрации пользователь попадает на Экран3

3.Экран с отображением списка книг (см screen3)    

Отображается список книг: название, автор и рейтинг. Данные парсятся с API https://demo.api-platform.com/docs    
Так же есть кнопка logout, которая вернет пользователя на Экран1

<img width="397" alt="Снимок экрана 2023-11-03 в 17 47 13" src="https://github.com/AnastasijaShahova/BookLibrary/assets/70802206/4ff2fabe-7b73-4f74-85ec-448ff74a283e">
<img width="402" alt="Снимок экрана 2023-11-03 в 17 47 21" src="https://github.com/AnastasijaShahova/BookLibrary/assets/70802206/3d62f5a3-bb8e-4aa3-9dbb-47ed4b54d413">
<img width="407" alt="Снимок экрана 2023-11-03 в 17 47 30" src="https://github.com/AnastasijaShahova/BookLibrary/assets/70802206/078238e3-8d22-4ded-aacd-9a95ece8029c">
