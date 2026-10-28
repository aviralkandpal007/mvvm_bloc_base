import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'middleware/network_connector/network_connector.dart';
import 'middleware/network_connector/network_worker.dart';
import 'modules/demo_listing_module/demo_listing_bloc.dart';
import 'modules/demo_listing_module/demo_listing_events.dart';
import 'modules/demo_listing_module/demo_listing_repository.dart';
import 'modules/demo_listing_module/demo_listing_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<NetworkConnector>.value(
      value: NetworkWorker.instance,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: BlocProvider(
          create: (context) => DemoListingBloc(
            DemoListingRepository(context.read<NetworkConnector>()),
          )..add(const DemoListingLoadRequested()),
          child: const DemoListingScreen(),
        ),
      ),
    );
  }
}