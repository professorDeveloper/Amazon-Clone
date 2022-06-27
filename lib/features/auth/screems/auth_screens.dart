import 'package:untitled1/common/widgets/custom_button.dart';
import 'package:untitled1/common/widgets/custom_textfiled.dart';
import 'package:untitled1/constains/global_variables.dart';
import 'package:untitled1/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
  static const String routeName = '/auth-screens';
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
final AuthService  authService=AuthService();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
  }
  void signInUser() {
    authService.signInUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Navigator.pushNamed(context, '',arguments: );
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 7,),

                const Text(
                  "Welcome ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 17,),
                ListTile(
                  tileColor: _auth==Auth.signUp ?GlobalVariables.backgroundColor:GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    "Create Account ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signUp,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signUp)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: signUpFormKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          CustomTextFiled(
                              controller: nameController, hintText: "Name"),
                          SizedBox(
                            height: 12,
                          ),
                          CustomTextFiled(
                              controller: emailController, hintText: "Email"),
                          SizedBox(
                            height: 12,
                          ),
                          CustomTextFiled(
                              controller: passwordController,
                              hintText: "Password"),

                          SizedBox(
                            height: 12,
                          ),
                          CustomButton(text: "Sign Up", onTap: () {
                            if(signUpFormKey.currentState!.validate()){
                              signUpUser();
                            }

                          }),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  title: const Text(
                    "Sign In ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signIn)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: signInFormKey,
                      child: Column(
                        children: [
                          CustomTextFiled(
                              controller: emailController, hintText: "Email"),
                          SizedBox(
                            height: 12,
                          ),
                          CustomTextFiled(
                              controller: passwordController,
                              hintText: "Password"),
                          SizedBox(
                            height: 12,
                          ),
                          CustomButton(text: "Sign In", onTap: () {
                            if(signInFormKey.currentState!.validate()){
                              signInUser();
                            }


                          }),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
