
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/Model/PokeJson.dart';
class Services{

  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  //fetch data from the api and fill up object to use it in UI
  Future<PokeJson> fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    return  PokeJson.fromJson(decodedJson);

  }


}