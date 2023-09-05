import 'package:connect_app/presentation/page/router/router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.mePage);
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Search', icon: Icon(Icons.search)),
              ),
              Spacer(),
              Center(
                child: Text('Home Page'),
              ),
              Spacer(),
            ],
          )),
    );
  }
}
