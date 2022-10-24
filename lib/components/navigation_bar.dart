// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:doctor/api/storage.dart';
import 'package:doctor/patient/patient.dart';
import 'package:doctor/profile/profile.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar>{
  String token = "";
  StorageService _storageService = StorageService();

  @override
  void initState(){
    super.initState();
    _storageService.readSecureData("token").then((value) => {
      print("In"),
      print(value),
      this.token = value!,
      print("Intoken"),
      print(this.token),
    });
    print("Out");
    print(this.token);
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    print(this.token);
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
          this.token
      ),
      accountEmail: const Text(
          "test"
      ),
      currentAccountPicture: const CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );
    final drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: const Text(
              "Patients"
          ),
          selected: widget.title == "Patients",
          leading: const Icon(Icons.comment),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Patient(title: "Patients"),
              ),
            );
          },
        ),
        ListTile(
          title: const Text(
              "About me"
          ),
          selected: widget.title == "About me",
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(title: "About me"),
              ),
            );
          },
        ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
