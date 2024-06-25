import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.label,
    this.controller,
    this.textInputType,
    this.textInputAction,
    this.hintText,
    this.suffixIcon,
    this.onFieldSubmitted,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Widget? suffixIcon;
  final Function(String)? onFieldSubmitted;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      validator: (validate) {
        if (validate!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      style: const TextStyle(
          fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        label: Text(
          widget.label,
          style: const TextStyle(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        suffixIcon: widget.suffixIcon,
      ),
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
