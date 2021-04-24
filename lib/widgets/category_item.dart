import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:provider/provider.dart';


class CategoryItem extends StatelessWidget {
  final String id;

  final Color color;

  CategoryItem(this.id,  this.color);
  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName,
    arguments: {
      'id' : id,

    });
  }
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context,listen: true) ;
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        // ignore: deprecated_member_use
        child: Text(lan.getTexts('cat-$id'),style: Theme.of(context).textTheme.title),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.5),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
