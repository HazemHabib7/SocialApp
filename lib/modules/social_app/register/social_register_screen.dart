import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/social_app/register/cubit/cubit.dart';
import 'package:udemy/modules/social_app/register/cubit/states.dart';
import '../../../layout/social_app/social_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';

class SocialRegisterScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SocialRegisterCubit cubit = SocialRegisterCubit.get(context);
          return BlocProvider(
            create: (context) => SocialRegisterCubit(),
            child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text('REGISTER',style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text('Register now to browse our hot offers',style: TextStyle(color: Colors.grey,fontSize: 20.0)),
                            ),
                            SizedBox(height: 35.0),
                            defaultTextFormField(
                                onTap: (){},
                                validateText: 'User name must not be empty',
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                label: 'User Name',
                                prefixIcon: Icon(Icons.person)),
                            SizedBox(height: 20.0),
                            defaultTextFormField(
                                onTap: (){},
                                validateText: 'Email address must not be empty',
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Email Address',
                                prefixIcon: Icon(Icons.email_outlined)),
                            SizedBox(height: 20.0),
                            defaultTextFormField(
                                onTap: (){},
                                validateText: 'Password must not be empty',
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                label: 'Password',
                                prefixIcon: Icon(Icons.lock_outline_rounded),
                                isPassword: cubit.isPassword,
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    cubit.registerIs1password();
                                  },
                                  icon:cubit.isPassword? Icon(Icons.visibility_outlined):Icon(Icons.visibility_off_outlined),
                                )
                            ),
                            SizedBox(height: 20.0),
                            defaultTextFormField(
                              onTap: (){},
                              validateText: 'Phone number must not be empty',
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              label: 'Phone number',
                              prefixIcon: Icon(Icons.phone),
                            ),
                            SizedBox(height: 35.0,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: cubit.loading ? Center(child: CircularProgressIndicator()) :defaultButton(
                                radius: 25.0,
                                function: (){
                                  print(nameController.text);
                                  print(phoneController.text);
                                  print(emailController.text);
                                  print(passwordController.text);
                                  if(formKey.currentState!.validate()){
                                    cubit.register(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context,
                                    );
                                  }
                                },
                                text: 'register',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          );
        },
      ),
    );
  }
}
