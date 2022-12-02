import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy/layout/news_app/cubit/cubit.dart';
import 'package:udemy/shared/styles/icon_broken.dart';
import '../../layout/todo_app/cubit/cubit.dart';
import '../../modules/news_app/web_view/web_view_screen.dart';

Widget defaultButton({
  required Function function,
  required String text,
  bool isUpper = true,
  Color color = Colors.blue,
  double radius = 0.0,
  double width = double.infinity,
  double height = 50.0,
}) =>
    Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius)),
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultOutlinedButton({
  required Function function,
  required String text,
  bool isUpper = true,
  double radius = 0.0,
  double width = double.infinity,
  double height = 50.0,
}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius)),
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpper ? text.toUpperCase() : text,
        ),
      ),
    );

PreferredSizeWidget defaultAppBar({
  required context,
  required String title,
  List<Widget>? actions,
}){
  return AppBar(
    leading:
    IconButton(
      icon: Icon(IconBroken.Arrow___Left_2), onPressed: () {Navigator.pop(context);},
    ),
    title: Text(title),
    actions: actions,
  );
}

Widget defaultTextFormField({
  required String validateText,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  required Icon prefixIcon,
  Widget? suffixIcon = null,
  bool isPassword = false,
  Function? onSubmit,
  Function? onTap,
  Function? onChange,
  bool readOnly = false,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(

        validator: (value) {
          if (value!.isEmpty) {
            return validateText;
          }
        },
        onTap: () {
          onTap!();
        },
        readOnly: readOnly,
        obscureText: isPassword,
        controller: controller,
        onFieldSubmitted: (value) {
          onSubmit!();
        },
        onChanged: (value) {
          onChange!();
        },
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: Colors.white,

          labelText: label,
          border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.white),
      ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );

Widget taskItem(Map task, context) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed:(direction){
      TodoCubit.get(context).deleteFromDatabase(id: task['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            child: Text('${task['time']}'),
            radius: 35.0,
          ),
          SizedBox(
            width: 25.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${task['title']}",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${task['date']}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                TodoCubit.get(context)
                    .updateDatabase(status: 'done', id: task['id']);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          SizedBox(
            width: 6.0,
          ),
          IconButton(
              onPressed: () {
                TodoCubit.get(context)
                    .updateDatabase(status: 'archive', id: task['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.blue,
              )),
        ],
      ),
    ),
  );
}

Widget emptyScreen(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,size: 100.0,color: Colors.grey,),
        Text('There Are No Tasks Yet,Please Add Some Tasks',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 14.0),)
      ],
    ),
  );
}

Widget buildArticle(List<dynamic> article,int number,context){
  return Container(
    color: NewsCubit.get(context).selectedItem==number && NewsCubit.get(context).isDesktop ? Colors.grey[200] : null,
    child: InkWell(
      onTap: (){
        // navigateTo(context, WebViewScreen('https://www.google.com/'));
        NewsCubit.get(context).selectedItemMethod(number);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:6.0),
              child: Container(
                width: 135.0,
                height: 135.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${article[number]['urlToImage']}'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              child: Container(
                height: 135.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text('${article[number]['title']}',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0)),
                    ),
                    Text('${article[number]['publishedAt']}',style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildDivider(){
  return Padding(
    padding: const EdgeInsets.only(left: 20.0),
    child: Container(
      color: Colors.grey[300],
      height: 1.0,
      width: double.infinity,
    ),
  );
}

Widget buildArticleList({required List<dynamic> list,bool isSearch=false}){
  if(list.length!=0) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticle(list, index, context),
        separatorBuilder: (context, index) => buildDivider(),
        itemCount: list.length);
  }
  else if(list.length==0 && isSearch == true) {
    return Container();
  }
  else
  {
    return Center(child: CircularProgressIndicator());

  }
}

Future navigateTo (context,widget){
  return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget
  ));

}

Future navigateAndFinish (context,widget){
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget
      ),
    (route) {
      return false;
    },
  );

}

Widget defaultTextButton({
  required Function function,
  required String text,
  required Color color,
  bool isUpper = true,
})
{
  return TextButton(onPressed: (){
    function();
  }, child: Text(isUpper ? text.toUpperCase() : text,style: TextStyle(color: color),));
}

Future<bool?> defaultToast({
  required String message,
  required ToastStates state,
}){
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: chooseToastColor(state),
  );
}

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;

}