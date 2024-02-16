import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Scheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 85, 85),
        title: Text("Government Health Care Schemes"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
         // Add padding for spacing
        child: Container(
          
        decoration: BoxDecoration(
          // color: Colors.white
          gradient: LinearGradient(
            colors: [
            Color.fromARGB(255, 244, 167, 167), Color.fromARGB(255, 245, 246, 247)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSchemeContainer(
                context,
                "Awaz Health Insurance Scheme",
                "This is a health insurance cover for migrant workers and is initiated by the Government of Kerala.",
                "https://www.insurancedekho.com/health-insurance/government-schemes/awaz",
                "assets/images/A.png",
              ),
              SizedBox(height: 16.0), // Add space between containers
              _buildSchemeContainer(
                context,
                "Ayushman Bharat Yojana",
                "Ayushman Bharat Yojana is designed keeping in mind Universal Health Coverage (UHC).",
                "https://abdm.gov.in/",
                "assets/images/Ayushman.png",
              ),
              SizedBox(height: 16.0), // Add space between containers
              _buildSchemeContainer(
                context,
                "Pradhan Mantri Suraksha Bima Yojana",
                "This scheme came into existence to offer accident insurance to the people of India.",
                "https://www.acko.com/health-insurance/pradhan-mantri-suraksha-bima-yojana/",
                "assets/images/Pra.png",
              ),
              SizedBox(height: 16.0), // Add space between containers
              _buildSchemeContainer(
                context,
                "Rashtriya Swasthya Bima Yojana",
                "This scheme is directed towards people working in the unorganized sector.",
                "https://www.acko.com/health-insurance/rashtriya-swasthya-bima-yojana/",
                "assets/images/Rashtriya.png",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSchemeContainer(
    BuildContext context,
    String name,
    String description,
    String url,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey),
        color: Colors.red[300]),
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(imagePath),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
