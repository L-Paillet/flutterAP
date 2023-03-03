import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Livre {
  static String baseUrl = "http://localhost:8000";
  static Future<List> getAllLivre() async{
    try {
      var res = await http.get(Uri.parse(baseUrl+'/produits'));

      if(res.statusCode == 200){
        print(res.body);
        return jsonDecode(res.body);
      }
      else {
        return Future.error("erreur serveur");
      }
    }
    catch(err) {
      return Future.error(err);
    }
  }

  static Login(BuildContext context, login, password) async {
     try {
      var connection = {"email": login, "password": password};
      var res = await http.post(
        Uri.parse("http://localhost:8000/login"),
        body: connection
        );
      if(res.statusCode == 200) {
        Navigator.pushNamed(context, '/produits');
      }
      else{
        Navigator.pushNamed(context, '/');
      }
    }

    catch(err) {
      return Future.error(err);
    }
   }

  static ajout(BuildContext context, title, body) async{
    try{
     
      Map<String,dynamic> data = {"title":title,"body":body};
      var res = await http.post(
        Uri.parse(baseUrl+'/posts'), 
        body: data
        );
      if(res.statusCode == 201) {
        Navigator.pushNamed(context, '/utilisateurs', arguments: res.body);
      }
      
      else{
        Navigator.pushNamed(context, '/');
      }
    }

    catch(err) {
      return Future.error(err);
    }
  }
}