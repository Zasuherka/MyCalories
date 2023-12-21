enum AuthorizationStatus{
  successful('Авторизация прошла успешно'),
  userNotFound('Пользователь с этой почтой не найден'),
  wrongPassword('Неверный пароль'),
  networkRequestFailed('Ошибка подключения'),
  errorFields('Не все поля заполнены'),
  errorVerified('Ваша учётная запись не подтверждена'),
  error('Неизвестная ошибка');


  final String authorizationStatus;

  const AuthorizationStatus(this.authorizationStatus);
}
