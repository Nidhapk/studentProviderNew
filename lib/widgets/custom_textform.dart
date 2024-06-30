import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
   final String hintext;
  final String labeltext;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const CustomTextForm({super.key,required this.validator,required this.hintext,required this.labeltext,required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintext,
            hintStyle: const TextStyle(color: Colors.green),
            labelText: labeltext,
            labelStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 147, 168, 178),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.green,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 147, 168, 178),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 147, 168, 178),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
          )),
    );
  }
}