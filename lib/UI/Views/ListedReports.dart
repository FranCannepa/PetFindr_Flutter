import 'package:flutter/material.dart';
import 'package:petfindr/Db/mongoConnection.dart';
import 'package:petfindr/UI/Widgets/ReportCard.dart';

class ListedReports extends StatefulWidget {
  const ListedReports({Key? key}) : super(key: key);

  @override
  _ListedReportsState createState() => _ListedReportsState();
}

class _ListedReportsState extends State<ListedReports> {
  @override
  void initState() {
    super.initState();
  }

  Future<dynamic>? fetchData() async {
    try {
      List<dynamic>? reports = await MongoDatabase.fetchReports();
      return reports;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final reports = snapshot.data as List<dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  height: 200,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      return Container(child: ReportCard(reportData: report));
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error fetching data: ${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
