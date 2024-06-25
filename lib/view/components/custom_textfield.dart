import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.label,
  });

  final String label;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (validate) {
        if (validate!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
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
      ),
    );
  }
}
