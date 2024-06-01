/*import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';

class SubCategoryScreen extends StatefulWidget {
  final String category;

  SubCategoryScreen({required this.category});

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  late Future<List<String>> _futureMeals;

  @override
  void initState() {
    super.initState();
    _futureMeals = fetchMealsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: FutureBuilder(
        future: _futureMeals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<String> meals = snapshot.data as List<String>;
            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(meals[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailScreen(mealName: meals[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}*/
/*class MealDetailScreen extends StatelessWidget {
  final String mealName;

  MealDetailScreen({required this.mealName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealName),
      ),
      body: Center(
        child: Text('Details for $mealName'),
      ),
    );
  }
}
*/