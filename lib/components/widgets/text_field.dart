import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FSTextField extends StatefulWidget {
  const FSTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.label,
    this.keyboardType,
    this.textInputAction,
    this.hint,
    this.prefix,
    this.suffix,
    this.error,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled,
    this.readOnly = false,
    this.onTap,
    this.autofocus = false,
    this.canRequestFocus = true,
    this.onPrefixTap,
    this.onSuffixTap,
    this.expands = false,
    this.maxLines = 1,
    this.style,
    this.counterText,
    this.maxLength,
  });

  final String? label;
  final String? hint;
  final String? error;
  final Widget? prefix;
  final Function()? onPrefixTap;
  final Function()? onSuffixTap;
  final Widget? suffix;
  final bool obscureText;
  final bool? enabled;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool autofocus;
  final bool canRequestFocus;
  final bool expands;
  final int? maxLines;
  final TextStyle? style;
  final String? counterText;
  final int? maxLength;

  @override
  State<FSTextField> createState() => _FSTextFieldState();
}

class _FSTextFieldState extends State<FSTextField> {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() {
          hasFocus = value;
        });
      },
      child: TextField(
        maxLength: widget.maxLength,
        style: widget.style,
        textAlignVertical: TextAlignVertical.top,
        expands: widget.expands,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          errorText: widget.error,
          filled: true,
          fillColor: hasFocus ? R.color.mainColor.withOpacity(0.08) : R.color.textFieldColor,
          prefixIcon: widget.prefix == null
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: buildIcon(
                    widget.prefix!,
                    onTap: widget.onPrefixTap,
                  ),
                ),
          suffixIcon: widget.suffix == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: buildIcon(
                    widget.suffix!,
                    onTap: widget.onSuffixTap,
                  ),
                ),
          counterText: widget.counterText,
        ),
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        autofocus: widget.autofocus,
        canRequestFocus: widget.canRequestFocus,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
      ),
    );
  }

  Widget buildIcon(Widget icon, {required Function()? onTap}) {
    return IconButton(
      icon: ColorFiltered(
        colorFilter: ColorFilter.mode(
          hasFocus ? R.color.mainColor : Colors.grey.shade500,
          BlendMode.srcIn,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 20,
            maxHeight: 20,
          ),
          child: icon,
        ),
      ),
      style: ButtonStyle(shape: MaterialStateProperty.all(const CircleBorder())),
      onPressed: onTap,
    );
  }
}
