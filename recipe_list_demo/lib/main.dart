import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipes',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const RecipeListScreen(),
    );
  }
}

class Recipe {
  final String title;
  final String description;
  final List<String> ingredients;

  const Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    title: json['title'] as String,
    description: json['description'] as String,
    ingredients: (json['ingredients'] as List).cast<String>(),
  );
}

List<Recipe> parseRecipes(String jsonString) {
  final Map<String, dynamic> root = json.decode(jsonString);
  final List<dynamic> list = root['recipes'];
  return list.map((e) => Recipe.fromJson(e)).toList();
}

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  static const String jsonData = r'''
{
  "recipes": [
    {
      "title": "Pasta Carbonara",
      "description": "Creamy pasta dish with bacon and cheese.",
      "ingredients": ["spaghetti", "bacon", "egg", "cheese"]
    },
    {
      "title": "Caprese Salad",
      "description": "Simple and refreshing salad with tomatoes, mozzarella, and basil.",
      "ingredients": ["tomatoes", "mozzarella", "basil"]
    },
    {
      "title": "Banana Smoothie",
      "description": "Healthy and creamy smoothie with bananas and milk.",
      "ingredients": ["bananas", "milk"]
    },
    {
      "title": "Chicken Stir-Fry",
      "description": "Quick and flavorful stir-fried chicken with vegetables.",
      "ingredients": ["chicken breast", "broccoli", "carrot", "soy sauce"]
    },
    {
      "title": "Grilled Salmon",
      "description": "Delicious grilled salmon with lemon and herbs.",
      "ingredients": ["salmon fillet", "lemon", "olive oil", "dill"]
    },
    {
      "title": "Vegetable Curry",
      "description": "Spicy and aromatic vegetable curry.",
      "ingredients": ["mixed vegetables", "coconut milk", "curry powder"]
    },
    {
      "title": "Berry Parfait",
      "description": "Layered dessert with fresh berries and yogurt.",
      "ingredients": ["berries", "yogurt", "granola"]
    }
  ]
}
''';

  @override
  Widget build(BuildContext context) {
    final recipes = parseRecipes(jsonData);

    return Scaffold(
      appBar: AppBar(title: const Text('Food Recipes')),
      body: ListView.separated(
        itemCount: recipes.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, i) => ListTile(
          leading: const Icon(Icons.fastfood),
          title: Text(
            recipes[i].title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(recipes[i].description),
        ),
      ),
    );
  }
}
