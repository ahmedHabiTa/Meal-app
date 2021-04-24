import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:meal_app/providers/meal_provider.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = 'meal_details';

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget builtSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // ignore: deprecated_member_use
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: isLandScape ? dh * 0.5 : dh * 0.25,
      width: isLandScape ? (dw * 0.5 - 30) : dw,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor = Theme.of(context).accentColor;
    List<String> stepsLi = lan.getTexts('steps-$mealId') as List<String>;
    var lisSteps = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              child: Text('#${index + 1}'),
            ),
            title: Text(
              stepsLi[index],
              style: TextStyle(color: Colors.black87),
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.pinkAccent,
            indent: 50,
            endIndent: 50,
          )
        ],
      ),
      itemCount: stepsLi.length,
    );
    List<String> liIngredientLi =
        lan.getTexts('ingredients-$mealId') as List<String>;
    var listIngredients = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            liIngredientLi[index],
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      itemCount: liIngredientLi.length,
    );
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  lan.getTexts('meal-$mealId'),
                  style: TextStyle(fontSize: 15),
                ),
                background:  Hero(
                    tag: mealId,
                    child: InteractiveViewer(
                        child: FadeInImage(
                          placeholder: AssetImage('assets/a2.png'),
                          image: NetworkImage(
                            selectedMeal.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        )),),
              ),

            ),
            SliverList(delegate: SliverChildListDelegate([
              if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        builtSectionTitle(context, lan.getTexts('Ingredients')),
                        buildContainer(listIngredients),
                      ],
                    ),
                    Column(
                      children: [
                        builtSectionTitle(context, lan.getTexts('Steps')),
                        buildContainer(lisSteps),
                      ],
                    )
                  ],
                ),
              if (!isLandScape)
                builtSectionTitle(context, lan.getTexts('Ingredients')),
              if (!isLandScape) buildContainer(listIngredients),
              if (!isLandScape)
                builtSectionTitle(context, lan.getTexts('Steps')),
              if (!isLandScape) buildContainer(lisSteps),
            ])),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavourites(mealId),
          child: Icon(Provider.of<MealProvider>(context, listen: true)
                  .isMealFavourite(mealId)
              ? Icons.star
              : Icons.star_border),
        ),
      ),
    );
  }
}
