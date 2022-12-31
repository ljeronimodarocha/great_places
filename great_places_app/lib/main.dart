import 'package:flutter/material.dart';
import 'package:great_places_app/providers/greate_places.dart';
import 'package:great_places_app/screens/place_detail_screen.dart';
import 'package:great_places_app/screens/place_form_screen.dart';
import 'package:great_places_app/screens/places_list_screen.dart';
import 'package:great_places_app/utils/app_route.dart';
import 'package:provider/provider.dart';

//partei no ep 16 modulo 13
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.amber,
          ),
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => const PlaceFormScreen(),
          AppRoutes.PLACE_DETAIL: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
