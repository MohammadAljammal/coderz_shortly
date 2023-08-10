import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldType { email, password, phone, search, firstName, lastName }

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

final _mobileFormatter = NumberTextInputFormatter();

class AppTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final String? validationError;
  final String? type;
  final IconData? suffixIcon;
  final GestureTapCallback? onSuffixTap;
  final Color? suffixIconColor;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final String? labelText;
  final FormFieldValidator<String>? validator;
  final bool autofocus;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final AutovalidateMode? autoValidate;
  final bool bare;
  final dynamic Function(bool)? onFocus;
  final TextCapitalization textCapitalization;
  final TextInputAction inputAction;
  final ValueChanged<String>? onSubmit;
  final int? minLines;
  final int? maxLines;
  final MaxLengthEnforcement? maxLengthEnforced;
  final String? initialValue;
  final int? maxLength;
  final bool? autoFocus;
  final double? fontSize;
  final FontWeight? fontWeight;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? padding;
  final bool keepPadding;
  final bool borderOnlyError;
  final bool focus;
  final Color? borderColor;
  final Color? color;
  final bool isCircular;
  final TextDirection? textDirection;
  final GestureTapCallback? onTap;

  const AppTextField(
      {Key? key,
      this.focusNode,
      this.validationError,
      this.type,
      this.suffixIcon,
      this.onSuffixTap,
      this.suffixIconColor,
      this.prefix,
      this.suffix,
      this.readOnly = false,
      this.prefixIcon,
      required this.controller,
      this.labelText,
      this.validator,
      this.autofocus = false,
      this.keyboardType,
      this.autofillHints,
      this.textInputAction,
      this.onSaved,
      this.onChanged,
      this.hintText,
      this.autoValidate,
      this.bare = false,
      this.onFocus,
      this.textCapitalization = TextCapitalization.none,
      this.inputAction = TextInputAction.done,
      this.onSubmit,
      this.minLines,
      this.maxLines,
      this.maxLengthEnforced,
      this.initialValue,
      this.maxLength,
      this.autoFocus,
      this.fontSize,
      this.fontWeight = FontWeight.w500,
      this.inputFormatters,
      this.padding,
      this.keepPadding = true,
      this.borderOnlyError = false,
      this.focus = false,
      this.borderColor,
      this.color,
      this.isCircular = false,
      this.textDirection,
      this.onTap})
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool focus = false;
  bool view = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (widget.onFocus != null) widget.onFocus!(_focusNode.hasFocus);
      setState(() {
        focus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    if (widget.focus) {
      _focusNode.requestFocus();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget? _buildSuffixIcon() {
    switch (widget.type) {
      case "password":
        {
          return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: view
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          view = false;
                        });
                      },
                      child: Icon(EvaIcons.eyeOutline,
                          size: 30.0, color: Theme.of(context).primaryColor))
                  : InkWell(
                      onTap: () {
                        setState(() {
                          view = true;
                        });
                      },
                      child: Icon(EvaIcons.eyeOffOutline,
                          size: 30.0, color: Colors.grey[500])));
        }
      case "hourly":
        return const Align(
            alignment: Alignment.centerRight,
            child: Text(
              '/ hr  ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ));

      default:
        if (widget.suffixIcon != null) {
          return InkWell(
              onTap: widget.onSuffixTap,
              child: Icon(widget.suffixIcon,
                  size: 22.0,
                  color: widget.suffixIconColor ?? Colors.grey[500]));
        } else {
          return null;
        }
    }
  }

  bool _determineReadOnly() {
    if (widget.readOnly != null && widget.readOnly) {
      _focusNode.unfocus();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: TextFormField(
        autofillHints: widget.autofillHints,
        onTap: widget.readOnly ? widget.onTap : () {},
        // textDirection: TextDirection.rtl,
        keyboardAppearance: Theme.of(context).brightness,
        scrollPhysics: const BouncingScrollPhysics(),
        autovalidateMode: widget.autoValidate,
        textCapitalization: widget.textCapitalization,
        onFieldSubmitted: widget.inputAction == TextInputAction.next
            ? (widget.onSubmit ??
                (val) {
                  _focusNode.nextFocus();
                })
            : widget.onSubmit,
        textInputAction: widget.inputAction,
        minLines: widget.minLines ?? 1,
        maxLines: widget.maxLines ?? 1,
        maxLengthEnforcement: widget.maxLengthEnforced,
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        focusNode: _focusNode,
        maxLength: widget.maxLength,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textDirection: widget.textDirection,
        readOnly: _determineReadOnly(),
        obscureText:
            ((widget.type == "password" && !view) || widget.type == "ssn")
                ? true
                : false,

        autofocus: widget.autoFocus ?? false,
        validator: widget.validator,
        onSaved: widget.onSaved,

        style: Theme.of(context).textTheme.headline6?.copyWith(
            fontSize: widget.fontSize, fontWeight: widget.fontWeight),
        inputFormatters: widget.keyboardType == TextInputType.phone
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                _mobileFormatter,
              ]
            : widget.inputFormatters,
        decoration: InputDecoration(
            counterText: "",
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
                color: Theme.of(context).hintColor),
            contentPadding: widget.padding ??
                EdgeInsets.symmetric(
                    vertical:
                        (widget.bare && !widget.keepPadding) ? 0.0 : 10.0,
                    horizontal:
                        (widget.bare && !widget.keepPadding) ? 0.0 : 16.0),
            filled: true,
            fillColor: widget.bare
                ? Colors.transparent
                : widget.color ?? Theme.of(context).backgroundColor,
            suffixIcon: _buildSuffixIcon(),
            suffix: widget.suffix,
            prefix: widget.prefix,
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            errorStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: widget.fontWeight,
                height: widget.borderOnlyError ? 0.0 : null),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .errorColor
                        .withOpacity(widget.bare ? 0.0 : 0.5),
                    width: 1.0),
                borderRadius: BorderRadius.circular(widget.bare
                    ? 0.0
                    : widget.isCircular
                        ? 30
                        : 8.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .errorColor
                        .withOpacity(widget.bare ? 0.0 : 0.5),
                    width: 1.0),
                borderRadius: BorderRadius.circular(widget.bare
                    ? 0.0
                    : widget.isCircular
                        ? 30
                        : 8.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor ??
                        Theme.of(context)
                            .dividerColor
                            .withOpacity(widget.bare ? 0.0 : 1.0),
                    width: 1.0),
                borderRadius: BorderRadius.circular(widget.bare
                    ? 0.0
                    : widget.isCircular
                        ? 30
                        : 8.0)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor ??
                        Theme.of(context)
                            .dividerColor
                            .withOpacity(widget.bare ? 0.0 : 1.0),
                    width: 1.0),
                borderRadius: BorderRadius.circular(widget.bare
                    ? 0.0
                    : widget.isCircular
                        ? 30
                        : 8.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor ??
                        Theme.of(context)
                            .dividerColor
                            .withOpacity(widget.bare ? 0.0 : 1.0),
                    width: 1.0),
                borderRadius: BorderRadius.circular(widget.bare
                    ? 0.0
                    : widget.isCircular
                        ? 30
                        : 8.0))),
      ),
    );
  }
}
