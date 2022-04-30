// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/signup_page.dart';
import 'package:senior_project/splash.dart';
import 'package:senior_project/welcome_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'auth_controller.dart';
import 'camera_bpm/calc_heart.dart';
import 'google_sign_in.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  //await Firebase.initializeApp().then((value) => Get.put(GoogleSignInProvider()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  /*Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
        child: GetMaterialApp(
          title: 'title',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:LoginPage()
        ),
  );
  /*{
    return GetMaterialApp(
      title: 'Welcome to Flutter',
        theme: ThemeData(
    primarySwatch: Colors.blue,
    ),
    home: LoginPage()
    );
  }*/
}*/

Widget build(BuildContext context) {
  return GetMaterialApp(
    title: 'Welcome to Flutter',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    //home: LoginPage()
    home: Splash()
  );
  }
  }