// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:udemy/layout/shop_app/shop_layout.dart';
// import 'package:udemy/modules/shop_app/login/cubit/states.dart';
// import 'package:udemy/shared/components/components.dart';
// import 'package:udemy/shared/components/constants.dart';
// import 'package:udemy/shared/network/local/cache_helper.dart';
// import 'package:udemy/shared/styles/colors.dart';
// import '../register/register_screen.dart';
// import 'cubit/cubit.dart';
//
// class ShopLoginScreen extends StatelessWidget {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   var formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LoginCubit(),
//       child: BlocConsumer<LoginCubit,LoginStates>(
//         listener: (context, state) {
//           if(state is LoginSuccessState){
//             if(state.loginModel.status==true){
//               // print('message: ${state.loginModel.message}');
//               // print('token: ${state.loginModel.data?.token}');
//               CacheHelper.saveData(key: 'token', value: '${state.loginModel.data?.token}').then((value) {
//                 token = state.loginModel.data?.token;
//                 navigateAndFinish(context, ShopLayout());
//               });
//             }
//             else {
//               print('message: ${state.loginModel.message}');
//               defaultToast(
//                   message: '${state.loginModel.message}',
//                   state: ToastStates.ERROR);
//             }
//           }
//         },
//         builder: (context, state) {
//           LoginCubit cubit = LoginCubit.get(context);
//           return Scaffold(
//             appBar: AppBar(),
//             body: Center(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Text('LOGIN',style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold)),
//                       ),
//                       SizedBox(height: 8.0),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Text('Login now to browse our hot offers',style: TextStyle(color: Colors.grey,fontSize: 20.0)),
//                       ),
//                       SizedBox(height: 35.0),
//                       defaultTextFormField(
//                           onTap: (){},
//                           validateText: 'Email Address must not be empty',
//                           controller: emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           label: 'Email Address',
//                           prefixIcon: Icon(Icons.email_outlined)),
//                       SizedBox(height: 20.0),
//                       defaultTextFormField(
//                           onTap: (){},
//                           validateText: 'Password must not be empty',
//                           controller: passwordController,
//                           keyboardType: TextInputType.visiblePassword,
//                           label: 'Password',
//                           prefixIcon: Icon(Icons.lock_outline_rounded),
//                           isPassword: cubit.isPassword,
//                           suffixIcon: IconButton(
//                             onPressed: (){
//                               cubit.is1password();
//                             },
//                             icon:cubit.isPassword? Icon(Icons.visibility_outlined):Icon(Icons.visibility_off_outlined),
//                           )
//                       ),
//                       SizedBox(height: 35.0,),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: state is LoginLoadingState ? Center(child: CircularProgressIndicator()) :defaultButton(
//                           radius: 25.0,
//                           function: (){
//                             if(formKey.currentState!.validate()){
//                               cubit.login(
//                                   email: emailController.text,
//                                   password: passwordController.text);
//                             }
//                           },
//                           text: 'login',
//                         ),
//                       ),
//                       SizedBox(height: 20.0,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Don\'t have an account? ',style: TextStyle(fontWeight: FontWeight.bold),),
//                           defaultTextButton(
//                             function: (){
//                               navigateTo(context, ShopRegisterScreen());
//                             },
//                             text: 'register',
//                             color: defaultColor,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
