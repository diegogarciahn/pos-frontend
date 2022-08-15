import 'package:flutter/material.dart';

Row datosSuperiores(String campo, String valor,
      {Color? color,
      int? flex1,
      int? flex2,
      CrossAxisAlignment? crossAxisAlignment}) {
    return Row(
      crossAxisAlignment: (crossAxisAlignment == null)
          ? CrossAxisAlignment.start
          : crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: (flex1 == null) ? 4 : flex1,
            child: Text(campo,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: (color != null) ? color : Colors.black87))),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: (flex2 == null) ? 6 : flex2,
          child: Text(
            valor,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: (color != null) ? color : Colors.black87),
          ),
        ),
      ],
    );
  }