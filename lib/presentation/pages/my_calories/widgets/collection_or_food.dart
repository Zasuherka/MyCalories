import 'package:app1/internal/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/presentation/constants.dart';
import 'package:app1/presentation/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CollectionOrFoodDropDown extends StatefulWidget {
  final String title;
  const CollectionOrFoodDropDown({super.key, required this.title});

  @override
  State<CollectionOrFoodDropDown> createState() => _CollectionOrFoodDropDownState();
}

class _CollectionOrFoodDropDownState extends State<CollectionOrFoodDropDown> {

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
        left: offset.dx - 150,
        top: offset.dy + 35,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.elementColor,
              boxShadow: boxShadow,
              borderRadius: BorderRadius.circular(30)
          ),
          child: _focused ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _node.unfocus();
                  context.router.push(MyFoodRoute(isAddEatingFood: true));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10
                  ),
                  child: Text(
                      'Из списка еды',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _node.unfocus();
                  context.router.push(CollectionsRoute(isAddEatingFood: true));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10
                  ),
                  child: Text(
                      'Из наборов',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center
                  ),
                ),
              ),

            ]
          )  : const SizedBox(),
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
      debugPrint(
          'Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
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
    _nodeAttachment.reparent();
    return GestureDetector(
      key: _containerKey,
      onTap: () {
        BlocProvider.of<EatingFoodBloc>(context)
            .add(EatingFoodEvent.getNameEating(nameEating: widget.title));
        if (_focused) {
          _node.unfocus();
        } else {
          _node.requestFocus();
        }
      },
      child: SvgPicture.asset(
        'images/plus2.svg',
        width: 25,
        height: 25,
        colorFilter: const ColorFilter.mode(AppColors.turquoise , BlendMode.srcIn),
      ),
    );
  }
}
