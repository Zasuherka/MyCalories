// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_workout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CurrentWorkoutEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCurrentTraining,
    required TResult Function(Exercise exercise) addExercise,
    required TResult Function(Exercise exercise) deleteExercise,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCurrentTraining,
    TResult? Function(Exercise exercise)? addExercise,
    TResult? Function(Exercise exercise)? deleteExercise,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCurrentTraining,
    TResult Function(Exercise exercise)? addExercise,
    TResult Function(Exercise exercise)? deleteExercise,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCurrentTraining value) getCurrentTraining,
    required TResult Function(_AddExercise value) addExercise,
    required TResult Function(_DeleteCurrentTraining value) deleteExercise,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCurrentTraining value)? getCurrentTraining,
    TResult? Function(_AddExercise value)? addExercise,
    TResult? Function(_DeleteCurrentTraining value)? deleteExercise,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCurrentTraining value)? getCurrentTraining,
    TResult Function(_AddExercise value)? addExercise,
    TResult Function(_DeleteCurrentTraining value)? deleteExercise,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWorkoutEventCopyWith<$Res> {
  factory $CurrentWorkoutEventCopyWith(
          CurrentWorkoutEvent value, $Res Function(CurrentWorkoutEvent) then) =
      _$CurrentWorkoutEventCopyWithImpl<$Res, CurrentWorkoutEvent>;
}

/// @nodoc
class _$CurrentWorkoutEventCopyWithImpl<$Res, $Val extends CurrentWorkoutEvent>
    implements $CurrentWorkoutEventCopyWith<$Res> {
  _$CurrentWorkoutEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetCurrentTrainingImplCopyWith<$Res> {
  factory _$$GetCurrentTrainingImplCopyWith(_$GetCurrentTrainingImpl value,
          $Res Function(_$GetCurrentTrainingImpl) then) =
      __$$GetCurrentTrainingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetCurrentTrainingImplCopyWithImpl<$Res>
    extends _$CurrentWorkoutEventCopyWithImpl<$Res, _$GetCurrentTrainingImpl>
    implements _$$GetCurrentTrainingImplCopyWith<$Res> {
  __$$GetCurrentTrainingImplCopyWithImpl(_$GetCurrentTrainingImpl _value,
      $Res Function(_$GetCurrentTrainingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GetCurrentTrainingImpl implements _GetCurrentTraining {
  const _$GetCurrentTrainingImpl();

  @override
  String toString() {
    return 'CurrentWorkoutEvent.getCurrentTraining()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetCurrentTrainingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCurrentTraining,
    required TResult Function(Exercise exercise) addExercise,
    required TResult Function(Exercise exercise) deleteExercise,
  }) {
    return getCurrentTraining();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCurrentTraining,
    TResult? Function(Exercise exercise)? addExercise,
    TResult? Function(Exercise exercise)? deleteExercise,
  }) {
    return getCurrentTraining?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCurrentTraining,
    TResult Function(Exercise exercise)? addExercise,
    TResult Function(Exercise exercise)? deleteExercise,
    required TResult orElse(),
  }) {
    if (getCurrentTraining != null) {
      return getCurrentTraining();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCurrentTraining value) getCurrentTraining,
    required TResult Function(_AddExercise value) addExercise,
    required TResult Function(_DeleteCurrentTraining value) deleteExercise,
  }) {
    return getCurrentTraining(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCurrentTraining value)? getCurrentTraining,
    TResult? Function(_AddExercise value)? addExercise,
    TResult? Function(_DeleteCurrentTraining value)? deleteExercise,
  }) {
    return getCurrentTraining?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCurrentTraining value)? getCurrentTraining,
    TResult Function(_AddExercise value)? addExercise,
    TResult Function(_DeleteCurrentTraining value)? deleteExercise,
    required TResult orElse(),
  }) {
    if (getCurrentTraining != null) {
      return getCurrentTraining(this);
    }
    return orElse();
  }
}

abstract class _GetCurrentTraining implements CurrentWorkoutEvent {
  const factory _GetCurrentTraining() = _$GetCurrentTrainingImpl;
}

