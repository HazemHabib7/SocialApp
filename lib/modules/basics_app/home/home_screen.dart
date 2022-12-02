import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Icon(Icons.abc),
        title: Text("Hazem"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.access_alarm_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: 200.0,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image(
                  image: NetworkImage(
                      "https://static.pexels.com/photos/36753/flower-purple-lical-blosso.jpg",),
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                color: Colors.black.withOpacity(0.1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 10.0
                    ),
                    child: Text(
                'Flower',
                style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
              ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
