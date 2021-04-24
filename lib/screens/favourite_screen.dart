import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var dw = MediaQuery.of(context).size.width;
    final List<Meal> favouriteMeals =
        Provider.of<MealProvider>(context, listen: true).favouriteMeal;
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    if (favouriteMeals.isEmpty) {
      return Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: Center(child: Text(lan.getTexts('favorites_text'))));
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw <= 400 ? 400 : 500,
          childAspectRatio: isLandScape ? dw / (dw * 0.9) : dw / (dw * 0.75),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            imageUrl: favouriteMeals[index].imageUrl,

            duration: favouriteMeals[index].duration,
            complexity: favouriteMeals[index].complexity,
            affordability: favouriteMeals[index].affordability,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
