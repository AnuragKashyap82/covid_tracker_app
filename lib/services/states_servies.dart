import 'dart:convert';

import 'package:covid_tracker/services/utilities/app_uri.dart';
import 'package:http/http.dart' as http;

import '../models/WorldStatesModel.dart';

class StatesServices{

  Future<WorldStatesModel> fetchWorldStatesRecords() async{

    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countriesListApi() async{

    var data;
    final response = await http.get(Uri.parse(AppUrl.countryList));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("Error");
    }
  }
}