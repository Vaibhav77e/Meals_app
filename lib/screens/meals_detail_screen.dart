import 'package:flutter/material.dart';

import '../data/test_data.dart';

class MealsDetailScreen extends StatelessWidget {
  final Function togglefav;
  final Function isFavorite;
  MealsDetailScreen(this.togglefav, this.isFavorite);
  static const routeName = '/meals-details';

  //builder method
  Widget buildSectionTile(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget newchild) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      height: 150,
      width: 350,
      // this will helps us to link with listview(last i left this so listview was not visible)
      child: newchild,
    );
  }

  @override
  Widget build(BuildContext context) {
    // recevies argumnet from incoming route
    final mealsId = ModalRoute.of(context)!.settings.arguments as String;
    //firstWhere - gives one value or one meals for conditon which returns true
    final selectedMeal =
        TEST_MEALS.firstWhere((yummeal) => yummeal.id == mealsId);
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}')),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          //Ingredients text
          buildSectionTile(context, 'Ingredients'),
          //   'Ingredients' contents
          buildContainer(
            ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                //context will be created dynamically for every listitem (ingredients objects)
                itemBuilder: ((context, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    //ingredients is list of string
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(selectedMeal.ingredients[index])),
                  );
                })),
          ),
          //Steps heading or text
          buildSectionTile(context, 'Steps'),
          // Steps contents
          buildContainer(ListView.builder(
              itemCount: selectedMeal.steps.length,
              itemBuilder: ((context, index) {
                itemCount:
                selectedMeal.steps.length;
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    const Divider(),
                  ],
                );
              })))
        ]),
      ),
      //to remove particular list
      floatingActionButton: FloatingActionButton(
        onPressed: () => togglefav(mealsId),
        // mealsId will have data of particular meal when this btn id pressed it will look same id when id matches then favorite will be added
        child: Icon(isFavorite(mealsId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
