import 'package:flutter/material.dart';
import 'package:mini_project_cinema_app/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController fieldController;
  final String? Function(String?)? validator;

  const RoundedPasswordField({
    Key? key, // Fix here
    required this.onChanged,
    required this.fieldController,
    this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: fieldController,
        obscureText: true,
        validator: validator,
        onSaved: (value) {
          fieldController.text = value!;
        },
        decoration: const InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Color(0xFF6D28D9),
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Color(0xFF6D28D9),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}