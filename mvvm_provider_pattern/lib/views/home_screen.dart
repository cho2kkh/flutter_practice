import 'package:flutter/material.dart';
import 'package:mvvm_provider_pattern/models/user_model.dart';
import 'package:mvvm_provider_pattern/utils/constants.dart';
import 'package:mvvm_provider_pattern/view_models/users_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersViewModel usersViewModel = Provider.of<UsersViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            onPressed: () async {
              usersViewModel.getUsers();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _ui(usersViewModel),
          ],
        ),
      ),
    );
  }

  _ui(UsersViewModel usersViewModel) {
    if (usersViewModel.loadingStatus == LoadingStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (usersViewModel.error != null) {
      return Center(
        child: Text(usersViewModel.error!.errorResponse.toString()),
      );
    }
    if (usersViewModel.loadingStatus == LoadingStatus.empty) {
      return const Center(
        child: Text("empty"),
      );
    }
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          UserModel userModel = usersViewModel.userListModel[index];
          return ListTile(
            onTap: () {},
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.person),
            ),
            title: Text(userModel.name),
            subtitle: Text(userModel.email),
            trailing: const Icon(Icons.chevron_right),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: usersViewModel.userListModel.length,
      ),
    );
  }
}
