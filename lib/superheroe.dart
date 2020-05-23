import 'package:flutter/material.dart';
import 'main.dart';

class DetailPage extends StatelessWidget{
  final heroes hero;
  DetailPage(this.hero);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(hero.nombre.toString(),),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.5,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 19,
              left: 10.0,
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.10,
              child: Container(
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          height: 250.0,
                          width: 250.0,
                          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(hero.imagen.toString()))),
                        ),
                        new Padding(padding: EdgeInsets.all(10.0),),
                        Text(
                          hero.nombre.toString(),
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("Identidad: ${hero.identidad}",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black45
                          ),
                        ),
                        new Padding(padding: EdgeInsets.all(15.0),),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Edad: ${hero.edad}",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text("Altura: ${hero.altura}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text("Género: ${hero.genero}",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        new Padding(padding: EdgeInsets.all(10.0),),
                        Text("Descripción: ${hero.descripcion}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0
                          ),
                        ),
                        new Padding(padding: EdgeInsets.all(15.0),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}