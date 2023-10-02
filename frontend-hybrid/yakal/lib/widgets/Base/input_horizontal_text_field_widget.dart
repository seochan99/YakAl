import 'package:flutter/material.dart';

class InputHorizontalTextFieldWidget extends StatelessWidget {
  static const int _usernameLimits = 5;
  final FocusNode textFocus = FocusNode();

  InputHorizontalTextFieldWidget({
    super.key,
    required TextEditingController nickNameController,
  }) : _nickNameController = nickNameController;

  final TextEditingController _nickNameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: InputHorizontalTextFieldWidget._usernameLimits,
      controller: _nickNameController,
      autofocus: true,
      focusNode: textFocus,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: Color.fromRGBO(84, 135, 252, 1),
            width: 2.0,
          ),
        ),
        labelText: '닉네임',
      ),
    );
  }
}
