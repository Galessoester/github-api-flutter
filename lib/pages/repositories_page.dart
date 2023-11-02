import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/models/user.dart';
import 'package:github_api_demo/pages/base_page.dart';

class RepositoryPage extends StatefulWidget {
  final User user;
  const RepositoryPage(this.user);

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  late Future<List<User>> _futureRepositories;

  @override
  void initState() {
    _futureRepositories = GithubApi().listRepositories(widget.user.login);
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
            future: _futureRepositories,
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

              var repositories = snapshot.data ?? [];
              return ListView.separated(
                itemCount: repositories.length,
                itemBuilder: ((context, i) {
                  var user = repositories[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    title: Text(user.login),
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
