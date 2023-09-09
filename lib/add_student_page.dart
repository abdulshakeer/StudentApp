import 'package:flutter/material.dart';
import 'package:students/main.dart';
import 'student_data.dart'; // Import the student data
import 'sql_helper.dart'; // Import the DatabaseHelper class

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController marksController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student Details'), // Change the title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTextField(
                labelText: 'Name',
                controller: nameController,
              ),
              _buildTextField(
                labelText: 'Roll No',
                controller: rollNoController,
              ),
              _buildTextField(
                labelText: 'Branch',
                controller: branchController,
              ),
              _buildTextField(
                labelText: 'Marks',
                controller: marksController,
              ),
              _buildTextField(
                labelText: 'Date of Birth',
                controller: dobController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Get the edited values from the controllers
                  final name = nameController.text;
                  final rollNo = rollNoController.text;
                  final branch = branchController.text;
                  final marks = int.tryParse(marksController.text) ??
                      0; // Parse marks as an integer
                  final dob = dobController.text;

                  // Create a new record in the database
                  final newRecord = {
                    'name': name,
                    'rollNo': rollNo,
                    'branch': branch,
                    'marks': marks,
                    'dob': dob,
                  };

                  final dbHelper = DatabaseHelper();
                  await dbHelper.insertRecord(newRecord);

                  // Navigate to the ViewDetailsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewDetailsPage(),
                    ),
                  );
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
