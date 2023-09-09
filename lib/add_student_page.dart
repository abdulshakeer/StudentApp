import 'package:flutter/material.dart';
import 'package:students/main.dart';
import 'student_data.dart'; // Import the student data

class AddStudentPage extends StatefulWidget {
  final List<Map<String, dynamic>> studentData;

  AddStudentPage({required this.studentData});

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
  void dispose() {
    nameController.dispose();
    rollNoController.dispose();
    branchController.dispose();
    marksController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student Details'),
      ),
      body: SingleChildScrollView(
        // Wrap the content in SingleChildScrollView
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
                onPressed: () {
                  // Get the edited values from the controllers
                  final name = nameController.text;
                  final rollNo = rollNoController.text;
                  final branch = branchController.text;
                  final marks = marksController.text;
                  final dob = dobController.text;

                  // Update the studentData list with the entered details
                  widget.studentData.add({
                    'name': name,
                    'rollNo': rollNo,
                    'branch': branch,
                    'marks': marks,
                    'dob': dob,
                  });

                  // Navigate to the ViewDetailsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewDetailsPage(studentData: widget.studentData),
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
