import 'package:flutter/material.dart';

class InputHorizontalTextFieldWidget extends StatelessWidget {
  const InputHorizontalTextFieldWidget({
    super.key,
    required TextEditingController nickNameController,
  }) : _nickNameController = nickNameController;

  final TextEditingController _nickNameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _nickNameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: Color.fromRGBO(84, 135, 252,
                1), // UIColor(red: 0.33, green: 0.53, blue: 0.99, alpha: 1)
          ),
        ),
        labelText: '닉네임',
      ),
    );
  }
}
