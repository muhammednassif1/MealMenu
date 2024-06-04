import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchMealsByCategory(String categoryName) async {
  final Uri url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> mealsData = data['meals'];
    return mealsData;
  } else {
    throw Exception('Failed to load meals for category: $categoryName');
  }
}

class MealsListScreen extends StatelessWidget {
  final String categoryName;

  const MealsListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: FutureBuilder(
        future: fetchMealsByCategory(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> meals = snapshot.data as List<dynamic>;
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle tapping on meal item
                  },
                  child: Card(
                    elevation: 2.0,
                    color: Color(0xFF2D2013),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            meals[index]['strMealThumb'],
                            fit: BoxFit.cover,
                            height: 100, // Set a fixed height for the image
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            meals[index]['strMeal'],
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
