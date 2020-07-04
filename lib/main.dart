import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mortiest Mortys',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
       
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Mortiest Mortys'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//future - async function

Future<List<Morty>> _getMortys() async {

  var data = await http.get("https://rickandmortyapi.com/api/character/2,14,18,21,27,42,43,44,53,61,73,77,83,84,85,95,113,118,123,143,152,200,206,209,217,229,231,232,233,234,235,298,325,359,360,366,392,473,474,475,476,480,499,505,518");
  
  var jsonData = json.decode(data.body);

  List<Morty> mortys = [];

  for(var u in jsonData){

    Morty morty = Morty(u["index"], u["name"], u["status"], u["type"], u["species"], u["gender"], u["orgin"], u["locationName"], u["image"]);

    mortys.add(morty);

  }

  print(mortys.length);

  return mortys;

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getMortys(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Loading...")
                  )
              );
            }
            else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data[index].image
                    ),
                  ),
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].species),
                );

              },
            );
          }
        }
      ),
    ),
  );
}
}

class Morty{

final int index;
final String name;
final String status;
final String type;
final String species;
final String gender;
List orgin;
List locationName;
final String image;

Morty(this.index, this.name, this.status, this.type, this.species, this.gender, this.orgin, this.locationName, this.image);

}
