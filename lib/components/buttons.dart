import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final dynamic text; //can be string or integer
  final Function() updateState;
  const Button(this.text, this.updateState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: updateState,
          child: Text(text),
        ),
      ),
    );
  }
}
