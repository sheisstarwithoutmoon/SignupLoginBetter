import 'package:daytwo/screens/home_screen.dart';
import 'package:daytwo/screens/login_screen.dart';
import 'package:daytwo/services/authentication.dart';
import 'package:daytwo/widgets/button.dart';
import 'package:daytwo/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();
  late final TextEditingController _username = TextEditingController();

  bool isloading = false;

  void userSignup() async {
    String? message = await AuthServices().userSignup(
      email: _email.text,
      password: _password.text,
      username: _username.text,
    );
    if(message == "Succesful"){
      setState((){
        isloading = true;
      });
      Navigator.push(
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
  void dispose(){
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height/2.8,
                child: Image.asset("assets/images/signup.png",
                // width: double.infinity, // Make it take the full width
                // height: double.infinity, // Adjust the height
                // fit: BoxFit.cover, ),
              ),),
              TextFieldWidget(
                controller: _username,
                icon: Icons.person,
                hintText: "Enter your Name",
              ),
              const SizedBox(
                height: 10,
                ),
              TextFieldWidget(
                controller: _email,
                icon: Icons.email,
                hintText: "Enter your Email",
              ),
              const SizedBox(
                  height: 10,
                ),
              TextFieldWidget(
                controller: _password,
                icon: Icons.lock,
                isPassword: true,
                hintText: "Enter your Password",
              ),
              SizedBox(height: 10,),
            Button(onPressed: userSignup, text: "Sign  Up"),
              SizedBox(
                height: height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have An Account? ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "Login",
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
        );
  }
}