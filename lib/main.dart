import 'package:flutter/material.dart';
import 'package:students/student_data.dart';
import 'add_student_page.dart'; // Import the add_student_page.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Student Management System'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        centerTitle: true, // Center the title text
        backgroundColor: Color(0xFF1D267D),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20), // Add some spacing
            _buildActionButton(
              icon: Icons.add,
              label: 'Add Student',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddStudentPage(
                            studentData: [],
                          )),
                );
                // Add student functionality here
              },
            ),
            SizedBox(height: 20), // Add spacing between buttons
            _buildActionButton(
              icon: Icons.visibility,
              label: 'View Details',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewDetailsPage(studentData: studentData)),
                );
                // View student details functionality here
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue, // You can set your desired color here
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ViewDetailsPage extends StatelessWidget {
  final List<Map<String, dynamic>> studentData;

  ViewDetailsPage({required this.studentData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: ListView.builder(
        itemCount: studentData.length,
        itemBuilder: (context, index) {
          final student = studentData[index];
          return _buildStudentCard(student);
        },
      ),
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text('Name: ${student['name']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Roll No: ${student['rollNo']}'),
            Text('Branch: ${student['branch']}'),
            Text('Marks: ${student['marks']}'),
            Text('Date of Birth: ${student['dob']}'),
          ],
        ),
      ),
    );
  }
}
