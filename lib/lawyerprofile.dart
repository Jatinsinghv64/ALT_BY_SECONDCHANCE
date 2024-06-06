import 'package:alt/contactform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class LawyerProfilePage extends StatefulWidget {
  final Map<String, dynamic> lawyerData;

  LawyerProfilePage({required this.lawyerData});

  @override
  _LawyerProfilePageState createState() => _LawyerProfilePageState();
}

class _LawyerProfilePageState extends State<LawyerProfilePage> {
  late List<DateTime> availabilityDates;
  late Map<DateTime, List> _events;

  @override
  void initState() {
    super.initState();
    availabilityDates = List<Timestamp>.from(widget.lawyerData['availability'] ?? [])
        .map((timestamp) => timestamp.toDate())
        .toList();
    _events = {
      for (var date in availabilityDates) date: ['Available']
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lawyer Profile',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
        actionsIconTheme: IconThemeData(color: Colors.orange),
        shape: Border(
          bottom: BorderSide(
            color: Colors.orange,
            width: 2.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 500.0, // Adjust the width of the card as needed
            child: Card(
              elevation: 5.0,
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage(widget.lawyerData['lawyering'] ?? ''),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Name: ${widget.lawyerData['name'] ?? 'Unknown Name'}',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text('Email: ${widget.lawyerData['email'] ?? 'Unknown Email'}'),
                    SizedBox(height: 8.0),
                    Text('Department: ${widget.lawyerData['department'] ?? 'Unknown Department'}'),
                    SizedBox(height: 8.0),
                    Text('Experience: ${widget.lawyerData['experience'] ?? 'Unknown Experience'} years'),
                    SizedBox(height: 8.0),
                    Text('Availability:'),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 400, // Adjust the max height as needed
                      ),
                      child: SingleChildScrollView(
                        child: TableCalendar(
                          focusedDay: DateTime.now(),
                          firstDay: DateTime(2000),
                          lastDay: DateTime(2100),
                          eventLoader: (day) {
                            return _events[day] ?? [];
                          },
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            markerDecoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ContactFormWidget(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Set button color to green
                        onPrimary: Colors.white, // Set font color to white
                      ),
                      child: Text('Contact Lawyer'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
