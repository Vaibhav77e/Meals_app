import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  Items(this.id, this.title, this.color);

  void selectpage(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed('/category-meals', arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    //context has information realted to current pages
    //InkWell -> basically gesutredetector with repel effect like splash color
    return InkWell(
      onTap: () => selectpage(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                //color will go low to high
                colors: [color.withOpacity(0.7), color], // list of color
                //direction for gradient start with

                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
