import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import '../models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:meal_app/providers/meal_provider.dart';

import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';




  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
String categoryID ;
  List<Meal> displayedMeals;
  @override
  void didChangeDependencies () {
    final List<Meal> availableMeals = Provider.of<MealProvider>(context,listen: true).availableMeal ;
    final routeArg = ModalRoute.of(context).settings.arguments as Map<String, String>;
     categoryID = routeArg['id'];

    displayedMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryID);
    }).toList();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape ;
    var lan = Provider.of<LanguageProvider>(context,listen: true) ;
    var dw = MediaQuery.of(context).size.width ;
    var dh = MediaQuery.of(context).size.height ;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts('cat-$categoryID')),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw<=400 ? 400 : 500,
            childAspectRatio:isLandScape ? dw/(dw*0.85) : dw/(dh*0.45),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              imageUrl: displayedMeals[index].imageUrl,

              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,

            );
          },
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}