/// @nodoc
abstract class _$$AddExerciseImplCopyWith<$Res> {
  factory _$$AddExerciseImplCopyWith(
          _$AddExerciseImpl value, $Res Function(_$AddExerciseImpl) then) =
      __$$AddExerciseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Exercise exercise});
}

/// @nodoc
class __$$AddExerciseImplCopyWithImpl<$Res>
    extends _$CurrentWorkoutEventCopyWithImpl<$Res, _$AddExerciseImpl>
    implements _$$AddExerciseImplCopyWith<$Res> {
  __$$AddExerciseImplCopyWithImpl(
      _$AddExerciseImpl _value, $Res Function(_$AddExerciseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercise = null,
  }) {
    return _then(_$AddExerciseImpl(
      exercise: null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as Exercise,
    ));
  }
}

/// @nodoc

class _$AddExerciseImpl implements _AddExercise {
  const _$AddExerciseImpl({required this.exercise});

  @override
  final Exercise exercise;

  @override
  String toString() {
    return 'CurrentWorkoutEvent.addExercise(exercise: $exercise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddExerciseImpl &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exercise);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddExerciseImplCopyWith<_$AddExerciseImpl> get copyWith =>
      __$$AddExerciseImplCopyWithImpl<_$AddExerciseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCurrentTraining,
    required TResult Function(Exercise exercise) addExercise,
    required TResult Function(Exercise exercise) deleteExercise,
  }) {
    return addExercise(exercise);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCurrentTraining,
    TResult? Function(Exercise exercise)? addExercise,
    TResult? Function(Exercise exercise)? deleteExercise,
  }) {
    return addExercise?.call(exercise);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCurrentTraining,
    TResult Function(Exercise exercise)? addExercise,
    TResult Function(Exercise exercise)? deleteExercise,
    required TResult orElse(),
  }) {
    if (addExercise != null) {
      return addExercise(exercise);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCurrentTraining value) getCurrentTraining,
    required TResult Function(_AddExercise value) addExercise,
    required TResult Function(_DeleteCurrentTraining value) deleteExercise,
  }) {
    return addExercise(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCurrentTraining value)? getCurrentTraining,
    TResult? Function(_AddExercise value)? addExercise,
    TResult? Function(_DeleteCurrentTraining value)? deleteExercise,
  }) {
    return addExercise?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCurrentTraining value)? getCurrentTraining,
    TResult Function(_AddExercise value)? addExercise,
    TResult Function(_DeleteCurrentTraining value)? deleteExercise,
    required TResult orElse(),
  }) {
    if (addExercise != null) {
      return addExercise(this);
    }
    return orElse();
  }
}

abstract class _AddExercise implements CurrentWorkoutEvent {
  const factory _AddExercise({required final Exercise exercise}) =
      _$AddExerciseImpl;

  Exercise get exercise;
  @JsonKey(ignore: true)
  _$$AddExerciseImplCopyWith<_$AddExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCurrentTrainingImplCopyWith<$Res> {
  factory _$$DeleteCurrentTrainingImplCopyWith(
          _$DeleteCurrentTrainingImpl value,
          $Res Function(_$DeleteCurrentTrainingImpl) then) =
      __$$DeleteCurrentTrainingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Exercise exercise});
}

/// @nodoc
class __$$DeleteCurrentTrainingImplCopyWithImpl<$Res>
    extends _$CurrentWorkoutEventCopyWithImpl<$Res, _$DeleteCurrentTrainingImpl>
    implements _$$DeleteCurrentTrainingImplCopyWith<$Res> {
  __$$DeleteCurrentTrainingImplCopyWithImpl(_$DeleteCurrentTrainingImpl _value,
      $Res Function(_$DeleteCurrentTrainingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercise = null,
  }) {
    return _then(_$DeleteCurrentTrainingImpl(
      exercise: null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as Exercise,
    ));
  }
}

/// @nodoc

class _$DeleteCurrentTrainingImpl implements _DeleteCurrentTraining {
  const _$DeleteCurrentTrainingImpl({required this.exercise});

  @override
  final Exercise exercise;

