import 'package:flutter/material.dart';
import 'package:petfindr/UI/Views/ReportDetailed.dart';

class ReportCard extends StatelessWidget {
  final Map<String, dynamic> reportData;

  const ReportCard({Key? key, required this.reportData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        children: [
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch children horizontally
            children: [
              Container(
                height: 75,
                color: Theme.of(context).colorScheme.tertiary,
                child: Center(
                  // Center content horizontally within the Container
                  child: Text(
                    '${reportData['type']}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: reportData['type'] == 'Lost'
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 8,
              ),
              SizedBox(
                child: Text(
                  reportData['petType'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                reportData['race'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportDetailed(
                                reportData: reportData,
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .secondary, // Set background color to yellow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Adjust corner roundness
                    ),
                  ),
                  child: Container(
                    child: Text(
                      "Detalles",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
