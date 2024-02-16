import 'package:flutter/material.dart';

// Define a class to represent an article
class Article {
  final String title;
  final String description;
  final String governmentSiteUrl;

  Article({required this.title, required this.description, required this.governmentSiteUrl});
}

// Define a list of sample articles
List<Article> articles = [
  Article(
    title: "Government launches new health scheme",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    governmentSiteUrl: "https://www.acko.com/government-health-insurance-schemes-in-india/",
  ),
  Article(
    title: "Tips for staying healthy during the pandemic",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    governmentSiteUrl: "https://www.acko.com/government-health-insurance-schemes-in-india/",
  ),
  // Add more articles as needed
];


class HealthArticleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Articles'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(articles[index].title),
            subtitle: Text(articles[index].description),
            onTap: () {
              // Navigate to the government website when the article is tapped
              launchUrl(articles[index].governmentSiteUrl);
            },
          );
        },
      ),
    );
  }

  // Function to launch a URL
  void launchUrl(String url) {
    // Replace this with your preferred method of opening a URL
    // For example, you can use url_launcher package
    // Make sure to add url_launcher dependency in your pubspec.yaml file
    // Example: launch(url);
}
}
