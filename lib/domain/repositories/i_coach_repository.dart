import 'package:app1/domain/models/app_user.dart';

abstract class ICoachRepository {

  Future<void> sendRequestForCoach({
    required String coachId
  });

  Future<List<AppUser>> searchCoach({
    required String searchText
  });

  Future<AppUser> getInfoAboutCoach();

  Future<void> removeCoach();
}