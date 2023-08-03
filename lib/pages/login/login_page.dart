import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_2/bloc/login/login_bloc.dart';

import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';

bool rememberMe = false;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is Logined) {
            AppNavigator.pushAndRemoveUntil(Routes.homePage);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text("Remember me"),
                      contentPadding: EdgeInsets.zero,
                      value: rememberMe,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (newValue) {
                        setState(
                          () {
                            rememberMe = newValue!;
                          },
                        );
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      if (state is LoginLoading) {
                        return Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {}
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                ),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                            const Text("please wait..."),
                          ],
                        );
                      } else if (state is LoginError) {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {}
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 15, 40, 15),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(state.error),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {}
                                String username = _usernameController.text;
                                String password = _passwordController.text;
                                context.read<LoginBloc>().add((LoginEvent(
                                    userName: username, passWord: password)));
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 15, 40, 15),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(""),
                          ],
                        );
                      }
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
