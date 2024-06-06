import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
        actionsIconTheme: IconThemeData(color: Colors.orange),
        actions: [],
        shape: Border(
          bottom: BorderSide(
            color: Colors.orange,
            width: 2.0,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20), // Add margin around the body content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: TextStyle(
                color: Colors.red,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),textAlign: TextAlign.center,
            ),
            SizedBox(height: 10), // Add some space between heading and content
            Text(
              "Project Second Chance, India is an initiative based in New Delhi, working on reimagining prisons in all over India. We work with marginalised current/ex-incarcerated population and passionate young professionals to nurture them into becoming the changemakers with the objective of bringing systematic and structured impact to the prison landscape.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
