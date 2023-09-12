import 'package:connect_app/presentation/connect_app.dart';
import 'package:connect_app/presentation/di.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Injector.inject();
  runApp(const ConnectApp());
}
