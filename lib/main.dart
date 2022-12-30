import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/meals_recpie_screen.dart';
import './screens/tabs.dart';
import './screens/filters.dart';
import './data/test_data.dart';
import './data/meals.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = TEST_MEALS;
  List<Meal> _selectedMeals = [];

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = TEST_MEALS.where((meal) {
        // checks meals contains this refered contents if meals contains the referd contents then meal will excluded
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingMeals =
        _selectedMeals.indexWhere((meal) => meal.id == mealId);
    // to remove meal from list
    if (existingMeals >= 0) {
      setState(() {
        _selectedMeals.removeAt(existingMeals);
      });
    } else {
      _selectedMeals.add(TEST_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }

//helps to add meal favoriate
  bool _isMealFavorite(String id) {
    return _selectedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold)),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
        //     .copyWith(secondary: Colors.amber),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // '/' default route value
      routes: {
        '/': (context) => Favoriate(_selectedMeals),
        //this a another way using named route to navigate between pages
        '/category-meals': (context) => MealsRecpieScreen(_availableMeals),

        MealsDetailScreen.routeName: (context) =>
            MealsDetailScreen(_toggleFavorite, _isMealFavorite),
        Filters.routeName: (context) => Filters(_filters, _setFilter),
      },
      //to avoid app crashing this function is used acts like page fallback.
      onUnknownRoute: ((settings) {
        return MaterialPageRoute(builder: (context) {
          return CategoriesScreen();
        });
      }),
    );
  }
}
