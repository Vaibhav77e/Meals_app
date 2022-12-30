import 'package:flutter/material.dart';
import '../screens/filters.dart';

class Newdrawer extends StatelessWidget {
  Widget listTileBuilder(String title, IconData icon, VoidCallback handler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 19),
      ),
      onTap: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          height: 320,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).primaryColor,
          child: Text(
            'Cooking Up!',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                //accentcolor -> colorScheme.secondary
                color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        listTileBuilder('Meals!!', Icons.restaurant, () {
          // Using pushReplacementNamed  instead pushedNamed helps load the current page by clearing or removing oldpage .This helps in better memory management
          Navigator.of(context).pushReplacementNamed('/');
        }),
        listTileBuilder('Filters', Icons.settings, () {
          Navigator.of(context).pushReplacementNamed(Filters.routeName);
        }),
      ]),
    );
  }
}
