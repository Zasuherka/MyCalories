abstract class Exercise{
  String title;

  Exercise({required this.title});

  bool get isNotValid{
    throw Exception('$runtimeType не переопределяет [isValid]');
  }

  Map<String, dynamic> toFirebase();
}