import 'dart:convert';

import 'package:covid_tracker/Model/WorldStateModel.dart';
import 'package:covid_tracker/View/world_state.dart';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StateServices {
  //for showing world state
  Future<WorldStatesModel> fetchWorldStateRecord() async {
    final response = await http.get(Uri.parse(ApiUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  //for showing country list
  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(ApiUrl.countriesList));
    if (response.statusCode == 200) {
      var data;
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
