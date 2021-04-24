import 'package:flutter/material.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:provider/provider.dart';
class MainDrawer extends StatelessWidget {
  Widget builtListTile(String title, IconData icon ,Function tapHandler,BuildContext ctx){
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(ctx).textTheme.bodyText1.color,
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context).tm ;
    var lan = Provider.of<LanguageProvider>(context,listen: true) ;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              color: Theme.of(context).accentColor,
              child: Text(
                lan.getTexts('drawer_name'),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            builtListTile(lan.getTexts('drawer_item1'),Icons.restaurant,(){Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);},context),
            Divider(
              height: 15,
              endIndent: 40,
              indent: 40,
              color: theme == ThemeMode.dark ? Colors.white70 : Colors.black87,
            ),

            builtListTile(lan.getTexts('drawer_item2'),Icons.settings,(){Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);},context),
            Divider(
              height: 15,
              endIndent: 40,
              indent: 40,
              color: theme == ThemeMode.dark ? Colors.white70 : Colors.black87,
            ),
            builtListTile(lan.getTexts('drawer_item3'),Icons.color_lens,(){Navigator.of(context).pushReplacementNamed(ThemesScreen.routeName);},context),
            Divider(
              height: 17,
              endIndent: 40,
              indent: 40,
              color: theme == ThemeMode.dark ? Colors.white70 : Colors.black87,
            ),
            Padding(
              padding: EdgeInsets.only(right: (lan.isEn? 0:20),left: (lan.isEn? 20:0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(lan.getTexts('drawer_switch_item2'),style:TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold),),
                  Switch(
                    value: Provider.of<LanguageProvider>(context,listen:  true).isEn,
                    onChanged: (newValue){
                      Provider.of<LanguageProvider>(context,listen: false).changeLan(newValue);

                    },
                    //inactiveTrackColor: Provider.of<ThemeProvider>(context,listen: true).tm ==,
                  ),
                  Text(lan.getTexts('drawer_switch_item1'),style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontSize: 20,
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
