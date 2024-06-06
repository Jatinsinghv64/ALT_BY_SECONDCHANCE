import 'package:alt/lawyerpage.dart';
import 'package:alt/lawyerprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FindLawyerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find Lawyer',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
        actionsIconTheme: IconThemeData(color: Colors.orange),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to the search page or show a search dialog
              showSearch(context: context, delegate: LawyerSearchDelegate());
            },
          ),
        ],
        shape: Border(
          bottom: BorderSide(
            color: Colors.orange,
            width: 2.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLawyerButton(context, 'Criminal Lawyer'),
            _buildLawyerButton(context, 'Corporate Lawyer'),
            _buildLawyerButton(context, 'Civil Litigation Lawyer'),
            _buildLawyerButton(context, 'Labor Lawyer'),
            _buildLawyerButton(context, 'Human Rights Lawyer'),
            // Add more buttons for other lawyer types...
          ],
        ),
      ),
    );
  }

  Widget _buildLawyerButton(BuildContext context, String lawyerType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            color: Colors.orange,
            size: 10.0,
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Set button color to white
              onPrimary: Colors.orange, // Set font color to orange
            ),
            onPressed: () {
              // Navigate to the respective lawyer type page
              _navigateToLawyerPage(context, lawyerType);
            },
            child: Text(
              lawyerType,
              style: TextStyle(color: Colors.orange), // Set font color to orange
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLawyerPage(BuildContext context, String lawyerType) {
    Widget lawyerPage;

    // Determine which lawyer page to navigate to based on the lawyerType
    switch (lawyerType) {
      case 'Criminal Lawyer':
        lawyerPage = CriminalLawyerPage();
        break;
      case 'Corporate Lawyer':
        lawyerPage = CorporateLawyerPage();
        break;
      case 'Civil Litigation Lawyer':
        lawyerPage = CivilLitigationLawyerPage();
        break;
      case 'Labor Lawyer':
        lawyerPage = LaborLawyer();
        break;
      case 'Human Rights Lawyer':
        lawyerPage = HumanRightsLawyer();
        break;
    // Add cases for other lawyer types...

      default:
      // Handle the case where no match is found
        return;
    }

    // Navigate to the determined lawyer page
    Navigator.push(context, MaterialPageRoute(builder: (context) => lawyerPage));
  }
}



class LawyerSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(); // Return an empty container when no query is entered
    }
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final lowerCaseQuery = query.toLowerCase();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('lawyers')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No matching results found.');
        }

        final lawyers = snapshot.data!.docs
            .where((doc) {
          var lawyerData = doc.data() as Map<String, dynamic>;
          var name = (lawyerData['name'] ?? '').toLowerCase();
          var email = (lawyerData['email'] ?? '').toLowerCase();

          return name.contains(lowerCaseQuery) || email.contains(lowerCaseQuery);
        })
            .toList();

        return ListView.builder(
          itemCount: lawyers.length,
          itemBuilder: (context, index) {
            var lawyerData = lawyers[index].data() as Map<String, dynamic>;
            var lawyerImageURL = lawyerData['lawyering'] ?? '';

            return ListTile(
              title: Text(lawyerData['name'] ?? 'Unknown Name'),
              subtitle: Text(lawyerData['email'] ?? 'Unknown Email'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(lawyerImageURL),
                // You can customize the CircleAvatar further based on your needs
              ),
              onTap: () {
                // Handle tapping on the lawyer profile
                // Navigate to the detailed lawyer profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawyerProfilePage(lawyerData: lawyerData),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
