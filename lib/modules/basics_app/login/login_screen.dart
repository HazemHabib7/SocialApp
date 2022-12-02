import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: defaultTextFormField(
                    validateText: 'Email Address must not be empty',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: 5.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: defaultTextFormField(
                    validateText: 'Password must not be empty',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                        icon: isPassword? Icon(Icons.remove_red_eye_rounded):Icon(Icons.remove_red_eye_outlined),
                    ),
                    isPassword: isPassword,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()) {
                            print(emailController.text);
                            print(passwordController.text);
                          }
                        },
                      text: 'Login',
                    radius: 10.0

                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t you have an account\?'),
                      SizedBox(width: 5.0),
                      TextButton(onPressed: () {}, child: Text('Regest Now')),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
