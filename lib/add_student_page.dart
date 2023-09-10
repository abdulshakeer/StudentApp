import 'package:flutter/material.dart';
import 'package:students/main.dart';
import 'sql_helper.dart'; // Import the DatabaseHelper class

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController marksController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime? selectedDate; // Make selectedDate nullable

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextField(
                  labelText: 'Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  labelText: 'Roll No',
                  controller: rollNoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Roll No is required';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  labelText: 'Branch',
                  controller: branchController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Branch is required';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  labelText: 'Marks',
                  controller: marksController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mark is required';
                    }
                    return null;
                  },
                ),
                _buildDateField(
                  labelText: 'Date of Birth',
                  controller: dobController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final name = nameController.text;
                      final rollNo = rollNoController.text;
                      final branch = branchController.text;
                      final marks = int.tryParse(marksController.text) ?? 0;
                      final dob = dobController.text;

                      final newRecord = {
                        'name': name,
                        'rollNo': rollNo,
                        'branch': branch,
                        'marks': marks,
                        'dob': dob,
                      };

                      final dbHelper = DatabaseHelper();
                      await dbHelper.insertRecord(newRecord);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewDetailsPage(),
                        ),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDateField({
    required String labelText,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        onTap: () => _selectDate(context),
        readOnly: true,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
