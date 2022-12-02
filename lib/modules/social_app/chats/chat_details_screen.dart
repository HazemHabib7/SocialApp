import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/models/message_model.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/components/constants.dart';
import 'package:udemy/shared/styles/colors.dart';
import 'package:udemy/shared/styles/icon_broken.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../models/social_user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel model;
  TextEditingController messageController = TextEditingController();
  ChatDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: model.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(model.image!),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      model.name!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              body: Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        if(SocialCubit.get(context).message[index].senderId == uId)
                        buildReceiverMessage(SocialCubit.get(context).message[index],context,index),

                        buildSenderMessage(SocialCubit.get(context).message[index],context,index),
                        Spacer(),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    hintText: ' Type your message here ...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              // Spacer(),
                              Container(
                                  width: 60.0,
                                  child: MaterialButton(
                                    onPressed: () {
                                      SocialCubit.get(context).sendMessages(
                                          receiverId: model.uId!,
                                          text: messageController.text,
                                          dateTime: DateTime.now().toString());
                                    },
                                    child: Icon(
                                      IconBroken.Send,
                                      color: Colors.white,
                                    ),
                                    color: defaultColor,
                                    height: 50.0,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => buildDivider(),
                  itemCount: SocialCubit.get(context).message.length,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildReceiverMessage(MessageModel model,context, int index) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.5),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '${model.text}',
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ),
      );
  Widget buildSenderMessage(MessageModel model,context,int index) => Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(.5),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '${model.text}',
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ),
      );
}
