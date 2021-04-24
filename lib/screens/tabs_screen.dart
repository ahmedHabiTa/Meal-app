import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';

import 'categories_screen.dart';
import 'favourite_screen.dart';

class TabsScreen extends StatefulWidget {
static const routeName = 'tabs_screen' ;

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

   List<Map<String,Object>> _pages ;
  int _selectPageIndex = 0;
  @override
  void initState() {
    Provider.of<MealProvider>(context,listen: false).setData();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context,listen: false).getLan();
    // TODO: implement initState
    super.initState();

  }
  void _selectPage(int value) {
    setState(() {
      _selectPageIndex = value ;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context,listen: true) ;
    _pages=[
      {
        'page': CategoryScreen(),
        'title' : lan.getTexts('categories')
      },
      {
        'page': FavoritesScreen(),
        'title' : lan.getTexts('your_favorites')
      },
    ];
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectPageIndex]['title']),
          centerTitle: true,
        ),
        body: _pages[_selectPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectPageIndex,
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              // ignore: deprecated_member_use
              title: Text(lan.getTexts('categories')),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              // ignore: deprecated_member_use
              title: Text(lan.getTexts('your_favorites')),
            ),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
