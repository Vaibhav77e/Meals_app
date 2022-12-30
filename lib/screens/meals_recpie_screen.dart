import 'package:flutter/material.dart';
// import 'package:meals_app/data/test_data.dart';
import '../data/meals.dart';
import '../widgets/meals_item.dart';

class MealsRecpieScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  MealsRecpieScreen(this.availableMeals);
  @override
  State<MealsRecpieScreen> createState() => _MealsRecpieScreenState();
}

class _MealsRecpieScreenState extends State<MealsRecpieScreen> {
  String categoryTitle = '';
  List<Meal> displayedMeals = [];
  var intiData = false;

  @override
  // initState() runs before build and loads the data
  void initState() {
    // context will be not available
    super.initState();
  }

// runs when reference to state changes and it also runs before build method
  @override
  void didChangeDependencies() {
    // !initData => initiData == false (same)
    if (!intiData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'].toString();
      final categoryID = routeArgs['id'];
      // where returns iterables so .toList is used to convert it List
      // availableMeals will be filterd data from main.dart file
      displayedMeals = widget.availableMeals.where((meals) {
        return meals.categories.contains(categoryID);
      }).toList();
      intiData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealsItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              afforadablity: displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
