import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

Widget textfild(
  Text hintTxt,
  Icon icon,
  Color fieldborder,
  final TextEditingController controller,
  //bool isObs = false,
  TextInputType? keyBordType,
  Key key,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final containerWidth = screenWidth * 0.9;
      return Container(
        width: containerWidth,
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(19, 211, 209, 209),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              //width: 310.0,
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                textAlignVertical: TextAlignVertical.center,
                keyboardType: keyBordType,

                obscureText: false,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: fieldborder, width: 3.0),
                      borderRadius: BorderRadius.circular(20.0)),
                  prefixIcon: icon,
                  hintText: hintTxt.data,
                ),
              ),
            )
          ],
        ),
      );
    }
  );
}
