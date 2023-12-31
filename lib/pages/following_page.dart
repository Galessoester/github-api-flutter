import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/pages/base_page.dart';

class FollowingPage extends StatefulWidget {
  final User user;
  const FollowingPage(this.user);

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  late Future<List<User>> _futureFollowing;

  @override
  void initState() {
    _futureFollowing = GithubApi().listFollowing(widget.user.login);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              // Lista de usuários seguindo
              child: FutureBuilder<List<User>>(
            future: _futureFollowing,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Erro'),
                );
              }

              var following = snapshot.data ?? [];
              return ListView.separated(
                itemCount: following.length,
                itemBuilder: ((context, i) {
                  var user = following[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    title: Text(user.login),
                    trailing: const Text(
                      'Following',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BasePage(user),
                        ),
                      );
                    },
                  );
                }),
                separatorBuilder: (context, index) {
                  return Divider();
                },
              );
            },
          )),
        ]),
      ),
    );
  }
}
