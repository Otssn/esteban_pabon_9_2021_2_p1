import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:harry_potter_app/helpers/constans.dart';
import 'package:harry_potter_app/models/character.dart';
import 'package:harry_potter_app/models/response.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<Responses> getCharacters() async {
    var url = Uri.parse(Constans.apiUrl);
    var response = await http.get(url, headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
    });
    List<character> list = [];
    var body = response.body;
    if (response.statusCode >= 400) {
      return Responses(isSuccess: false, messaje: body);
    }
    var decodejson = jsonDecode(body);
    if (decodejson != null) {
      for (var item in decodejson) {
        list.add(character.fromJson(item));
      }
    }
    return Responses(isSuccess: true, result: list);
  }
}
