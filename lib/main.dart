import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_probe/home_screen.dart';
import 'package:media_probe/repositories/network_repository.dart';
import 'package:media_probe/router/app_router.dart';

import 'cubit/popular_list_cubit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static final _networkRepository = NetworkRepository();

  final _popularListCubit = PopularListCubit(_networkRepository);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _popularListCubit),
      ],
      child: const MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Media Probe',
        home: HomeScreen(),
      ),
    );
  }
}
