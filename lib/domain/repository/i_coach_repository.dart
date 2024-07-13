import 'package:app1/domain/model/collection_view.dart';
import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/model/workout/workout.dart';

abstract class ICoachRepository {

  Future<List<AppUser>> searchCoach(String searchText);

  Future<AppUser> getCoachInfo(String coachId);

  Future<void> requestCoach(AppUser coach);

  Future<void> removeCoach(AppUser coach);

  Future<List<CollectionView>> getCoachCollectionViewList(List<String> listCollectionsId);

  Future<Workout?> getInfoAboutScheduledWorkout();

  Future<void> startScheduledWorkout(Workout workout);
}
