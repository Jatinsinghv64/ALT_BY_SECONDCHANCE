import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookletPage extends StatelessWidget {
  final List<Map<String, dynamic>> pdfData = [
    {
      'imageUrl': 'https://img.freepik.com/premium-vector/flying-colorful-b-c-d-letters-open-book_95164-2444.jpg',
      'pdfUrl': 'https://drive.google.com/file/d/12Ede7XDe09j63fUH7JPIcHjFQqftEYjL/view',
      'displayText': 'ABC Alphabet',
    },
    {
      'imageUrl': 'https://i.postimg.cc/VkYgmnt2/Full-LUDO-2-10x12-ft-3.jpg',
      'pdfUrl': 'https://drive.google.com/file/d/1nWIFEE6JzMaoUUOODan22ifTARme6v35/view',
      'displayText': 'LUDO-Kanoon',
    },
    {
      'imageUrl': 'https://i.postimg.cc/GpBdgBXs/Nyaay-Cards-Rules-8-5x11-inches.jpg',
      'pdfUrl': 'https://drive.google.com/file/d/1WEcUjHtO6UOYvTODhizhsCYKDtAg82if/view',
      'displayText': 'Nyaay Cards Rules',
    },
    {
      'imageUrl': 'https://i.postimg.cc/50RP70kj/PSC-LOGO.png',
      'pdfUrl': 'https://drive.google.com/file/d/1xqll_Teiyu2GMT6BdAY-1Ngwa5NAp0Oh/view',
      'displayText': 'Literacy Module',
    },
  ];

  _launchURL(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Legal Literacy Module',
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
      body: ListView.builder(
        itemCount: pdfData.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> item = pdfData[index];
          return GestureDetector(
            onTap: () => _launchURL(item['pdfUrl']),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                border: Border.all(color: Colors.orange, width: 2), // Add orange border
              ),
              child: Card(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      item['imageUrl'],
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      item['displayText'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
