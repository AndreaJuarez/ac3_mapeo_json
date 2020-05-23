import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:act3_mapeo_json/superheroe.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MaterialApp(
  home: new MyApp(),
  //theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Center'),
  debugShowCheckedModeBanner: false,
));


class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      image: Image.network(
        "https://img.wallpapersafari.com/desktop/1680/1050/67/44/PFfx81.jpg",
        //"https://deffinition.co.uk/wp-content/uploads/2017/06/Xmen-Reviews-Graphic-Novels-Game-and-Movie-930x1024.png",
      ),
      title: new Text(
        'Welcome!',
        style: new TextStyle(
            fontSize: 25.0, color: Colors.black),
      ),
      photoSize: 200.0,
      seconds: 5,
      backgroundColor: Colors.white,
      navigateAfterSeconds: new AfterSplash(),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Carter'),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget{
  @override
  _myHomePageState createState()=>new _myHomePageState();
}

class _myHomePageState extends State<homePage> {

  //METODO ASINCRONO PARA LEER EL JSON
  Future<String> _loadAsset() async{
    return await rootBundle.loadString('assets/person.json');
  }

  Future<List<heroes>> _getHeroes() async{
    String jsonString = await _loadAsset();
    var jsonData = jsonDecode(jsonString);
    print(jsonData.toString());

    //MAPEAR A UNA LISTA
    List<heroes> heros = [];
    for (var h in jsonData){
      heroes he  = heroes(h["imagen"], h["nombre"], h["identidad"], h["edad"], h["altura"], h["genero"], h["descripcion"]);
      heros.add(he);
    }
    print("Numero de elementos");
    print(heros.length);
    return heros;
  }

  //ELEMENTO PARA BUSQUEDA
  String searchString = "";
  bool _isSearching = false;
  final searchController = TextEditingController();

  AudioPlayer audioPlayer;
  AudioCache audioCache;

  final audio = "audio.mp3";

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioCache = AudioCache();
    var loop = 1;

    setState(() {
      audioCache.play(audio);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: _isSearching ? TextField(
          decoration: InputDecoration(
              hintText: "Buscando..."),
          onChanged: (value) {
            setState(() {
              searchString = value;
            });
          },
          controller: searchController,
        )
            :Text("JSON RELOADED",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: <Widget>[
          !_isSearching ? IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                searchString = "";
                this._isSearching = !this._isSearching;
              });
            },
          )
              :IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                this._isSearching = !this._isSearching;
              });
            },
          )
         ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
         child: FutureBuilder(
          future: _getHeroes(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Cargando..."),
                ),
              );
            }else{
              return ListView.builder(
                scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    print("Data Value: $snapshot.data[index].imagen.toStrng()");
                    return snapshot.data[index].nombre.contains(searchString) ?
                         ListTile(
                            leading: CircleAvatar(
                              minRadius: 30.0,
                              maxRadius:  30.0,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(snapshot.data[index].imagen.toString(),),),
                            title: new Text(snapshot.data[index].nombre.toString(),
                            style: TextStyle(
                              fontSize: 18),
                            ),
                            subtitle: new Text(snapshot.data[index].identidad.toString(),
                            style: TextStyle(
                              fontSize: 15),
                            ),
                            onTap: (){
                              Navigator.push(context,
                                new MaterialPageRoute(builder: (context)=> DetailPage(snapshot.data[index])));
                      },
                    )
                        :Container();
                  }
              );
            }
          },
        ),
       ),
      ),
    );
  }
}

//CLASE QUE SE ENCARGA DE MAPEAR EL JSON
class heroes {
  final String imagen;
  final String nombre;
  final String identidad;
  final String edad;
  final String altura;
  final String genero;
  final String descripcion;

  heroes(this.imagen, this.nombre, this.identidad, this.edad, this.altura, this.genero, this.descripcion);
}
