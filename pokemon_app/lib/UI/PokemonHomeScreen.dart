import 'package:flutter/material.dart';

import 'package:pokemon_app/Model/PokeJson.dart';
import 'package:pokemon_app/Network/Services.dart';
import 'PokemonDetailScreen.dart';

class PokemonHomeScreen extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _PokemonHomeScreenState createState() => _PokemonHomeScreenState();
}

class _PokemonHomeScreenState extends State<PokemonHomeScreen> {
  PokeJson pokemon;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pokemon app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 3,
          centerTitle: true,
          title: Text(
            "Poke App",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          backgroundColor: Colors.cyan,
        ),
        body: FutureBuilder(
          future: Services().fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {

              pokemon =snapshot.data;
              return Center(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: pokemon.pokemon
                      .map((poke) => Padding(
                            padding: EdgeInsets.all(2.5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PokemonDetailScreen(
                                              pokemon: poke,
                                            )));
                              },
                              child: Hero(
                                tag: poke.img,
                                child: Card(
                                  elevation: 4,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(poke.img),
                                        )),
                                      ),
                                      Text(
                                        poke.name,
                                        textAlign: TextAlign.center,
                                        style: (TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.cyan[700]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
