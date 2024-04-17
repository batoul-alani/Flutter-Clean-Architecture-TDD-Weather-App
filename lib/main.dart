import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/injection_container.dart';
import 'package:weather_app/presentition/bloc/location_bloc.dart';
import 'package:weather_app/presentition/pages/location_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<LocationBloc>())],
      child: const MaterialApp(home: LocationPage()),
    );
  }
}
