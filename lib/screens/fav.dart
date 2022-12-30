import 'package:flutter/material.dart';
import '../data/meals.dart';
import '../widgets/meals_item.dart';

class Fav extends StatelessWidget {
  List<Meal> favoriates;
  Fav(this.favoriates);
  @override
  Widget build(BuildContext context) {
    if (favoriates.isEmpty) {
      return Center(
        child: Text('My Faviorate'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealsItem(
            id: favoriates[index].id,
            title: favoriates[index].title,
            imageUrl: favoriates[index].imageUrl,
            duration: favoriates[index].duration,
            complexity: favoriates[index].complexity,
            afforadablity: favoriates[index].affordability,
          );
        },
        itemCount: favoriates.length,
      );
    }
  }
}
