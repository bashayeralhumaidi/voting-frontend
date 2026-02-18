import 'package:flutter/material.dart';
import 'PillarVotingPage.dart';
import 'main.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final List<Map<String, dynamic>> initiatives = [
    {
      "title": "Automation System",
      "solution": "AI-based automation for operations",
      "impact": "High efficiency and cost saving",
      "voted": false,
    },
    {
      "title": "Process Optimization",
      "solution": "AI workflow optimization system",
      "impact": "Improved productivity",
      "voted": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF004667);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Image.asset("assets/JulpharAI_Logo_white.png", height: 40),
            const SizedBox(width: 15),
            const Text(
              "Voting Portal",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginIntroPage(),
                ),
                (route) => false,
              );
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(
                  label: Text("AI Initiative Title",
                      style:
                          TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Summary of AI Solution",
                      style:
                          TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Business Impact Explanation",
                      style:
                          TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Action",
                      style:
                          TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: initiatives.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;

              return DataRow(
                color:
                    MaterialStateProperty.resolveWith<Color?>(
                  (states) =>
                      item["voted"] == true
                          ? Colors.green.shade100
                          : null,
                ),
                cells: [
                  DataCell(Text(item["title"])),
                  DataCell(Text(item["solution"])),
                  DataCell(Text(item["impact"])),
                  DataCell(
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            item["voted"] == true
                                ? Colors.grey
                                : primaryColor,
                        foregroundColor: Colors.white,
                      ),
                     onPressed: item["voted"] == true
                          ? null
                          : () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PillarVotingPage(
                                    title: item["title"],
                                    solution: item["solution"],
                                    impact: item["impact"],
                                  ),
                                ),
                              );

                              if (result != null) {
                                setState(() {
                                  initiatives[index]["voted"] = true;
                                });
                              }
                            },

                      child: const Text("Vote"),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