  @override
  String toString() {
    return 'CurrentWorkoutEvent.deleteExercise(exercise: $exercise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCurrentTrainingImpl &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exercise);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCurrentTrainingImplCopyWith<_$DeleteCurrentTrainingImpl>
      get copyWith => __$$DeleteCurrentTrainingImplCopyWithImpl<
          _$DeleteCurrentTrainingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getCurrentTraining,
    required TResult Function(Exercise exercise) addExercise,
    required TResult Function(Exercise exercise) deleteExercise,
  }) {
    return deleteExercise(exercise);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getCurrentTraining,
    TResult? Function(Exercise exercise)? addExercise,
    TResult? Function(Exercise exercise)? deleteExercise,
  }) {
    return deleteExercise?.call(exercise);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getCurrentTraining,
    TResult Function(Exercise exercise)? addExercise,
    TResult Function(Exercise exercise)? deleteExercise,
    required TResult orElse(),
  }) {
    if (deleteExercise != null) {
      return deleteExercise(exercise);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetCurrentTraining value) getCurrentTraining,
    required TResult Function(_AddExercise value) addExercise,
    required TResult Function(_DeleteCurrentTraining value) deleteExercise,
  }) {
    return deleteExercise(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetCurrentTraining value)? getCurrentTraining,
    TResult? Function(_AddExercise value)? addExercise,
    TResult? Function(_DeleteCurrentTraining value)? deleteExercise,
  }) {
    return deleteExercise?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetCurrentTraining value)? getCurrentTraining,
    TResult Function(_AddExercise value)? addExercise,
    TResult Function(_DeleteCurrentTraining value)? deleteExercise,
    required TResult orElse(),
  }) {
    if (deleteExercise != null) {
      return deleteExercise(this);
    }
    return orElse();
  }
}

abstract class _DeleteCurrentTraining implements CurrentWorkoutEvent {
  const factory _DeleteCurrentTraining({required final Exercise exercise}) =
      _$DeleteCurrentTrainingImpl;

  Exercise get exercise;
  @JsonKey(ignore: true)
  _$$DeleteCurrentTrainingImplCopyWith<_$DeleteCurrentTrainingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CurrentWorkoutState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(int index) emptyValueIndex,
    required TResult Function(String errorMessage) failure,
    required TResult Function(List<Exercise> listExercise) listExercise,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(int index)? emptyValueIndex,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(List<Exercise> listExercise)? listExercise,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(int index)? emptyValueIndex,
    TResult Function(String errorMessage)? failure,
    TResult Function(List<Exercise> listExercise)? listExercise,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EmptyValueIndex value) emptyValueIndex,
    required TResult Function(_Failure value) failure,
    required TResult Function(_ListExercise value) listExercise,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_ListExercise value)? listExercise,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult Function(_Failure value)? failure,
    TResult Function(_ListExercise value)? listExercise,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWorkoutStateCopyWith<$Res> {
  factory $CurrentWorkoutStateCopyWith(
          CurrentWorkoutState value, $Res Function(CurrentWorkoutState) then) =
      _$CurrentWorkoutStateCopyWithImpl<$Res, CurrentWorkoutState>;
}

