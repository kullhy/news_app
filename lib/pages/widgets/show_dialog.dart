import 'package:flutter/material.dart';
import 'package:learn_bloc_2/navigator/app_navigator.dart';

Future<dynamic> voidShowDialog(
    {required BuildContext context,
    required String title,
    required String content,
    required Function() ontap}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            AppNavigator.pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: ontap,
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
