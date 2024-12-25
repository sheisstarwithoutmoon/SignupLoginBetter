import 'package:daytwo/screens/forgot_pass_screen.dart';
import 'package:daytwo/screens/home_screen.dart';
import 'package:daytwo/screens/signup_screen.dart';
import 'package:daytwo/widgets/button.dart';
import 'package:daytwo/widgets/text_field.dart';
import 'package:flutter/material.dart';

import 'package:daytwo/services/authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();
  bool isloading = false;

  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void userLogin() async {
    String message = await AuthServices().userLogin(
      email: _email.text,
      password: _password.text,
    );
    if(message == "Succesful"){
      setState((){
        isloading = true;
      });
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      setState((){
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        )
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                SizedBox(
                height: height/2.8,
                child: Image.asset("assets/images/login.png",
                //width: double.infinity, // Make it take the full width
                //height: double.infinity, // Adjust the height
                //fit: BoxFit.cover, ),
                ),),
                SizedBox(
                  height: 20,
                ),
                  TextFieldWidget(
                      controller: _email,
                      icon: Icons.email,
                      hintText: "Enter Your Email"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      controller: _password,
                      icon: Icons.lock,
                      isPassword: true,
                      hintText: "Enter Your Password"),
                    Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Button(onPressed: userLogin, text: "Login"),
                  SizedBox(
                    height: height / 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont Have an Account? ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

