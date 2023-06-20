import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? k,
    this.label,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.hasFocus = false,
    this.prefix,
    this.nextNode,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization,
    this.maxLines = 1,
    this.inputFormatters,
    this.suffix,
    this.hint,
    this.onEditingComplete,
    this.isSearchField = false,
    this.isPassword = false,
    this.isDense = false,
    this.controller,
    this.floatingLabelBehavior
  }) : super(key: k);

  final String? hint;
  final String? label;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool? hasFocus;
  final bool enabled;
  final int maxLines;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final FocusNode? nextNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool isDense;
  final bool isSearchField;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final Widget? suffix;
  final Widget? prefix;
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if(widget.label != null)...[
          Text(
            widget.label!,
            style: CustomTextStyle.regular16,
          ),
          const YMargin(10),
        ],
        TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          focusNode: widget.focusNode,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          enabled: widget.enabled,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: config.sp(16),
            color: isDarkMode ? Colors.white : ColorPalette.textColor
          ),
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          validator: widget.validator,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: (String val) {
            FocusScope.of(context).requestFocus(widget.nextNode);
          },
          decoration: InputDecoration(
              hintText: widget.hint,
              isDense: widget.isDense,
              suffixIcon: widget.suffix,
              prefixIcon: widget.prefix,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              contentPadding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
              suffixIconColor: isDarkMode ? const Color(0xffD9C6FF) : const Color(0xff9CA3AF),
              prefixIconColor: isDarkMode ? const Color(0xffD9C6FF) : const Color(0xff9CA3AF),
              labelStyle: TextStyle(
                fontSize: config.sp(18),
                
              ),
              hintStyle: TextStyle(
                fontSize: config.sp(13),
                fontWeight: FontWeight.normal,
                color: isDarkMode ? const Color(0xff9A81D4) : ColorPalette.textColor.withOpacity(.8)
              ),
              border: border,
              filled: true,
              fillColor: isDarkMode ? const Color(0xff481F9F) : Colors.grey.withOpacity(.1),
              errorStyle: TextStyle(
                fontSize: config.sp(14),
              ),
              enabledBorder: border,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: border.copyWith(
                borderSide: BorderSide(
                  color: ColorPalette.primary
                )
              ),
              disabledBorder: border
          ),
        ),
      ],
    );
  }

  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none);
}