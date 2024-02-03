enum RegistrationStatus{
  successful('Регистрация прошла успешно'),
  weakPassword('Пароль ненадёжный'),
  emailAlreadyInUs('Данная электронная почта уже используется'),
  errorPassword('Пароли не совпадают'),
  errorFields('Не все поля заполнены'),
  networkRequestFailed('Ошибка подключения'),
  error('Неизвестная ошибка');


  final String registrationStatus;

  const RegistrationStatus(this.registrationStatus);
}
