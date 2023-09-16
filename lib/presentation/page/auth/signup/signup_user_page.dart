import 'package:connect_app/domain/field_validation/field_type.dart';
import 'package:connect_app/presentation/page/auth/auth_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class SignUpUserPage extends StatefulWidget {
  const SignUpUserPage({Key? key}) : super(key: key);

  @override
  State<SignUpUserPage> createState() => _SignUpUserPageState();
}

class _SignUpUserPageState extends State<SignUpUserPage> {
  late AuthBloc authBloc;
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void initState() {
    authBloc = GetIt.instance<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder(
        bloc: authBloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    errorText: _handleValidationErrorState(
                      FieldType.email,
                      state,
                    ),
                    border: const OutlineInputBorder(),
                    filled: true,
                  )),
              SizedBox(height: 16,),
              TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Full name',
                    hintText: 'Enter your full name',
                    errorText: _handleValidationErrorState(
                      FieldType.fullName,
                      state,
                    ),
                    border: const OutlineInputBorder(),
                    filled: true,
                  )),
              SizedBox(height: 16,),
              TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    errorText: _handleValidationErrorState(
                      FieldType.password,
                      state,
                    ),
                    border: const OutlineInputBorder(),
                    filled: true,
                  )),
              SizedBox(height: 16,),
              TextField(
                  controller: _repeatPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    labelText: 'Repeat password',
                    hintText: 'Enter your password',
                    errorText: _handleValidationErrorState(
                      FieldType.repeatPassword,
                      state,
                    ),
                    border: const OutlineInputBorder(),
                    filled: true,
                  )),
              SizedBox(height: 16,),
              FilledButton(
                onPressed: () {
                  authBloc.add(
                    SignUpUserEvent(
                        email: _emailController.text,
                        fullName: _fullNameController.text,
                        password: _passwordController.text,
                        repeatPassword: _repeatPasswordController.text),
                  );
                },
                child: const Text('Sign Up'),
              ),
            ],
          );
        });
  }

  String? _handleValidationErrorState(
    FieldType fieldType,
    BaseState baseState,
  ) {
    if (baseState is ValidationErrorState &&
        baseState.errorsMap.containsKey(fieldType)) {
      return baseState.errorsMap[fieldType];
    }
    return null;
  }
}
