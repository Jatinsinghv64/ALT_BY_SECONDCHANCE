import 'package:alt/lawyerprofile.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CriminalLawyerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Criminal lawyer',
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
      body: _buildLawyerList(),
    );
  }

  Widget _buildLawyerList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('lawyers') // Replace with your Firestore collection name
          .where('department', isEqualTo: 'Criminal Lawyer')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data?.docs.isEmpty ?? true) {
          return Center(
            child: Text('No Criminal Lawyers found.'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var lawyerData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            var lawyerImageURL = lawyerData['lawyering'] ?? '';

            return GestureDetector(
              onTap: () {
                // Navigate to lawyer profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawyerProfilePage(lawyerData: lawyerData),
                  ),
                );
              },
              child: Card(
                elevation: 5.0,
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(lawyerData['name'] ?? 'Unknown Name'),
                  subtitle: Text(lawyerData['email'] ?? 'Unknown Email'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(lawyerImageURL),
                    // You can customize the CircleAvatar further based on your needs
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CorporateLawyerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corporate Lawyer'),
      ),
      body: Center(
        child: Text('This is the Corporate Lawyer page.'),
      ),
    );
  }
}


class CivilLitigationLawyerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CivilLitigation Lawyer'),
      ),
      body: Center(
        child: Text('This is the Corporate Lawyer page.'),
      ),
    );
  }
}
class LaborLawyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CLaborLawyer'),
      ),
      body: Center(
        child: Text('This is the  Lawyer page.'),
      ),
    );
  }
}
class HumanRightsLawyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Human Rights Lawyer'),
      ),
      body: Center(
        child: Text('This is the HumanRightsLawyer'),
      ),
    );
  }
}

// Repeat this pattern for other lawyer types...
