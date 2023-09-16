import 'package:connect_app/domain/field_validation/field_type.dart';
import 'package:connect_app/presentation/page/auth/auth_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class SignUpBusinessPage extends StatefulWidget {
  const SignUpBusinessPage({Key? key}) : super(key: key);

  @override
  State<SignUpBusinessPage> createState() => _SignUpBusinessPageState();
}

class _SignUpBusinessPageState extends State<SignUpBusinessPage> {
  late AuthBloc authBloc;
  final _emailController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
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
                      controller: _titleController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.short_text_outlined),
                        labelText: 'Title',
                        hintText: 'Enter title',
                        errorText: _handleValidationErrorState(
                          FieldType.businessTitle,
                          state,
                        ),
                        border: const OutlineInputBorder(),
                        filled: true,
                      )),
                  SizedBox(height: 16,),
                  TextField(
                      controller: _descriptionController,
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.short_text_outlined),
                        labelText: 'Description',
                        hintText: 'Enter description',
                        errorText: _handleValidationErrorState(
                          FieldType.businessDescription,
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
                        SignUpBusinessEvent(
                          email: _emailController.text,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          password: _passwordController.text,
                          repeatPassword: _repeatPasswordController.text,
                        ),
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
