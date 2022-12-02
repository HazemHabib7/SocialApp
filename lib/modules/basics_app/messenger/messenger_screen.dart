import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 10.0,
          ),
        ),
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 8.0,
        actions: [
          CircleAvatar(
            radius: 19.0,
              child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera_alt_outlined),

          )),
          SizedBox(width: 10.0),
          CircleAvatar(
            radius: 19.0,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.edit),splashRadius: 25.0,)),
          SizedBox(
            width: 8.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                    prefixIcon: Icon(Icons.search_outlined),
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              height: 140.0,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildContainer(),
                  separatorBuilder: (context, index) => SizedBox(width: 3.0,),
                  itemCount: 8,
              ),
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemBuilder: (context, index) => buildRow(),
                separatorBuilder: (context, index) => SizedBox(height: 5.0,),
                itemCount: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow() => Row(
    children: [
      Container(
        width: 90.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hazem Habib',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Expanded(
                  child: Text('My name is Hazem Habib',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),
                SizedBox(width: 10.0,),
                Text('02:55 PM',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      )
    ],
  );
  Widget buildContainer() => Container(
    width: 90.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.0,),
          Text('Hazem Habib',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );


}
