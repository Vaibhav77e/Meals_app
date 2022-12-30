import 'package:flutter/material.dart';
import '../data/test_data.dart';
import '../widgets/items.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        // Scaffold is not required hence this screen will be part of  Favoriate(tabs.dart)
        padding: EdgeInsets.all(15),

        // ignore: sort_child_properties_last
        children: TEST_CATEGORIES
            .map((catData) => Items(catData.id, catData.title, catData.color))
            .toList(),
        // ignore: prefer_const_constructors
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //defines grid how should look
            maxCrossAxisExtent:
                200, //tells that how many grids can fit a/cc to device pixel
            childAspectRatio: 3 / 2, //3 is height
            crossAxisSpacing: 20,
            mainAxisSpacing: 20));
    //gridDelegate helps in structuring and layouting
  }
}
