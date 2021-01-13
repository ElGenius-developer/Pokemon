
import 'package:flutter/material.dart';
import 'package:pokemon_app/Model/PokeJson.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
    children: [
      // Padding(padding: EdgeInsets.all(15)),
      Positioned(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * .1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 100),
              Text(
                pokemon.name,
                style:
                TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text("Height: ${pokemon.height}"),
              Text("Weight: ${pokemon.weight}"),
              Text(
                "Types",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.type
                      .map((e) => FilterChip(
                    backgroundColor: Colors.amber,
                    elevation: 2,
                    label: Text(
                      e,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onSelected: (bool value) {},
                  ))
                      .toList()),
              Text(
                "Weaknesses",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses
                    .map((w) => FilterChip(
                  backgroundColor: Colors.red,
                  label: Text(
                    w,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onSelected: (bool value) {},
                  elevation: 2,
                ))
                    .toList(),
              ),
              Text(
                "Next Evolution",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: (pokemon.nextEvolution == null)
                      ? [Text("This is the final Generation")]
                      : pokemon.nextEvolution
                      .map((n) => FilterChip(
                    elevation: 2,
                    backgroundColor: Colors.green,
                    label: Text(
                      n.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onSelected: (bool value) {},
                  ))
                      .toList()),
            ],
          ),
          elevation: 5,
        ),
      ),

      Align(
        alignment: Alignment.topCenter,
        child: Hero(
            tag: pokemon.img,
            child: Container(
              height: 210.0,
              width: 200.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
            )),
      )
    ],
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.cyan,
    appBar: AppBar(
      elevation: 0.0,
      backgroundColor: Colors.cyan,
      title: Text("${pokemon.name} Details"),
    ),
    body: bodyWidget(context),
  );
}
