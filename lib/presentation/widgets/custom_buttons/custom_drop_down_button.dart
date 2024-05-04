import 'package:app1/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDropDownButton extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String value;
  final List<String> listValues;
  final String? labelText;
  final double? itemWidth;
  final double? itemHeight;
  final Color borderColor;
  final GestureTapCallback onTap;
  const CustomDropDownButton({
    super.key,
    required this.onChanged,
    required this.value,
    required this.listValues,
    this.labelText,
    this.itemWidth,
    this.itemHeight,
    required this.borderColor,
    required this.onTap
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
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
        child: Container(
          width: renderBox.size.width,
          decoration: BoxDecoration(
              color: AppColors.elementColor,
              boxShadow: boxShadow,
              borderRadius: BorderRadius.circular(30)
          ),
          child: _focused ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(widget.listValues.length, (index) =>
                GestureDetector(
                  onTap: () {
                    widget.onChanged(widget.listValues[index]);
                    _node.unfocus();
                  },
                  child: Container(
                    width: widget.itemWidth,
                    height: (widget.itemHeight ?? 45),
                    alignment: Alignment.center,
                    child: Text(
                      widget.listValues[index],
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ),
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
    textStyle = Theme.of(context).textTheme.titleMedium;
    _nodeAttachment.reparent();
    return GestureDetector(
        key: _containerKey,
        onTap: () {
          widget.onTap();
          if (_focused) {
            _node.unfocus();
          } else {
            _node.requestFocus();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 74,
              padding: const EdgeInsets.only(top: 7, left: 20),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: widget.borderColor,
                      width: 1
                  )
              ),
              child: Column(
                children: [
                  widget.labelText != null
                      ? SizedBox(
                          width: widget.itemWidth ?? 180,
                          child: Text(
                            widget.labelText!,
                            textScaler: const TextScaler.linear(0.75),
                            style: textStyle
                          ),
                        )
                      : const SizedBox(),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: widget.itemWidth,
                    child: Text(
                      widget.value,
                      style: textStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
