import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/auth_provider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              // auth_provider.userSignOut().then(
              //       (value) => exit(0),
              // );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple,
                backgroundImage: NetworkImage(auth_provider.userModel.profilePic),
                radius: 50,
              ),
              const SizedBox(height: 20),
              Text(auth_provider.userModel.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Text(auth_provider.userModel.phoneNumber, style: TextStyle(fontSize: 18),),
              Text(auth_provider.userModel.email, style: TextStyle(fontSize: 18),),
            ],
          )),
    );
  }
}