/// @nodoc
class _$CurrentWorkoutStateCopyWithImpl<$Res, $Val extends CurrentWorkoutState>
    implements $CurrentWorkoutStateCopyWith<$Res> {
  _$CurrentWorkoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CurrentWorkoutStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CurrentWorkoutState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(int index) emptyValueIndex,
    required TResult Function(String errorMessage) failure,
    required TResult Function(List<Exercise> listExercise) listExercise,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(int index)? emptyValueIndex,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(List<Exercise> listExercise)? listExercise,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(int index)? emptyValueIndex,
    TResult Function(String errorMessage)? failure,
    TResult Function(List<Exercise> listExercise)? listExercise,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EmptyValueIndex value) emptyValueIndex,
    required TResult Function(_Failure value) failure,
    required TResult Function(_ListExercise value) listExercise,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_ListExercise value)? listExercise,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult Function(_Failure value)? failure,
    TResult Function(_ListExercise value)? listExercise,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CurrentWorkoutState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$CurrentWorkoutStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CurrentWorkoutState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(int index) emptyValueIndex,
    required TResult Function(String errorMessage) failure,
    required TResult Function(List<Exercise> listExercise) listExercise,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(int index)? emptyValueIndex,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(List<Exercise> listExercise)? listExercise,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(int index)? emptyValueIndex,
    TResult Function(String errorMessage)? failure,
    TResult Function(List<Exercise> listExercise)? listExercise,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EmptyValueIndex value) emptyValueIndex,
    required TResult Function(_Failure value) failure,
    required TResult Function(_ListExercise value) listExercise,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_ListExercise value)? listExercise,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult Function(_Failure value)? failure,
    TResult Function(_ListExercise value)? listExercise,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CurrentWorkoutState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$CurrentWorkoutStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl();

  @override
  String toString() {
    return 'CurrentWorkoutState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(int index) emptyValueIndex,
    required TResult Function(String errorMessage) failure,
    required TResult Function(List<Exercise> listExercise) listExercise,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(int index)? emptyValueIndex,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(List<Exercise> listExercise)? listExercise,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(int index)? emptyValueIndex,
    TResult Function(String errorMessage)? failure,
    TResult Function(List<Exercise> listExercise)? listExercise,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EmptyValueIndex value) emptyValueIndex,
    required TResult Function(_Failure value) failure,
    required TResult Function(_ListExercise value) listExercise,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_ListExercise value)? listExercise,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult Function(_Failure value)? failure,
    TResult Function(_ListExercise value)? listExercise,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements CurrentWorkoutState {
  const factory _Success() = _$SuccessImpl;
}

/// @nodoc
abstract class _$$EmptyValueIndexImplCopyWith<$Res> {
  factory _$$EmptyValueIndexImplCopyWith(_$EmptyValueIndexImpl value,
          $Res Function(_$EmptyValueIndexImpl) then) =
      __$$EmptyValueIndexImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$EmptyValueIndexImplCopyWithImpl<$Res>
    extends _$CurrentWorkoutStateCopyWithImpl<$Res, _$EmptyValueIndexImpl>
    implements _$$EmptyValueIndexImplCopyWith<$Res> {
  __$$EmptyValueIndexImplCopyWithImpl(
      _$EmptyValueIndexImpl _value, $Res Function(_$EmptyValueIndexImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$EmptyValueIndexImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$EmptyValueIndexImpl implements _EmptyValueIndex {
  const _$EmptyValueIndexImpl({required this.index});

  @override
  final int index;

  @override
  String toString() {
    return 'CurrentWorkoutState.emptyValueIndex(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmptyValueIndexImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmptyValueIndexImplCopyWith<_$EmptyValueIndexImpl> get copyWith =>
      __$$EmptyValueIndexImplCopyWithImpl<_$EmptyValueIndexImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(int index) emptyValueIndex,
    required TResult Function(String errorMessage) failure,
    required TResult Function(List<Exercise> listExercise) listExercise,
  }) {
    return emptyValueIndex(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(int index)? emptyValueIndex,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(List<Exercise> listExercise)? listExercise,
  }) {
    return emptyValueIndex?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(int index)? emptyValueIndex,
    TResult Function(String errorMessage)? failure,
    TResult Function(List<Exercise> listExercise)? listExercise,
    required TResult orElse(),
  }) {
    if (emptyValueIndex != null) {
      return emptyValueIndex(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EmptyValueIndex value) emptyValueIndex,
    required TResult Function(_Failure value) failure,
    required TResult Function(_ListExercise value) listExercise,
  }) {
    return emptyValueIndex(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_ListExercise value)? listExercise,
  }) {
    return emptyValueIndex?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult Function(_Failure value)? failure,
    TResult Function(_ListExercise value)? listExercise,
    required TResult orElse(),
  }) {
    if (emptyValueIndex != null) {
      return emptyValueIndex(this);
    }
    return orElse();
  }
}

abstract class _EmptyValueIndex implements CurrentWorkoutState {
  const factory _EmptyValueIndex({required final int index}) =
      _$EmptyValueIndexImpl;

