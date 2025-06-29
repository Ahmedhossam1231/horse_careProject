import 'package:flutter/material.dart';
//
import '../utils/constanst.dart';

class RepTextFiled extends StatelessWidget {
  final IconData icon;
  final Widget? sufIcon;
  final String text;
  const RepTextFiled({super.key, required this.icon, required this.text,required this.sufIcon,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: gHeight / 15,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 50,
              width: gWidth / 1.3,
              child: TextField(
                readOnly: true, // * Just for Debug
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                showCursor: true,
                // cursorColor:Colors.red,
                decoration: InputDecoration(
                  suffixIcon: sufIcon,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  labelText: text,
                  labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
