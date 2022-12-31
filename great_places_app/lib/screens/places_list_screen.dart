import 'package:flutter/material.dart';
import 'package:great_places_app/providers/greate_places.dart';
import 'package:great_places_app/utils/app_route.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM),
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: ((context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('Nenhum local cadastrado'),
                ),
                builder: (ctx, greatePlaces, ch) => greatePlaces.itemsCount == 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatePlaces.itemsCount,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatePlaces.getItem(i).image),
                          ),
                          title: Text(greatePlaces.getItem(i).title),
                          subtitle:
                              Text(greatePlaces.getItem(i).location!.address!),
                          onTap: () => {
                            Navigator.of(context).pushNamed(
                              AppRoutes.PLACE_DETAIL,
                              arguments: greatePlaces.getItem(i),
                            )
                          },
                        ),
                      ),
              )),
      ),
    );
  }
}
