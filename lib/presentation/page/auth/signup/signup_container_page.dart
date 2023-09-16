import 'package:connect_app/presentation/page/auth/auth_bloc.dart';
import 'package:connect_app/presentation/page/auth/signup/signup_business_page.dart';
import 'package:connect_app/presentation/page/auth/signup/signup_user_page.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignUpContainerPage extends StatefulWidget {
  const SignUpContainerPage({Key? key}) : super(key: key);

  @override
  State<SignUpContainerPage> createState() => _SignUpContainerPageState();
}

class _SignUpContainerPageState extends State<SignUpContainerPage> {
  late AuthBloc authBloc;
  bool _signUpAsBusiness = false;

  @override
  void initState() {
    super.initState();
    authBloc = GetIt.instance<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign up'),
          centerTitle: true,
        ),
        body: BaseBlocBuilder<AuthBloc>(
          bloc: authBloc,
          builder: (BuildContext context, BaseState state) {
            return _userLoginForm();
          },
        ));
  }

  Widget _userLoginForm() {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Spacer(),
                    Text(
                        'Sign up as ${_signUpAsBusiness ? 'user' : 'business'}'),
                    Switch(
                      value: _signUpAsBusiness,
                      onChanged: (value) {
                        _signUpAsBusiness = value;
                        setState(() {});
                      },
                    ),
                    Spacer(),
                  ],
                ),
                _signUpAsBusiness
                    ? const SignUpUserPage()
                    : const SignUpBusinessPage()
              ],
            )));
  }

  @override
  void dispose() {
    super.dispose();
    authBloc.dispose();
  }
}
