import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/styles/colors.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../shared/styles/icon_broken.dart';


class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).posts.length >0 && SocialCubit.get(context).userModel != null ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(alignment: Alignment.bottomRight, children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: EdgeInsetsDirectional.all(8.0),
                  child: Image(
                    image: NetworkImage(
                        'https://img.freepik.com/premium-photo/lucky-cool-redhead-sassy-girl-singing-pointing-camera-talking-about-you-congratulate-friend-good-job_1258-82368.jpg?w=2000'),
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Communicate with friends',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
              ]),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsetsDirectional.all(8.0),
                    elevation: 10.0,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  radius: 28.0,
                                  backgroundImage: NetworkImage(
                                      SocialCubit.get(context).posts[index].image!),
                                ),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Column(
                                children: [
                                  Text(
                                    SocialCubit.get(context).posts[index].name!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        height: 1.8),
                                  ),
                                  Text(
                                    SocialCubit.get(context).posts[index].dateTime!,
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.grey, height: 1.3),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Container(
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: defaultColor,
                                        size: 20.0,
                                      ),
                                    ],
                                  )),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.more_horiz_rounded),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              color: Colors.grey,
                              height: 0.6,
                            ),
                          ),
                          SizedBox(
                            height: 14.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              SocialCubit.get(context).posts[index].text!,
                              style:
                              TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: MaterialButton(
                                      height: 20.0,
                                      minWidth: 1.0,
                                      padding: EdgeInsetsDirectional.zero,
                                      onPressed: () {},
                                      child: Text('#Software',style: TextStyle(color: defaultColor,fontWeight: FontWeight.bold),)),
                                ),
                              ],
                            ),
                          ),
                          if( SocialCubit.get(context).postImage != '')
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      SocialCubit.get(context).posts[index].postImage!,
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:  8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Row(
                                      children: [
                                        Icon(IconBroken.Heart,color: Colors.pink,),
                                        SizedBox(width: 4.0,),
                                        Text('${SocialCubit.get(context).likes[index]}',style: TextStyle(color: Colors.grey),)
                                      ],
                                    ),
                                    onTap: (){},
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      SocialCubit.get(context).commentPost(SocialCubit.get(context).postsIds.toString(), '');
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(IconBroken.Chat,color: Colors.amber,),
                                        SizedBox(width: 4.0,),
                                        Text('0 Comment',style: TextStyle(color: Colors.grey),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              color: Colors.grey,
                              height: 0.6,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(
                                      SocialCubit.get(context).posts[index].image!),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Write a comment...',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    height: 1.8),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: (){
                                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsIds[index]);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(IconBroken.Heart,color: Colors.pink,),
                                      SizedBox(width: 5.0,),
                                      Text('Like'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => Container(height: 10.0,),
                  itemCount: SocialCubit.get(context).posts.length),
              SizedBox(height: 50.0,),
            ],
          ),
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
