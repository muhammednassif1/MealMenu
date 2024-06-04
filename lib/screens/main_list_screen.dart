
import 'dart:convert'; 
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; 

// Asynchronous function to fetch meals by category from an API
Future<List<dynamic>> fetchMealsByCategory(String categoryName) async {
  // Constructing the URL to fetch meals by category
  final Uri url = Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName');
  // Sending a GET request to the specified URL
  final response = await http.get(url);
  // Checking if the response status code indicates success
  if (response.statusCode == 200) {
    // Decoding the response body from JSON to a Map
    Map<String, dynamic> data = jsonDecode(response.body);
    // Extracting the list of meals from the map
    List<dynamic> mealsData = data['meals'];
    // Returning the list of meals
    return mealsData;
  } else {
    // Throwing an exception if failed to load meals for the category
    throw Exception('Failed to load meals for category: $categoryName');
  }
}

// Stateless widget representing the screen to display meals for a specific category
class MealsListScreen extends StatelessWidget {
  final String categoryName; // Name of the category for which meals are displayed

  const MealsListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName), // Displaying the category name in the app bar
      ),
      body: FutureBuilder(
        // Fetching meals asynchronously and building UI based on the result
        future: fetchMealsByCategory(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Displaying a progress indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Displaying an error message if an error occurred
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Extracting the list of meals from the snapshot data
            List<dynamic> meals = snapshot.data as List<dynamic>;
            // Building a grid view to display the meals
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
                    // Handling tapping on meal item (not implemented in this snippet)
                  },
                  child: Card(
                    elevation: 2.0,
                    color:  const Color(0xFF2D2013),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            meals[index]['strMealThumb'], // Displaying meal image
                            fit: BoxFit.cover,
                            height: 100, // Setting a fixed height for the image
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            meals[index]['strMeal'], // Displaying meal name
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
