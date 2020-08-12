import 'package:MySeedBank/providers/seed_data_provider.dart';
import 'package:MySeedBank/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/seed_list_screen.dart';
import './screens/add_seeds_screen.dart';
import './screens/seed_detail_screen.dart';
import './screens/settings_screen.dart';

import './providers/seeds_provider.dart';

import './styles/colors.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider<SeedsProvider>(create: (context) => SeedsProvider()),
        Provider<UserProvider>(create: (context) => UserProvider()),
        Provider<PlantDataProvider>(create: (context) => PlantDataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Seed Bank',
      theme: ThemeData(
        primaryColor: pallette.primary,
        accentColor: pallette.accent,
        secondaryHeaderColor: pallette.secondary,
        buttonColor: pallette.primary,
        backgroundColor: pallette.primary,
        primarySwatch: swatch,
        bannerTheme: MaterialBannerThemeData(
          backgroundColor: pallette.primary,
        ),
        canvasColor: Colors.white,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          color: pallette.primary,
          elevation: 4,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: SeedListScreen.routeName,
      routes: {
        SeedListScreen.routeName: (ctx) => SeedListScreen(),
        AddSeedsScreen.routeName: (ctx) => AddSeedsScreen(),
        SeedDetailScreen.routeName: (ctx) => SeedDetailScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
      },
    );
  }
}
