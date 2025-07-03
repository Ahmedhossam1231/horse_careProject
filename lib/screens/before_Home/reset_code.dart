import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:login_ui_flutter/screens/before_Home/resetpass.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../utils/constanst.dart';

class ResetCodeScreen extends StatelessWidget {
  const ResetCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: FadeInLeft(
              delay: const Duration(milliseconds: 2100),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(
            right: 15,
            left: 15,
            bottom: 15,
          ),
          width: gWidth,
          height: gHeight,
          child: const Column(
            children: [
              TopImage(),
              SizedBox(
                height: 5,
              ),
              ForgotText(),
              SizedBox(
                height: 20,
              ),
              MiddleText(),
              SizedBox(height: 30),
              EmailTextFiled(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// Submit Button Components

class EmailTextFiled extends StatelessWidget {
  const EmailTextFiled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 2),
        FadeInDown(
          delay: const Duration(milliseconds: 1400),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: PinCodeTextField(
              length: 6,
              appContext: context,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 55,
                fieldWidth: 45,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.grey.shade100,
                inactiveFillColor: Colors.grey.shade100,
                activeColor: buttonColor,
                selectedColor:buttonColor,
                inactiveColor: Colors.grey.shade400,
                fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 5),
              ),
              enableActiveFill: true,
              onChanged: (value) {},
            ),
          ),
        ),
        const SizedBox(height: 20),
        FadeInUp(
          delay: const Duration(milliseconds: 1600),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  () => const ResetPasswordScreen(),
                  transition: Transition.leftToRight,
                );
                Get.snackbar("Success", "Code Verified Successfully");
              },
              child: const Text("Verify Code", style: TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// Middle Text Components
class MiddleText extends StatelessWidget {
  const MiddleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 1000),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: gWidth,
          height: gHeight / 19,
          child: const Text(
                "Please enter the 6-digit code sent to your email.",
            style: TextStyle(color: text1Color, height: 1.2, wordSpacing: 2),
          )),
    );
  }
}

// Top Forgot Text Components
class ForgotText extends StatelessWidget {
  const ForgotText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: const Duration(milliseconds: 1400),
      child: Container(
        margin: const EdgeInsets.only(right: 160, top: 10),
        width: gWidth / 2,
        height: gHeight / 8,
        child: const FittedBox(
          child: Text(
            "Verfication\nCode?",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Top Image Components
class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 1800),
      child: SizedBox(
        width: gWidth,
        height: gHeight / 2.7,
        child: Container(decoration:const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 90, 99, 104),
                  blurRadius: 35,
                  offset: Offset(0,4),
                ),
              ],
            ),
            child: const ClipOval(child: Image(image: AssetImage("assets/images/ok.jpg"))),
          )
      ),
    );
  }
}
