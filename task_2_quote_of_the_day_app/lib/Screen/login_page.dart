import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_2_quote_of_the_day_app/Screen/home.dart';
import '../FUNCTIONS/auth_method.dart';
import '../Utilities/colors.dart';
import '../Utilities/dimensions.dart';
import '../Utilities/show_snack_bar.dart';
import '../Widgets/Texts/big_text.dart';
import '../Widgets/custom_gesture_detector.dart';
import '../Widgets/custom_text_field.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String response = await Auth().loginUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );
    if (response == 'success') {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      showSnackBar(response, context);
    }

    setState(() {
      _isLoading = false;
    });
    print(response);
  }

  void navigateToSignup() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Ammar Yasir'),
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          SizedBox(
            height: Dimensions.height30 * 3,
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
            text: 'Login',
            onTap: loginUser,
            icon: Icons.login,
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
          Flexible(
            flex: 3,
            child: Container(),
          ),
          GestureDetector(
            onTap: navigateToSignup,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BigText(text: 'Dont have an account?'),
                SizedBox(
                  width: Dimensions.width10,
                ),
                BigText(
                  text: 'Sign Up',
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
    );
  }
}
