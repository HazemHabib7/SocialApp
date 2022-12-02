import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/models/social_user_model.dart';
import 'package:udemy/modules/social_app/edit_prifile/edit_profile_screen.dart';
import 'package:udemy/shared/styles/icon_broken.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';

class SocialSettingsScreen extends StatelessWidget {
  const SocialSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        SocialUserModel? userModel = cubit.userModel;
        return Column(
          children: [
            if(!FirebaseAuth.instance.currentUser!.emailVerified)
              Container(
                color: Colors.amber.withOpacity(.55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(Icons.info_outline),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text('Verify your accaunt:',),
                    Spacer(),
                    defaultTextButton(function: (){
                      FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                        return defaultToast(message: 'Message is sent', state: ToastStates.SUCCESS);
                      });
                    }, text: 'Verify', color: defaultColor),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
            // SizedBox(height: .0,),

            Column(
              children: [
                Container(
                  height: 250,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                )
                            ),
                            child: Image(
                              image: NetworkImage(
                                  '${userModel?.cover}'),
                              width: double.infinity,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60.0,
                        child: CircleAvatar(
                          radius: 55.0,
                          backgroundImage: NetworkImage(
                              '${userModel?.image}'),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 6.0,),
                Text('${userModel?.name}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 6.0,),
                Text('bio...',style: TextStyle(color: Colors.grey),),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('100',style: TextStyle(fontWeight: FontWeight.bold,height: 2.0)),
                              Text('Posts'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('265',style: TextStyle(fontWeight: FontWeight.bold,height: 2.0)),
                              Text('Photos'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('10K',style: TextStyle(fontWeight: FontWeight.bold,height: 2.0)),
                              Text('Followers'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('64',style: TextStyle(fontWeight: FontWeight.bold,height: 2.0)),
                              Text('Followings'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Container(height: 45.0,child: OutlinedButton(onPressed: (){}, child: Text('Add Photos')))),
                      SizedBox(width: 8.0,),
                      Container(height: 45.0,child: OutlinedButton(onPressed: (){navigateTo(context, EditProfileScreen());}, child: Icon(IconBroken.Edit)))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultOutlinedButton(function: (){
                    socialSignOut(context);
                  }, text: 'Signout',radius: 5.0,height: 45.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultOutlinedButton(function: (){
                    FirebaseMessaging.instance.subscribeToTopic('announcement');
                  }, text: 'Subscribe',radius: 5.0,height: 45.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultOutlinedButton(function: (){
                    FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
                  }, text: 'Unsubscribe',radius: 5.0,height: 45.0),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
