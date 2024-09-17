import 'dart:io';

import 'package:elanwar_agancy_flutter/core/providers/session_provider.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Platform.isAndroid
        ? SafeArea(
            child: Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/ABGMAnware.png",
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.80,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: SignInWithEmailButton(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 28, 128, 209),
                            ),
                            iconColor: WidgetStatePropertyAll(Colors.white)),
                        icon: const Icon(Icons.login),
                        label: const Text(
                          "الدخول ",
                          style: TextStyle(color: Colors.white),
                        ),
                        caller: singelton<ApiClient>().client.modules.auth,
                        onSignedIn: () {
                          ref.read(sessionProvider.notifier).updateUser();
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.02,
                      child: const Text(
                        "وكالة الأنوار السياحيـــة",
                        style: TextStyle(
                            fontFamily: "Aref",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      )),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.02,
                      child: const Text("وكـــالة",
                          style: TextStyle(
                              fontFamily: "Aref",
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 200))),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.2,
                      top: MediaQuery.of(context).size.height * 0.18,
                      child: const Text("سياحـــية",
                          style: TextStyle(
                              fontFamily: "Aref",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 180))),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.10,
                    bottom: MediaQuery.of(context).size.height * 0.336,
                    child: const Text(
                      "حج؟ عمرة؟ أو رحلات سفرية",
                      style: TextStyle(
                        fontFamily: "Aref",
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.21,
                    bottom: MediaQuery.of(context).size.height * 0.29,
                    child: const Text(
                      "إكتشف العالم معنا",
                      style: TextStyle(
                        fontFamily: "Aref",
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/ABGAnware.png",
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.22,
                    top: MediaQuery.of(context).size.height * 0.73,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: SignInWithEmailButton(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 28, 128, 209),
                            ),
                            iconColor: WidgetStatePropertyAll(Colors.white)),
                        icon: const Icon(Icons.login),
                        label: const Text(
                          "الدخول ",
                          style: TextStyle(color: Colors.white),
                        ),
                        caller: singelton<ApiClient>().client.modules.auth,
                        onSignedIn: () {
                          ref.read(sessionProvider.notifier).updateUser();
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.height * 0.06,
                      child: const Text(
                        "وكالة الأنوار السياحيـــة",
                        style: TextStyle(
                            fontFamily: "Aref",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      )),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.15,
                      top: MediaQuery.of(context).size.height * 0.08,
                      child: const Text("وكـــالة",
                          style: TextStyle(
                              fontFamily: "Aref",
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 200))),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.15,
                      top: MediaQuery.of(context).size.height * 0.28,
                      child: const Text("سياحـــية",
                          style: TextStyle(
                              fontFamily: "Aref",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 180))),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.175,
                    bottom: MediaQuery.of(context).size.height * 0.336,
                    child: const Text(
                      "حج؟ عمرة؟ أو رحلات سفرية",
                      style: TextStyle(
                        fontFamily: "Aref",
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.21,
                    bottom: MediaQuery.of(context).size.height * 0.29,
                    child: const Text(
                      "إكتشف العالم معنا",
                      style: TextStyle(
                        fontFamily: "Aref",
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
