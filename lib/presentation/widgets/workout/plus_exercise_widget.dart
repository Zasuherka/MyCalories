import 'package:app1/domain/enums/exercise_case.dart';
import 'package:app1/domain/model/workout/exercise.dart';
import 'package:app1/internal/cubit/workout_cubit/workout_cubit.dart';
import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlusExerciseWidget extends StatefulWidget {
  final List<Exercise> training;
  final bool Function() isActive;
  const PlusExerciseWidget({
    super.key,
    required this.isActive,
    required this.training,
  });

  @override
  State<PlusExerciseWidget> createState() => _PlusExerciseWidgetState();
}

class _PlusExerciseWidgetState extends State<PlusExerciseWidget> {
  late FocusNode _node;
  bool _focused = false;
  final _containerKey = GlobalKey();
  late FocusAttachment _nodeAttachment;
  TextStyle? textStyle;
  OverlayEntry? _overlayEntry;

  void createHighlightOverlay(){
    _overlayEntry = OverlayEntry(builder: (BuildContext context) {
      final renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      return Positioned(
        left: offset.dx,
        top: offset.dy + 77,
        child: TapRegion(
          onTapOutside: (_) => _node.unfocus(),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
                color: AppColors.elementColor,
                boxShadow: boxShadow,
                borderRadius: BorderRadius.circular(30)
            ),
            child: _focused ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<WorkoutCubit>()
                        .addNewExerciseSet(widget.training, ExerciseCase.set);
                    _node.unfocus();
                  },
                  child: Container(
                    width: 400,
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      ExerciseCase.set.exerciseCase,
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<WorkoutCubit>()
                        .addNewExerciseSet(widget.training, ExerciseCase.roundSet);
                    _node.unfocus();
                  },
                  child: Container(
                    width: 400,
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      ExerciseCase.roundSet.exerciseCase,
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<WorkoutCubit>()
                        .addNewExerciseSet(widget.training, ExerciseCase.cardio);
                    _node.unfocus();
                  },
                  child: Container(
                    width: 400,
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      ExerciseCase.cardio.exerciseCase,
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )  : const SizedBox(),
          ),
        ),
      );
    });
    Overlay.of(context, debugRequiredFor: widget).insert(_overlayEntry!);
  }

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Button');
    _node.addListener(_handleFocusChange);
    _nodeAttachment = _node.attach(context, onKeyEvent: _handleKeyPress);
  }


  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      setState(() {
        if(!_node.hasFocus){
          _overlayEntry?.remove();
          _overlayEntry?.dispose();
          _overlayEntry = null;
        }
        else{
          createHighlightOverlay();
        }
        _focused = _node.hasFocus;
      });
    }
  }

  KeyEventResult _handleKeyPress(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyR) {
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.keyG) {
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.keyB) {
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _node.removeListener(_handleFocusChange);
    _node.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    textStyle = Theme.of(context).textTheme.titleMedium;
    _nodeAttachment.reparent();
    return GestureDetector(
      key: _containerKey,
      onTap: () {
        if (widget.isActive.call()) {
          if (_focused) {
            _node.unfocus();
          } else {
            _node.requestFocus();
          }
        }
      },
      child: SvgPicture.asset(
        'images/plus.svg',
        height: 36,
        colorFilter: const ColorFilter.mode(
            AppColors.grey,
            BlendMode.srcIn
        ),
      ),
    );
  }
}
