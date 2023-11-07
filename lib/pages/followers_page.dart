import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/pages/base_page.dart';

class FollowersPage extends StatefulWidget {
  final User user;
  const FollowersPage(this.user);

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  late Future<List<User>> _futureFollowers;
  late List<User> _followers = [];
//   late Future<User?> usuario;

  @override
  void initState() {
//     usuario = GithubApi().findUser(widget.user.login);
    _futureFollowers = GithubApi().listFollowers(widget.user.login);
    _carregarSeguidores();
    super.initState();
  }

  Future<void> _carregarSeguidores() async {
    final followers = await _futureFollowers;
    setState(() {
      _followers = followers;
    });
  }

  void _ordemAlfabetica() {
    setState(() {
      _followers.sort((a, b) => a.login.compareTo(b.login));
    });
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
            future: _futureFollowers,
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

              var followers = snapshot.data ?? [];
              return ListView.separated(
                itemCount: followers.length,
                itemBuilder: ((context, i) {
                  var follower = followers[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(follower.avatarUrl),
                    ),
                    title: Text(follower.login),
                    // trailing: Text(''),
                    // trailing: user.name == null
                    //     ? const Text('')
                    //     : Text(
                    //         user.name!,
                    //         style: const TextStyle(color: Colors.black),
                    //       ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BasePage(follower),
                        ),
                      );
                    },
                  );
                }),
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            },
          )),
          ElevatedButton(
            onPressed: _ordemAlfabetica,
            child: const Text('Ordenar por Nome'),
          ),
        ]),
      ),
    );
  }
}
