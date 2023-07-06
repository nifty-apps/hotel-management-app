// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool readOnly;
  final bool isPrefixIcon;
  final bool isSuffixIcon;
  final void Function()? suffixButtonAction;
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    required this.keyboardType,
    this.validator,
    this.isPassword = false,
    this.readOnly = false,
    this.isSuffixIcon = false,
    this.isPrefixIcon = false,
    this.suffixButtonAction,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        obscureText: widget.isPassword ? _obscureText : false,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          errorStyle: TextStyle(
            fontSize: 0.01,
          ),
          prefixIcon: widget.isPrefixIcon ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.isSuffixIcon
              ? IconButton(
                  onPressed: widget.suffixButtonAction,
                  icon: Icon(Icons.arrow_drop_down),
                )
              : widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3),
                      ),
                      onPressed: _toggle,
                    )
                  : null,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: widget.validator,
        readOnly: widget.readOnly,
        enabled: !widget.readOnly,
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
