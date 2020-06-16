import 'package:flutter/material.dart';
import 'package:event/Controllers/databasehelper.dart';
import 'package:event/View/dashboard.dart';
import 'package:event/View/register.dart';
import 'package:url_launcher/url_launcher.dart';

class AddData extends StatefulWidget{

  AddData({Key key , this.title}) : super(key : key);
  final String title;



  @override
  AddDataState  createState() => AddDataState();
}

class AddDataState extends State<AddData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();



  final TextEditingController _micropostController = new TextEditingController();
  //final TextEditingController _priceController = new TextEditingController();



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Add Micropost',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Hello!'),
          backgroundColor: Colors.purple,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.settings_backup_restore), 
      onPressed: (){
        Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new AddData(),
                        )
                    );
      } ),
            IconButton(icon: Icon(Icons.arrow_back), 
      onPressed: (){
        Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new Dashboard(),
                        )
                    );
      } ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
     
      onPressed: (){ Navigator.pushReplacementNamed(context, '/dashboard');
},
      child: Icon(Icons.subdirectory_arrow_right),
      backgroundColor: Colors.purple,
    ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              Container(
                height: 100,
                child: new TextField(
                  
                  controller: _micropostController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintMaxLines: 99,
                    labelText: 'Event Details',
                    hintText: 'Details',
                    icon: new Icon(Icons.add_comment),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      )
                    ),
                  ),
                ),
              ),

              /*Container(
                height: 50,
                child: new TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'Place your price',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),
*/
SizedBox(height:20.0),
              Container(
                height: 35,
                width: 20,
                child: new RaisedButton(
                  onPressed: (){
                    databaseHelper.addMicropostData(
                        _micropostController.text,
                        //_priceController.text.trim(),
                        );
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new Dashboard(),
                        )
                    );
                  },
                  color: Colors.deepPurple,
                  child: new Text(
                    'Post',
                    style: new TextStyle(
                        color: Colors.white,
                        ),
                        ),
                ),
              ),
              Divider(height: 100,),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Thank you...'),
                Text('Get full features, please visit our website.'),
                IconButton(icon: Icon(Icons.cast_connected), color: Colors.green,
          onPressed: (){
            return launch('https://obscure-hollows-36531.herokuapp.com/');
          // Navigator.pushReplacementNamed(context, '/login');
          }),
                  ]
                )
              ),


            ],
          ),
        ),
      ),
    );
  }



}