import 'package:flutter/material.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/pages/followers_page.dart';
import 'package:github_api_demo/pages/following_page.dart';

class BasePage extends StatefulWidget {
  final User user;
  const BasePage(this.user);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seu perfil'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.blue,
                      backgroundImage: NetworkImage(widget.user.avatarUrl),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.user.login,
                    style: const TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.people,
                    color: Colors.black,
                  ),
                  child: Text(
                    'Following',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.people_alt_outlined,
                    color: Colors.black,
                  ),
                  child: Text(
                    'Followers',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.book,
                    color: Colors.black,
                  ),
                  child: Text(
                    'Repository',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FollowingPage(widget.user),
                  FollowersPage(widget.user),
                  FollowersPage(widget.user),
                  Icon(Icons.directions_bike),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
