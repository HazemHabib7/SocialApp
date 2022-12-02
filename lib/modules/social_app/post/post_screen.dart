import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/styles/colors.dart';
import 'package:udemy/shared/styles/icon_broken.dart';

class PostScreen extends StatelessWidget {
  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(

      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 28.0,
                        backgroundImage: NetworkImage(
                            'https://img.myloview.com/posters/horizontal-shot-of-smiling-happy-positive-woman-wearing-tank-top-and-panama-posing-in-torn-pink-paper-wall-having-video-call-or-broadcasting-livestream-showing-v-sign-700-307336205.jpg'),
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Column(
                        children: [
                          Text(
                            'Hazem Habib',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                height: 1.8),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 10.0,),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'What is in your mind ...',
                          border: InputBorder.none),
                      controller: postController,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  if(SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Image(image: FileImage(SocialCubit.get(context).postImage!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.lightBlueAccent,
                            child: IconButton(icon: Icon(Icons.close),onPressed: (){
                              SocialCubit.get(context).removePostImage();
                            }),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Row(
                            children: [
                              Icon(IconBroken.Image,color: defaultColor,),
                              SizedBox(width: 10.0,),
                              Text('Add Photo',style: TextStyle(color: defaultColor,fontWeight: FontWeight.bold),),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          onPressed: (){
                            SocialCubit.get(context).pickPostImage();
                          },
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('# tags',style: TextStyle(color: defaultColor,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
