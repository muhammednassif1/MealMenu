import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/catagory.dart';
import 'package:flutter_application_2/screens/main_list_screen.dart';
import 'package:http/http.dart' as http;

Future<List<Category>> fetchCategories() async {
  final Uri url =
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> categoriesData = data['categories'];
    List<Category> categories = categoriesData.map<Category>((category) {
      return Category.fromJson(category);
    }).toList();
    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
}


class MainCategoryScreen extends StatelessWidget {
  const MainCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Categories'),
      ),
      body: FutureBuilder(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Category> categories = snapshot.data as List<Category>;
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealsListScreen(
                            categoryName: categories[index].name),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    color: const Color(0xFF2D2013),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            categories[index].imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            categories[index].name,
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
