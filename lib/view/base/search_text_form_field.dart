// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SearchTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function()? onTap;
  const SearchTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          hintText: hintText,
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.search,
              size: 30,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
