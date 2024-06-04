import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/catagory.dart'; // Importing category screen
import 'package:flutter_application_2/screens/main_list_screen.dart'; // Importing main list screen
import 'package:http/http.dart' as http; // Importing HTTP client package

// Asynchronous function to fetch categories from an API
Future<List<Category>> fetchCategories() async {
  // Defining the URL for fetching categories
  final Uri url =
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php');
  // Sending a GET request to the specified URL
  final response = await http.get(url);
  // Checking if the response status code indicates success
  if (response.statusCode == 200) {
    // Decoding the response body from JSON to a Map
    Map<String, dynamic> data = jsonDecode(response.body);
    // Extracting the list of categories from the map
    List<dynamic> categoriesData = data['categories'];
    // Converting the list of category data into a list of Category objects
    List<Category> categories = categoriesData.map<Category>((category) {
      return Category.fromJson(category);
    }).toList();
    // Returning the list of categories
    return categories;
  } else {
    // Throwing an exception if failed to load categories
    throw Exception('Failed to load categories');
  }
}

// Stateless widget representing the main category screen
class MainCategoryScreen extends StatelessWidget {
  const MainCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Categories'),
      ),
      body: FutureBuilder(
        // Fetching categories asynchronously and building UI based on the result
        future: fetchCategories(),
        builder: (context, snapshot) {
          // Checking the connection state of the future
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Displaying a progress indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Displaying an error message if an error occurred
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Extracting the list of categories from the snapshot data
            List<Category> categories = snapshot.data as List<Category>;
            // Building a grid view to display the categories
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                // Creating a gesture detector for each category card
                return GestureDetector(
                  onTap: () {
                    // Navigating to the meals list screen when a category is tapped
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
                        // Displaying the category image
                        Expanded(
                          child: Image.network(
                            categories[index].imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        // Displaying the category name
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
