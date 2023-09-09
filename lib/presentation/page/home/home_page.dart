import 'package:connect_app/presentation/page/base/base_bloc.dart';
import 'package:connect_app/presentation/page/base/base_bloc_builder.dart';
import 'package:connect_app/presentation/page/home/home_bloc.dart';
import 'package:connect_app/presentation/page/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomeBloc? homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = GetIt.instance<HomeBloc>();
    homeBloc?.add(ShowHomeDataEvent());
  }

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
              icon: Icon(Icons.person)),
          IconButton(
              onPressed: () {
                homeBloc?.add(ShowHomeDataEvent());
              },
              icon: Icon(Icons.refresh))
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
              BaseBlocBuilder<HomeBloc>(
                  bloc: homeBloc,
                  builder: (BuildContext context, BaseState state) {
                    return state.runtimeType == ShowBusinessesListState
                        ? Expanded(
                            child: _businessesList(
                                state as ShowBusinessesListState))
                        : Center(
                            child: Text('Unknown state: ${state.runtimeType}'),
                          );
                  }),
            ],
          )),
    );
  }

  Widget _businessesList(ShowBusinessesListState state) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          child: Column(
            children: [
              Text(state.businesses[index].title),
              Text(state.businesses[index].description),
            ],
          ),
        );
      },
      itemCount: state.businesses.length,
    );
  }
}
