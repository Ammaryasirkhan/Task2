import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../FUNCTIONS/auth_method.dart';
import '../Utilities/colors.dart';
import '../Utilities/dimensions.dart';
import '../Utilities/image_picker.dart';
import '../Utilities/show_snack_bar.dart';
import '../Widgets/Texts/big_text.dart';
import '../Widgets/custom_gesture_detector.dart';
import '../Widgets/custom_text_field.dart';
import 'home.dart';
import 'login_page.dart';

class SignUPage extends StatefulWidget {
  const SignUPage({super.key});

  @override
  State<SignUPage> createState() => _SignUPageState();
}

class _SignUPageState extends State<SignUPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String response = await Auth().signUpUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      username: _usernamecontroller.text,
    );
    setState(() {
      _isLoading = false;
    });

    if (response != 'success') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      showSnackBar(response, context);
    }
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // Flexible(
            //   flex: 1,
            //   child: Container(),
            // ),
            SizedBox(
              height: Dimensions.height30 * 5,
            ),
            Image.asset(
              'assets/logo.png',
              color: ColorRes.app,
              height: Dimensions.height30 * 2,
              width: Dimensions.height30 * 2,
              fit: BoxFit.cover,
            ),

            SizedBox(
              height: Dimensions.height30,
            ),
            CustomTextField(
              controller: _usernamecontroller,
              hintText: 'enter your username',
              isPassword: false,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),

            CustomTextField(
              controller: _emailcontroller,
              hintText: 'enter your email',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),

            CustomTextField(
              controller: _passwordcontroller,
              hintText: 'enter your password',
              isPassword: true,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            CustomGestureDetector(
              text: 'Create an account',
              onTap: signUpUser,
              icon: Icons.ac_unit_rounded,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: ColorRes.app,
                      )
                    : Text('')),
            // Flexible(
            //   flex: 3,
            //   child: Container(),
            // ),
            SizedBox(
              height: Dimensions.height30 * 3,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(text: 'Already have an account?'),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  BigText(
                    text: 'Login',
                  ),
                  SizedBox(
                    width: Dimensions.width15,
                  ),
                  Icon(
                    Icons.login_rounded,
                    size: Dimensions.iconsize20,
                    color: ColorRes.app,
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.width30,
            )
          ]),
        ),
      ),
    );
  }
}
