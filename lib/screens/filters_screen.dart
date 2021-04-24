import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import '../widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:meal_app/providers/meal_provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final bool fromOnBoarding;

   FiltersScreen({this.fromOnBoarding = false});
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {


  Widget buildSwitchListTile(
      String title, String subTitle, bool currentValue, Function updateValue) {
     return SwitchListTile(
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
        ),
        subtitle: Text(subTitle),
        value: currentValue,
        onChanged: updateValue,
     inactiveTrackColor: Provider.of<ThemeProvider>(context,listen: true).tm == ThemeMode.light ? null : Colors.black ,);
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context,listen: true) ;
    final Map<String,bool> currentFilters = Provider.of<MealProvider>(context,listen: true).filters ;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: widget.fromOnBoarding ? AppBar( backgroundColor: Theme.of(context).canvasColor,elevation: 0): AppBar(
      title: Text(lan.getTexts('filters_appBar_title')),
     ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              // ignore: deprecated_member_use
              child: Text(
                lan.getTexts('filters_screen_title'),
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile(lan.getTexts('Gluten-free'),
                      lan.getTexts('Gluten-free-sub'), currentFilters['gluten'], (newValue) {
                    setState(() {
                      currentFilters['gluten'] = newValue;
                      },);
                    Provider.of<MealProvider>(context,listen: false).setFilters();
                  },),
                  buildSwitchListTile(lan.getTexts('Lactose-free'),
                    lan.getTexts('Lactose-free_sub'), currentFilters['lactose'], (newValue) {
                      setState(
                            () {
                              currentFilters['lactose'] = newValue;
                        },
                      );
                      Provider.of<MealProvider>(context,listen: false).setFilters();
                    },),
                  buildSwitchListTile(lan.getTexts('Vegetarian'),
                    lan.getTexts('Vegetarian-sub'), currentFilters['vegetarian'], (newValue) {
                      setState(
                            () {
                              currentFilters['vegetarian'] = newValue;
                        },
                      );
                      Provider.of<MealProvider>(context,listen: false).setFilters();
                    },),
                  buildSwitchListTile(lan.getTexts('Vegan'),
                    lan.getTexts('Vegan-sub'), currentFilters['vegan'], (newValue) {
                      setState(
                            () {
                              currentFilters['vegan'] = newValue;
                        },
                      );
                      Provider.of<MealProvider>(context,listen: false).setFilters();
                    },),
                ],
              ),
            ),
            SizedBox(height: widget.fromOnBoarding ? 80 : 0,),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
