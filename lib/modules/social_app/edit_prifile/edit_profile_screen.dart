import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/styles/colors.dart';
import 'package:udemy/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        var userModel = cubit.userModel;
        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            defaultTextButton(
                function: () {
                  cubit.updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: 'update',
                color: defaultColor),
            SizedBox(
              width: 10.0,
            )
          ]),
          body: SingleChildScrollView(
            child : Column(
              children: [
                if(state is SocialUpdateUserLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialUpdateUserLoadingState)
                  SizedBox(height: 10.0,),
                Container(
                  height: 250,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                )),
                                child: Image(
                                  image: cubit.coverImage == null
                                      ? NetworkImage('${userModel?.image}')
                                      : FileImage(coverImage!) as ImageProvider,
                                  width: double.infinity,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.pickCoverImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 16,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60.0,
                            child: CircleAvatar(
                              radius: 55.0,
                              backgroundImage: cubit.profileImage == null
                                  ? NetworkImage('${userModel?.image}')
                                  : FileImage(profileImage!) as ImageProvider,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.pickProfileImage();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                radius: 16,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(cubit.profileImage != null || cubit.coverImage != null)
                  Row(
                  children: [
                    SizedBox(width: 10.0,),
                    if(cubit.profileImage != null)
                    Expanded(child: Column(
                      children: [
                        defaultButton(function: (){
                          cubit.updateProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                        }, text: "Upload Profile",radius: 8.0),
                        if(state is SocialUpdateUserLoadingState)
                          SizedBox(height: 8.0,),

                        if(state is SocialUpdateUserLoadingState)
                          LinearProgressIndicator(),
                      ],
                    )),
                    SizedBox(width: 10.0,),
                    if(cubit.coverImage != null)
                      Expanded(child: Column(
                        children: [
                          defaultButton(function: (){
                            cubit.updateProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                          }, text: "Upload Cover",radius: 8.0),
                          if(state is SocialUpdateUserLoadingState)
                            SizedBox(height: 8.0,),

                          if(state is SocialUpdateUserLoadingState)
                            LinearProgressIndicator(),
                        ],
                      )),
                    SizedBox(width: 10.0,),
                  ],
                ),
                if(cubit.coverImage != null || cubit.profileImage != null)
                  SizedBox(
                  height: 20.0,
                ),
                defaultTextFormField(
                    validateText: 'Name must not be empty',
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    label: 'Name',
                    prefixIcon: Icon(IconBroken.User)),
                SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                    validateText: 'Bio must not be empty',
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    label: 'Bio',
                    prefixIcon: Icon(IconBroken.Info_Circle)),
                SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                    validateText: 'Phone must not be empty',
                    controller: phoneController,
                    keyboardType: TextInputType.text,
                    label: 'Phone',
                    prefixIcon: Icon(IconBroken.Call)),
              ],
            ),
          ),
        );
      },
    );
  }
}

// nameController.text == null ? 'Write ypur name...' : nameController.text
