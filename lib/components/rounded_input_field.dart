import 'package:flutter/material.dart';
import 'package:mini_project_cinema_app/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController fieldController;
  final String? Function(String?)? validator;

  const RoundedInputField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.onChanged,
      required this.fieldController,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        autofocus: false,
        controller: fieldController,
        validator: validator,
        onSaved: (value) {
          fieldController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: const Color(0xFF6D28D9),
            ),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
