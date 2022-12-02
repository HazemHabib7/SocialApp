import 'package:flutter/material.dart';
import 'package:udemy/shared/components/adaptive/adaptive_indicator.dart';
import 'package:udemy/shared/components/constants.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(child: Container(height: double.infinity,color: Colors.teal,)),
            Expanded(flex: 2,child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Login now to see new futures ...'.toUpperCase(),style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: 'Email Address',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: 'Password',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(onPressed: (){},color: Colors.green,height: 40.0,child: Text('LOGIN',style: TextStyle(color: Colors.white),),),
                    )),
                    SizedBox(width: 10.0,),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(onPressed: (){},color: Colors.blue,height: 40.0,child: Text('REGISTER',style: TextStyle(color: Colors.white),),),
                    )),
                  ],
                ),
              ],
            )),
            AdaptiveIndicator(os:getOS()),
          ],
        ));
  }
}
