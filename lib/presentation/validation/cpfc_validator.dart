mixin CPFCValidator{
  bool cpfcValidator(String value){
    final patternRegExp = RegExp(r'[0-9]');
    if(patternRegExp.hasMatch(value) && value.isNotEmpty && value.length <=5){
      return true;
    }
    return false;
  }
}