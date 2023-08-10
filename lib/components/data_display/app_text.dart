import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum TextStyles {
  headlineMedium,
  titleMedium,
  bodyMedium,
  bodySmall,
  displayMedium,
}

class AppText extends StatefulWidget {
  const AppText(
    this.text, {
    Key? key,
    this.color,
    this.readMore = false,
    this.bold,
    this.regular,
    this.medium,
    this.allowExpand = true,
    this.italic = false,
    this.textAlign,
    this.maxLength,
    this.maxLines,
    this.style,
    this.strutStyle,
    this.fontSize,
    this.textDecoration,
    this.letterSpacing,
    this.lineHeight,
    this.fontWeight,
    this.decorationStyle,
    this.decorationThickness,
  }) : super(key: key);
  final String text;
  final Color? color;
  final bool? bold;
  final bool? regular;
  final bool? medium;
  final int? maxLength;
  final bool italic;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final int? maxLines;
  final TextStyles? style;
  final bool allowExpand;
  final StrutStyle? strutStyle;
  final double? fontSize;
  final double? letterSpacing;
  final double? lineHeight;
  final TextDecoration? textDecoration;
  final bool readMore;

  @override
  _AppTextState createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  String text = "";
  bool hidden = false;

  @override
  void didUpdateWidget(AppText oldWidget) {
    if (widget.style == TextStyles.displayMedium) {
      setState(() {
        text = widget.text.toUpperCase();
      });
    } else {
      setState(() {
        text = widget.text;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    if (widget.style == TextStyles.displayMedium) {
      text = widget.text.toUpperCase();
    } else {
      text = widget.text;
    }
    hidden = widget.readMore && (text.length > (widget.maxLength ?? 1000));
    super.initState();
  }

  double _getFontSize() {
    return widget.fontSize ?? 14;
  }

  FontWeight? _getFontWeight() {
    if (widget.bold ?? false) {
      return FontWeight.w900;
    } else if (widget.regular ?? false) {
      return FontWeight.w500;
    } else if (widget.medium ?? false) {
      return FontWeight.w700;
    } else {
      if (_getFontStyle() != null) {
        return _getFontStyle()!.fontWeight;
      } else {
        return FontWeight.w500;
      }
    }
  }

  TextStyle? _getFontStyle() {
    switch (widget.style) {
      case TextStyles.headlineMedium:
        return Theme.of(context).textTheme.headlineMedium;
      case TextStyles.titleMedium:
        return Theme.of(context).textTheme.titleMedium;
      case TextStyles.bodyMedium:
        return Theme.of(context).textTheme.bodyMedium;
      case TextStyles.bodySmall:
        return Theme.of(context).textTheme.bodySmall;
      case TextStyles.displayMedium:
        return Theme.of(context).textTheme.displayMedium;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textWidthBasis: TextWidthBasis.longestLine,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign ?? TextAlign.start,
      overflow: widget.maxLines != null
          ? TextOverflow.ellipsis
          : TextOverflow.visible,
      maxLines: widget.maxLines,
      text: TextSpan(
        style: widget.style != null
            ? _getFontStyle()!.copyWith(
                fontStyle: widget.italic ? FontStyle.italic : null,
                color: widget.color ?? _getFontStyle()!.color,
                fontWeight: widget.fontWeight ?? _getFontWeight(),
                fontSize: widget.fontSize,
                decoration: widget.textDecoration,
                decorationStyle: widget.decorationStyle,
                decorationThickness: widget.decorationThickness,
              )
            : Theme.of(context).textTheme.headline6!.copyWith(
                  fontStyle: widget.italic ? FontStyle.italic : null,
                  color: widget.color ?? Colors.black,
                  fontSize: _getFontSize(),
                  letterSpacing: widget.letterSpacing,
                  fontWeight: widget.fontWeight ?? _getFontWeight(),
                  decoration: widget.textDecoration,
                  decorationStyle: widget.decorationStyle,
                  decorationThickness: widget.decorationThickness,
                  height: widget.lineHeight,
                ),
        children: <TextSpan>[
          TextSpan(
            text: (text.length > (widget.maxLength ?? 1000))
                ? widget.readMore
                    ? hidden
                        ? "${text.substring(0, (text.length > (widget.maxLength ?? 1000)) ? widget.maxLength : text.length)}..."
                        : text
                    : "${text.substring(0, (text.length > (widget.maxLength ?? 1000)) ? widget.maxLength : text.length)}..."
                : text,
          ),
          if (hidden)
            TextSpan(
              text: "More",
              style: Theme.of(context).textTheme.titleSmall,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    hidden = !hidden;
                  });
                },
            ),
        ],
      ),
    );
  }
}
