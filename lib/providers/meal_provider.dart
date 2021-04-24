import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier{
  Map<String ,  bool> filters ={
    'gluten' : false ,
    'lactose' : false ,
    'vegan' : false ,
    'vegetarian' : false ,
  };
  List<Meal> availableMeal = DUMMY_MEALS ;
  List<Meal> favouriteMeal = [];
  List<String> prefsMealId= [];

  List<Category> availableCategory = DUMMY_CATEGORIES ;





  void setFilters() async{
    availableMeal =DUMMY_MEALS.where((meal){
      if(filters['gluten'] && !meal.isGlutenFree){
        return false ;
      }
      if(filters['lactose'] && !meal.isLactoseFree){
        return false ;
      }
      if(filters['vegan'] && !meal.isVegan){
        return false ;
      }
      if(filters['vegetarian'] && !meal.isVegetarian){
        return false ;
      }
      return true ;
    }).toList();

    List<Category> ac = [] ;
    availableMeal.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if(cat.id == catId) {
           if(!ac.any((cat) => cat.id ==catId)) ac.add(cat);
          }
        });
      });
    });
     availableCategory  = ac ;


    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten',filters['gluten'] );
    prefs.setBool('lactose',filters['lactose'] );
    prefs.setBool('vegan',filters['vegan'] );
    prefs.setBool('vegetarian',filters['vegetarian'] );
  }
  void setData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten')?? false ;
    filters['lactose'] = prefs.getBool('lactose')?? false;
    filters['vegan'] = prefs.getBool('vegan')?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian')?? false;
    prefsMealId = prefs.getStringList('prefsMealId')?? [];
    for(var mealId in prefsMealId){
      final existingIndex = favouriteMeal.indexWhere((meal) => meal.id == mealId);
      if(existingIndex < 0){
        favouriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    List<Meal> fm = [] ;
    favouriteMeal.forEach((favMeals) {
      availableMeal.forEach((avMeal) {
        if(favMeals.id == avMeal.id){
          fm.add(favMeals) ;
        }
      });
    });
    favouriteMeal = fm ;
    notifyListeners();
  }

  void toggleFavourites(String mealId) async{


    final existingIndex = favouriteMeal.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      favouriteMeal.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    }else{
      favouriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('prefsMealId', prefsMealId);
  }
  bool isMealFavourite(String id){
    return favouriteMeal.any((meal) => meal.id == id);

  }
  notifyListeners();
}