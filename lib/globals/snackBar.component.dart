import 'package:flutter/material.dart';

import '../../constans.dart';

showSnackBarGlobal(String msg, context, {Color color = Colors.black}) {
   Navigator.pushReplacementNamed(context, 'login');
    SnackBar snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: color,
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
}
