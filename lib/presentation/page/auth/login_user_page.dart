import 'package:connect_app/presentation/page/auth/auth_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginUserPage extends StatefulWidget {
  const LoginUserPage({Key? key}) : super(key: key);

  @override
  State<LoginUserPage> createState() => _LoginUserPageState();
}

class _LoginUserPageState extends State<LoginUserPage> {
  late AuthBloc authBloc;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    authBloc = GetIt.instance<AuthBloc>();
    emailController.text = 'b@mail.com';
    passwordController.text = '1q2w3e4r';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login for users'),
          centerTitle: true,
        ),
        body: BaseBlocBuilder<AuthBloc>(
          bloc: authBloc,
          builder: (BuildContext context, BaseState state) {
            return state.runtimeType == DefaultState
                ? _userLoginForm()
                : _unauthorizedForm();
          },
        ));
  }

  Widget _userLoginForm() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(hintText: 'Email'),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(hintText: 'Password'),
        ),
        TextField(
          controller: repeatPasswordController,
          decoration: InputDecoration(hintText: 'Repeat password'),
        ),
        TextButton(
            onPressed: () {
              authBloc.add(
                LoginUserEvent(
                  email: emailController.text,
                  password: passwordController.text,
                  repeatPassword: repeatPasswordController.text,
                ),
              );
            },
            child: Text('Login'))
      ],
    );
  }

  Widget _unauthorizedForm() {
    return Center(
      child: Text('_unauthorizedForm'),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    authBloc.dispose();
  }
}
