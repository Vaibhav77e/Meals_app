import 'package:flutter/material.dart';
import '../data/meals.dart';
import './categories_screen.dart';
import './fav.dart';
import '.././widgets/newdrawer.dart';

class Favoriate extends StatefulWidget {
  List<Meal> favoriates;
  Favoriate(this.favoriates);
  @override
  State<Favoriate> createState() => _FavoriateState();
}

class _FavoriateState extends State<Favoriate> {
  //wiget can't be used  in here because during every property is initializing
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': Fav(widget.favoriates), 'title': 'Favirotes'}
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //to add tabs
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      drawer: Newdrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        //colorScheme.secondary->accentColor
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favirotes'),
        ],
      ),
    );
  }
}
