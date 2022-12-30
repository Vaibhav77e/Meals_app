import 'package:flutter/material.dart';
import 'package:meals_app/widgets/newdrawer.dart';

class Filters extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;

  final Map<String, bool> currentFilters;

  Filters(this.currentFilters, this.saveFilters);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    //?? means values be directly coming from main.dart file .It check whether the value is null or not if null it return false .
    _glutenFree = widget.currentFilters['gluten'] ?? false;
    _vegetarian = widget.currentFilters['vegetarian'] ?? false;
    _vegan = widget.currentFilters['vegan'] ?? false;
    _lactoseFree = widget.currentFilters['lactoseFree'] ?? false;

    super.initState();
  }

// used for building filtering swiitches
  Widget _buildSwitchListTile(String title, String descrption,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(descrption),
      onChanged: ((value) => updateValue),
    ); //((value) => updateValue)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your Filters!!'),
        //reference of function is stored in widget not in state ,so 'widget ' is used to get data
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  },
                };
                //  savefilters passed to filterData
                widget.saveFilters(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: Newdrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15),
            child: Text("Adjust your meal selection",
                style: Theme.of(context).textTheme.titleLarge),
          ),
          //Expanded widget will help to child widget (i.e inthis case Listview to get as much space it wants)
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    'Gluten-Free', 'Only include gluten free', _glutenFree,
                    (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                // Switches for filterig user choice
                _buildSwitchListTile(
                    'Lactose-Free', 'Only include lactose free', _lactoseFree,
                    (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile('Vegan', 'Only include Vegan', _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian ', 'Only include Vegetarian', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                FloatingActionButton(
                  onPressed: () {
                    debugPrint(_glutenFree.toString());
                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
