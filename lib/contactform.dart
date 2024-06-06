import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactFormWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accusedNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController firNumberController = TextEditingController();
  final TextEditingController policeStationController = TextEditingController();
  final TextEditingController caseBriefController = TextEditingController();
  final TextEditingController bailStatusController = TextEditingController();
  final TextEditingController bailApplicationController = TextEditingController();
  final TextEditingController jailDurationController = TextEditingController();
  final TextEditingController counsellingCallController = TextEditingController();
  final TextEditingController familyMembersController = TextEditingController();
  final TextEditingController soleBreadwinnerController = TextEditingController();
  final TextEditingController criminalRecordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextField(
                controller: nameController,
                labelText: 'Name of the client',
              ),
              buildTextField(
                controller: accusedNameController,
                labelText: 'Name of the accused',
              ),
              buildTextField(
                controller: contactNumberController,
                labelText: 'Contact no.',
              ),
              buildTextField(
                controller: firNumberController,
                labelText: 'FIR no.',
              ),
              buildTextField(
                controller: policeStationController,
                labelText: 'Police Station',
              ),
              buildTextField(
                controller: caseBriefController,
                labelText: 'Case Brief',
              ),
              buildTextField(
                controller: bailStatusController,
                labelText: 'Bail Status',
              ),
              buildTextField(
                controller: bailApplicationController,
                labelText: 'Bail Application no.',
              ),
              buildTextField(
                controller: jailDurationController,
                labelText: 'Jail Duration?',
              ),
              buildTextField(
                controller: counsellingCallController,
                labelText: 'who want take counselling call?',
              ),
              buildTextField(
                controller: familyMembersController,
                labelText: 'How many Members in Family?',
              ),
              buildTextField(
                controller: soleBreadwinnerController,
                labelText: 'Sole BreadWinner',
              ),
              buildTextField(
                controller: criminalRecordController,
                labelText: 'Criminal Record',
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to save the form data
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Set button color to red
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.red), // Set label text color to red
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red), // Set bottom line color to red
          ),
        ),
      ),
    );
  }
}
