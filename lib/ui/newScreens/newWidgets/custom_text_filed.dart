import 'package:flutter/material.dart';

typedef onsave(String value);

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Color fillColor;
  final TextInputType keyboardType;
  final bool isSearch;
  final bool isPass;
  final TextEditingController controller;
  final labelText;

  final onsave onValidator;
  final onsave onSave;

  CustomTextField(
      {this.hintText,
      this.fillColor,
      this.isPass,
      this.labelText,
      this.controller,
      this.keyboardType,
      this.isSearch = false,
      this.onSave,
      this.onValidator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // color: fillColor,
      ),
      child: TextFormField(
        obscureText: isPass,
        controller: controller,
        onSaved: (value) => onSave(value),
        validator: (value) => onValidator(value),
        keyboardType: keyboardType,

        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.orange, fontSize: 15),
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true),

        // decoration: InputDecoration(
        //   labelStyle:
        //       TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        //   labelText: hintText,
        //   fillColor: fillColor,
        //   suffixIcon: isSearch ? Icon(Icons.search) : Text(''),
        //   focusedBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: Colors.green),
        //     borderRadius: BorderRadius.circular(15),
        //   ),
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(15),
        //   ),
        // ),
      ),
    );
  }
}
