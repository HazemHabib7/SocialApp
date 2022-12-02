import 'package:flutter/material.dart';

import '../../../models/user_model.dart';

class UserScreen extends StatelessWidget {
  List<UserModel> user = [
    UserModel(id: 1, name: 'Hazem', phone: 0958780779),
    UserModel(id: 2, name: 'Baraa', phone: 0994936711),
    UserModel(id: 3, name: 'Ola', phone: 0994083783),
    UserModel(id: 4, name: 'Hazem Syriatel', phone: 0938836691),
    UserModel(id: 5, name: 'Anas', phone: 0958431384),
    UserModel(id: 6, name: 'Ghassan', phone: 0954880779),
    UserModel(id: 1, name: 'Hazem', phone: 0958780779),
    UserModel(id: 2, name: 'Baraa', phone: 0994936711),
    UserModel(id: 3, name: 'Ola', phone: 0994083783),
    UserModel(id: 4, name: 'Hazem Syriatel', phone: 0938836691),
    UserModel(id: 5, name: 'Anas', phone: 0958431384),
    UserModel(id: 6, name: 'Ghassan', phone: 0954880779)


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => userItem(user[index]),
          separatorBuilder: (context, index) => SizedBox(height: 0.0,),
          itemCount: 12),
    );
  }
}

Widget userItem(UserModel user) => Column(
  children: [
    Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 30.0,
            child: Text('${user.id}'),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize:20.0),),
            Text('${user.phone}',style: TextStyle(color: Colors.grey),),
          ],
        )
      ],
    ),
    Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(
        color: Colors.grey,
        height: 1.0,
      ),
    ),
  ],
);
