# WeatherApp-CSA
Клиент-серверные IOS-приложения, Firebase

Приложение для просмотра текущей погоды: 
- для получения данных используется API запрос сервису openweathermap.com, 
- для хранения, чтения и обновления данных используется Firebase

Для входа в приложение необходимо воспользоваться формой регистрации (email и пароль) 
  или использовать тестовые данные (test@test.com, 123456), данные хранятся в Firebase-Authentication;
  для выхода из аккаунта воспользуйтесь кнопкой logOut на экране списка городов

На следующем экране доступен список городов, можно добавить новый город, воспользовавшись кнопкой +, 
   также город можно удалить, воспользовавшись свайпом влево по ячейке
   
По нажатию на ячейку города осуществляется переход на экран погоды, данные хранятся в Firebase-Firestore

Для первого запуска приложения, возможно, понадобится установить/обновить pod-ы

  =====================
  
Weather app:
- to obtain data, an API request to the openweathermap.com service is used,
- Firebase is used to store, read and update data

To enter the application, you must use the registration form (email address and password)
   or use test data (test@test.com, 123456), data is stored in Firebase-Authentication;
   to log out of your account use the "logout" button on the city list screen

On the next screen, a list of cities is available, you can add a new city using the "+" button,
    You can also remove a city by swiping left on a cell
    
By clicking on the city cell, you go to the weather screen, the data is saved in Firebase-Firestore

For the first launch of the application, you may need to install / update pods
