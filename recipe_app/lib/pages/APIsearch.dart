import 'dart:convert';
import 'package:http/http.dart' as http;


// Function for basic API search, takes in one string query e.g. "chicken"
Future<void> searchRecipes(stringQuery) async {
  const String appID = "87adcf60";
  const String appKey = "API KEY NOT PASTED FOR SECURITY REASONS"; //Next steps will be to implement an environment variable for this that is not in the version control

  final String url = "https://api.edamam.com/search?q=$stringQuery&app_id=$appID&app_key=$appKey"; //Standard format of url for API search

  try {
    final response = await http.get(Uri.parse(url)); //Get request to API

    if (response.statusCode == 200) { //If the response is successful
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data'); //If the response is not successful
    }
  } catch (e) { //Catch any errors
    print(e.toString()); //Print the error, will need to be changed for production version
  }
}