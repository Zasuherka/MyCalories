import 'package:app1/domain/model/user.dart';
import 'package:app1/domain/model/workout/workout.dart';

abstract class IWardRepository{

  Future<List<AppUser>> getWardRequestsList();

  Future<List<AppUser>> getWardsList();

  Future<void> replyWard(AppUser ward, bool reply);

  Future<void> sendWorkout(Workout workout, AppUser ward);

  Future<void> removeWard(AppUser ward);

  Future<List<Workout>> getCompletedWorkouts(String userId);
}