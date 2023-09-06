import 'package:connect_app/presentation/connect_app.dart';
import 'package:connect_app/presentation/di.dart';
import 'package:flutter/material.dart';

void main() {
  Injector.inject();
  runApp(const ConnectApp());
}
