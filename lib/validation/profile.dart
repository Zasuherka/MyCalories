mixin ProfileValidationMixin {
  RegExp patternPassword =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  String? isPasswordValid(String? password) {
    if (password == null || password == ''){
      return 'Пароль должен быть заполнен';
    }
    else if(!patternPassword.hasMatch(password)){
      return 'Пароль должен содержать минимум 1 строчный символ, минимум 1 прописной символ, минимум одну цифру и длинну от 8 символов';
    } else {
      return null;
    }
  }

  RegExp patternEmail =
  RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))');
  String? isEmailValid(String? email) {
    if (email == null || email == ''){
      return 'Почта должна быть заполна';
    }
    else if(!patternEmail.hasMatch(email)){
      return 'Неправильный формат почты';
    } else {
      return null;
    }
  }

  bool isNameValid(String? name) => name != null && (name.length >= 6 && name.length <= 20);
  bool isWeightValid(String? weight) => weight != null && (weight != '' && weight.isNotEmpty && double.parse(weight) > 1.0 && double.parse(weight) < 300.0);
  bool isHeightValid(String? height) => height != null && (height.length >= 2 && height.length <= 3);
  bool isDateValid(DateTime? date) => date != null;
}