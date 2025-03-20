// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_present/bloc/darkmode/theme_bloc.dart';
import 'package:go_present/bloc/homePage/user_bloc.dart';
import 'package:go_present/bloc/homePage/user_event.dart';
import 'package:go_present/bloc/loginPage/login_bloc.dart';
import 'package:go_present/bloc/loginPage/login_event.dart';
import 'package:go_present/bloc/loginPage/login_state.dart';
import 'package:go_present/screens/navbar/navbar.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSucces) {
            context.read<UserBloc>().add(FetchUserProfile());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WidgetNavbar()),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            BlocBuilder<ThemeBloc, ThemeData>(
                              builder: (context, theme) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      alignment: Alignment.topRight,
                                      onPressed: () {
                                        context
                                            .read<ThemeBloc>()
                                            .add(ToggleThemeEvent());
                                      },
                                      icon: Icon(
                                        theme.brightness == Brightness.dark
                                            ? Icons.light_mode_outlined
                                            : Icons.dark_mode_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: const Image(
                                  image: AssetImage(
                                      'assets/image/logo-login.png')),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Hi, Welcome Back!",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  hintText: 'Masukkan username',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Masukkan password',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  if (usernameController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Username atau password tidak boleh kosong'),
                                      ),
                                    );
                                  } else {
                                    context.read<LoginBloc>().add(
                                          LoginSubmitted(
                                            username: usernameController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            const Text("Copyright 2025"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Jika dalam state LoginLoading, tampilkan loading overlay
              if (state is LoginLoading)
                Container(
                  color: Colors.black.withOpacity(0.5), // Background transparan
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white, // Warna putih agar terlihat jelas
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
