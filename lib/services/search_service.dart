import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';

class SearchServices {
  Future<Map> getWordDataFromApi() async {
    try {
      var resp = await http.get(
          Uri.parse('${Constants().baseUrl}/entries/en-us/apple'),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'app_id': Constants().applicationId,
            'app_key': Constants().applicationKeys
          });
      var data = jsonDecode(resp.body);
      print(data);
      // Validations
      return data['results'][0];
    } catch (e) {
      print('Error getting the search from the api');
      return {};
    }
  }
}
