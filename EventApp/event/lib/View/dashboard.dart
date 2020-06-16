import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:event/Controllers/databasehelper.dart';
import 'package:event/View/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);
  final String title;
  @override
  DashboardState createState() => new DashboardState();
}
class DashboardState extends State<Dashboard> {
  Map data;
  List userData;
  Future<Map> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://obscure-hollows-36531.herokuapp.com/api/v1/microposts"),
      headers: {
        'Content-Type': 'application/json',
    'Authorization' : '#YOUR_TOKEN',
      }
    );

    this.setState(() {
      data = json.decode(response.body);
      userData = data['data'];
    });
    
//    print(userData);
print(userData[0]['attributes']['content']);
    
   // return 'Success!';
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,

          actions: <Widget>[
            IconButton(icon: Icon(Icons.location_on), 
          onPressed: (){
            return launch('https://www.google.com/maps/');
          // Navigator.pushReplacementNamed(context, '/login');
          }),
      IconButton(icon: Icon(Icons.settings_backup_restore), 
      onPressed: (){
        Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new Dashboard(),
                        )
                    );
      } ),
      IconButton(icon: Icon(Icons.cancel), 
          onPressed: (){
           Navigator.pushReplacementNamed(context, '/login');
          }),],),

          floatingActionButton: FloatingActionButton(
     
      onPressed: (){ Navigator.pushReplacementNamed(context, '/adddata');
},
      child: Icon(Icons.add_box),
      backgroundColor: Colors.green,
    ),

          drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("Multiplatform Based Events Solution", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 16),
              ),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            Card(
              child: Column(
                children:<Widget>[
                  ExpansionTile(title: Text('Profile'),
                  children:<Widget>[
                    ListTile(
              title: Text('Edit Profile'),
              onTap: () => launch('https://obscure-hollows-36531.herokuapp.com/'),
            ),
            ListTile(
              title: Text('Delete Profile'),
              onTap: () => launch('https://obscure-hollows-36531.herokuapp.com/'),
            ),
                  ]),

            Divider(height: 5.0,),
            ExpansionTile(title: Text('Events'),
                  children:<Widget>[
                    ListTile(
              title: Text('My Event'),
              onTap: () => launch('https://obscure-hollows-36531.herokuapp.com/'),
            ),
            ListTile(
              title: Text('Edit Event'),
              onTap: () => launch('https://obscure-hollows-36531.herokuapp.com/'),
            ),
            ListTile(
              title: Text('Delete Event'),
              onTap: () => launch('https://obscure-hollows-36531.herokuapp.com/'),
            ),
                  ]),

            Divider(height: 5.0,),
            ListTile(
              title: Text('About'),
              onTap: () => launch('https://obscure-hollows-36531.herokuapp.com/'),
            ),
                ]
              ),
            )
          ],
        ),
        ),
        body: Stack(
            children: <Widget>[
              Container(
                color: Colors.deepPurple,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 150),
                      Text('WELCOME',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white ),
                      ),
//                      SizedBox(height: 25),
                      Text("''one platform, all events''",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30, color: Colors.white60 ),
                      ),
                       SizedBox(height: 110),
                      Text(
                    "swipe up!",
                    style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                    ],
                  ),
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: DraggableScrollableSheet(
                  maxChildSize: 0.9,
                  initialChildSize: 0.2,
                  minChildSize: 0.2,
                  builder: (context, scrollController) {
                    return Container(
                      child: ListView.builder(
                        itemCount: userData == null ? 0 : userData.length,
                        controller: scrollController,
                        itemBuilder: (BuildContext context, int index){
            return new Card(
              child: new Text(userData[index]['attributes']['content'], 
              textAlign: TextAlign.start,
                  //overflow: TextOverflow.ellipsis,
                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            );
          },
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
    
                        /// To set a shadow behind the parent container
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, -2.0),
                            blurRadius: 4.0,
                          ),
                        ],
    
                        /// To set radius of top left and top right
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
  }
}

