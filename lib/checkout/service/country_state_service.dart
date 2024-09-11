

import 'dart:convert';

import '../../util/util.dart';
import '../model/country.dart';
import 'package:http/http.dart' as http;

import '../model/state.dart';

class CountryStateService {


  static Future<List<Country>> fetchCountries() async{

    const String fetchCountriesUrl = '${Util.apiUrl}/countries';

    final response = await http.get(Uri.parse(fetchCountriesUrl));

    if (response.statusCode == 200) {
      // Util.logOutput('Success: ${response.statusCode}');
      // If the server returns a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> countriesData = jsonData['_embedded']['countries'];

      return countriesData
          .map((jsonCountry) => Country.fromJson(jsonCountry))
          .toList();
    } else {
      Util.logOutput('Error: problem');
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<List<State>> fetchStates(String code) async{

    String fetchStatesUrl = '${Util.apiUrl}/states/search/findStatesByCountry_Code?code=$code';

    final response = await http.get(Uri.parse(fetchStatesUrl));

    if (response.statusCode == 200) {
      // Util.logOutput('Success: ${response.statusCode}');
      // If the server returns a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> statesData = jsonData['_embedded']['states'];

      return statesData
          .map((jsonState) => State.fromJson(jsonState))
          .toList();
    } else {
      Util.logOutput('Error: problem');
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


}