import 'dart:convert';

import 'package:untitled1/common/widgets/bottom_bar.dart';
import 'package:untitled1/constains/error_handling.dart';
import 'package:untitled1/constains/global_variables.dart';
import 'package:untitled1/constains/global_variables.dart';
import 'package:untitled1/constains/utils.dart';
import 'package:untitled1/home/screen/home_screen.dart';
import 'package:untitled1/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constains/global_variables.dart';
import '../../../constains/global_variables.dart';
import '../../../providers/user_provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: "",
          name: name,
          password: password,
          email: email,
          address: '',
          type: '',
          token: '', cart: []);
      https.Response res = await https.post(
        Uri.parse("$uri"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Muvvaffaqiyatli Bajarildi !");
          });
      print(res.statusCode);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      https.Response res = await https.post(
        Uri.parse("$ur1"),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamed(
              context,
              BottomBar.routeName,
            );
          });
      print(res.statusCode);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get User Data
  void getUserData(
      BuildContext context,
      ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await https.post(
        Uri.parse('$uris/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        https.Response userRes = await https.get(
          Uri.parse('$uris/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}