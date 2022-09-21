import 'dart:convert' as convert;

import 'package:dio/dio.dart';

class ReceiveData {

  getData() async{
    try{
      var response = await Dio().get('http://192.168.1.8/skin');
      print(response.statusCode);
      final jsonData = convert.jsonDecode(response.data);
    }catch(error) {
      print(error);
    }
  }
}