  int get index;
  @JsonKey(ignore: true)
  _$$EmptyValueIndexImplCopyWith<_$EmptyValueIndexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$CurrentWorkoutStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$FailureImpl(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl({required this.errorMessage});

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'CurrentWorkoutState.failure(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(int index) emptyValueIndex,
    required TResult Function(String errorMessage) failure,
    required TResult Function(List<Exercise> listExercise) listExercise,
  }) {
    return failure(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(int index)? emptyValueIndex,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(List<Exercise> listExercise)? listExercise,
  }) {
    return failure?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(int index)? emptyValueIndex,
    TResult Function(String errorMessage)? failure,
    TResult Function(List<Exercise> listExercise)? listExercise,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EmptyValueIndex value) emptyValueIndex,
    required TResult Function(_Failure value) failure,
    required TResult Function(_ListExercise value) listExercise,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_ListExercise value)? listExercise,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult Function(_Failure value)? failure,
    TResult Function(_ListExercise value)? listExercise,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements CurrentWorkoutState {
  const factory _Failure({required final String errorMessage}) = _$FailureImpl;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListExerciseImplCopyWith<$Res> {
  factory _$$ListExerciseImplCopyWith(
          _$ListExerciseImpl value, $Res Function(_$ListExerciseImpl) then) =
      __$$ListExerciseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Exercise> listExercise});
}

/// @nodoc
class __$$ListExerciseImplCopyWithImpl<$Res>
    extends _$CurrentWorkoutStateCopyWithImpl<$Res, _$ListExerciseImpl>
    implements _$$ListExerciseImplCopyWith<$Res> {
  __$$ListExerciseImplCopyWithImpl(
      _$ListExerciseImpl _value, $Res Function(_$ListExerciseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listExercise = null,
  }) {
    return _then(_$ListExerciseImpl(
      listExercise: null == listExercise
          ? _value._listExercise
          : listExercise // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
    ));
  }
}

/// @nodoc

class _$ListExerciseImpl implements _ListExercise {
  const _$ListExerciseImpl({required final List<Exercise> listExercise})
      : _listExercise = listExercise;

  final List<Exercise> _listExercise;
  @override
  List<Exercise> get listExercise {
    if (_listExercise is EqualUnmodifiableListView) return _listExercise;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listExercise);
  }

  @override
  String toString() {
    return 'CurrentWorkoutState.listExercise(listExercise: $listExercise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListExerciseImpl &&
            const DeepCollectionEquality()
                .equals(other._listExercise, _listExercise));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_listExercise));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListExerciseImplCopyWith<_$ListExerciseImpl> get copyWith =>
      __$$ListExerciseImplCopyWithImpl<_$ListExerciseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(int index) emptyValueIndex,
    required TResult Function(String errorMessage) failure,
    required TResult Function(List<Exercise> listExercise) listExercise,
  }) {
    return listExercise(this.listExercise);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(int index)? emptyValueIndex,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(List<Exercise> listExercise)? listExercise,
  }) {
    return listExercise?.call(this.listExercise);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(int index)? emptyValueIndex,
    TResult Function(String errorMessage)? failure,
    TResult Function(List<Exercise> listExercise)? listExercise,
    required TResult orElse(),
  }) {
    if (listExercise != null) {
      return listExercise(this.listExercise);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_EmptyValueIndex value) emptyValueIndex,
    required TResult Function(_Failure value) failure,
    required TResult Function(_ListExercise value) listExercise,
  }) {
    return listExercise(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_ListExercise value)? listExercise,
  }) {
    return listExercise?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_EmptyValueIndex value)? emptyValueIndex,
    TResult Function(_Failure value)? failure,
    TResult Function(_ListExercise value)? listExercise,
    required TResult orElse(),
  }) {
    if (listExercise != null) {
      return listExercise(this);
    }
    return orElse();
  }
}

abstract class _ListExercise implements CurrentWorkoutState {
  const factory _ListExercise({required final List<Exercise> listExercise}) =
      _$ListExerciseImpl;

  List<Exercise> get listExercise;
  @JsonKey(ignore: true)
  _$$ListExerciseImplCopyWith<_$ListExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
