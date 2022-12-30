import 'package:flutter/material.dart';
import '../screens/meals_detail_screen.dart';
import '../data/meals.dart';

class MealsItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Afforadablity afforadablity;

  MealsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.afforadablity,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get afforadablityText {
    switch (afforadablity) {
      case Afforadablity.Affordability:
        return 'Affordable';
      case Afforadablity.Costly:
        return 'Costly';
      case Afforadablity.Luxury:
        return 'Expensive';
      default:
        return 'Unknown';
    }
  }

//value = mealsId which will be recevied from meals_details_screen
  void selectMeals(BuildContext context) {
    Navigator.of(context).pushNamed(MealsDetailScreen.routeName, arguments: id)
        //this line will bw executed when pushName pushes to MealDetailsScreen and when the page is popped
        .then((value) {
      if (value != null) {
        // removeItem(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeals(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                //ClipRRect acts helper widget for the above Card widget
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  //double.infinity takes alomost all available width in device
                  child: Image.network(imageUrl,
                      height: 250, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 15,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.only(right: 10, left: 15),
                    width: 300,
                    color: Colors.black54,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow
                          .fade, //makes sure that text won't oveerflow out of container
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(children: <Widget>[
                    //Icons to show time
                    const Icon(Icons.money_sharp),
                    const SizedBox(
                      width: 7,
                    ),
                    //Text to display time required to cook
                    Text('$duration min'),
                  ]),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(
                        width: 7,
                      ),
                      //Text to display time required to cook
                      Text('$complexityText'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money_rounded),
                      const SizedBox(
                        width: 7,
                      ),
                      //Text to display time required to cook
                      Text('$afforadablityText'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
