// ignore_for_file: annotate_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

Map<String, String> namedColors = {
  "White": "#FFFFFF",
  "Silver": "#C0C0C0",
  "Gray": "#808080",
  "Black": "#000000",
  "Red": "#FF0000",
  "Maroon": "#800000",
  "Yellow": "#FFFF00",
  "Olive": "#808000",
  "Lime": "#00FF00",
  "Green": "#008000",
  "Aqua": "#00FFFF",
  "Teal": "#008080",
  "Blue": "#0000FF",
  "Navy": "#000080",
  "Fuchsia": "#FF00FF",
  "Purple": "#800080",
};

class Context<T> {
  T data;

  Context(this.data);
}

// This class is a workaround so that both an image
// and a link can detect taps at the same time.
class MultipleTapGestureDetector extends InheritedWidget {
  final void Function()? onTap;
  final void Function()? onTapDown;
  final void Function()? onTapUp;

  const MultipleTapGestureDetector({
    Key? key,
    required Widget child,
    required this.onTap,
    required this.onTapDown,
    required this.onTapUp,
  }) : super(key: key, child: child);

  static MultipleTapGestureDetector? of(BuildContext context) {
    
    return context
        .dependOnInheritedWidgetOfExactType<MultipleTapGestureDetector>();
  }

  static void ofOnTap(BuildContext context) 
  {
    final widget = of(context);
    if (widget != null && widget.onTap != null) {
      widget.onTap!();
    }
  }

  static void ofOnTapDown(BuildContext context) 
  {
    final widget = of(context);
    if (widget != null && widget.onTapDown != null) {
      widget.onTapDown!();
    }
  }

  static void ofOnTapUp(BuildContext context) 
  {
    try
    {
    final widget = of(context);
    if (widget != null && widget.onTapUp != null) {
      widget.onTapUp!();
    }
    }
    /*catch(e)
    {
      print(e);
    }*/
    finally
    {
      //print('finally');
    }
  }

  @override
  bool updateShouldNotify(MultipleTapGestureDetector oldWidget) => false;
}

class MultipleTapGestureWidget extends StatefulWidget
{
  final void Function()? onTap;
  final Widget child;
  //final Key? key;

  // ignore: use_key_in_widget_constructors
  const MultipleTapGestureWidget({super.key,this.onTap,required this.child});

  @override
  State<MultipleTapGestureWidget> createState() => _MultipleTapGestureWidgetState();

}

class _MultipleTapGestureWidgetState extends State<MultipleTapGestureWidget> {
  bool isDown = false;
  Widget? result;



  @override
  Widget build(BuildContext context) 
  {
    if (widget.onTap == null)
    {
      result =  widget.child;
    }
    else
    {
      result = MultipleTapGestureDetector(
        onTap: onTap,
        onTapDown: () => setState(() => isDown = true),
        onTapUp: () => setState(() => isDown = false),
        child: GestureDetector(
          //key: widget.key,
          onTap: onTap,
          child: isDown ? 
            ColorFiltered( colorFilter: ColorFilter.mode(Color.fromARGB(80,80,80,80), BlendMode.srcOver), 
                           child: widget.child,) : 
            widget.child,
      ));
    }

    return result!;
  }

  @nonVirtual
  void onTap() 
  {
    setState(() {
      isDown = false;
    });

    widget.onTap?.call();
  }
}

class CustomBorderSide {
  CustomBorderSide({
    this.color = const Color(0xFF000000),
    this.width = 1.0,
    this.style = BorderStyle.none,
  }) : assert(width >= 0.0);

  Color? color;
  double width;
  BorderStyle style;
}

extension TextTransformUtil on String? {
  String? transformed(TextTransform? transform) {
    if (this == null) return null;
    if (transform == TextTransform.uppercase) {
      return this!.toUpperCase();
    } else if (transform == TextTransform.lowercase) {
      return this!.toLowerCase();
    } else if (transform == TextTransform.capitalize) {
      final stringBuffer = StringBuffer();

      var capitalizeNext = true;
      for (final letter in this!.toLowerCase().codeUnits) {
        // UTF-16: A-Z => 65-90, a-z => 97-122.
        if (capitalizeNext && letter >= 97 && letter <= 122) {
          stringBuffer.writeCharCode(letter - 32);
          capitalizeNext = false;
        } else {
          // UTF-16: 32 == space, 46 == period
          if (letter == 32 || letter == 46) capitalizeNext = true;
          stringBuffer.writeCharCode(letter);
        }
      }

      return stringBuffer.toString();
    } else {
      return this;
    }
  }
}
