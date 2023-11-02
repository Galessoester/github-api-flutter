// https://api.github.com/users/octocat
// https://api.github.com/users/octocat/following

// https://api.github.com/users/octocat
// https://api.github.com/users/octocat/following

//https://gist.github.com/dcvieira/c6761dae253759d2f788dc552d35cb8d

import 'dart:convert';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  final String baseUrl = 'https://api.github.com/';
  final String token = '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';

  Future<User?> findUser(String userName) async {
    final url = '${baseUrl}users/$userName';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var user = User.fromJson(json);

      return user;
    } else {
      return null;
    }
  }

  Future<List<User>> listFollowing(String userName) async {
    final url = '${baseUrl}users/$userName/following';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      var users = jsonList.map((json) => User.fromJson(json)).toList();

      return users;
    }
    return [];
  }

  Future<List<User>> listFollowers(String userName) async {
    final url = '${baseUrl}users/$userName/followers';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      var users = jsonList.map((json) => User.fromJson(json)).toList();

      return users;
    }
    return [];
  }

  Future<List<User>> listRepositories(String userName) async {
    final url = '${baseUrl}users/$userName/repos';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      var users = jsonList.map((json) => User.fromJson(json)).toList();

      return users;
    }
    return [];
  }
}
