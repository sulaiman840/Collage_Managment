
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/Laboratory Bloc/lab_cubit.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/home_widgets/ common_scaffold.dart';

class CreateLabScreen extends StatefulWidget {
  @override
  _CreateLabScreenState createState() => _CreateLabScreenState();
}

class _CreateLabScreenState extends State<CreateLabScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pcNumberController = TextEditingController();
  final _projectorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _createLab() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final pcNumber = int.parse(_pcNumberController.text);
      final projector = _projectorController.text;
      final description = _descriptionController.text;

      context.read<LabCubit>().createLab(name, pcNumber, projector, description);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Create New Lab',
      scaffoldKey: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Lab Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter lab name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _pcNumberController,
                decoration: InputDecoration(
                  labelText: 'PC Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PC number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _projectorController,
                decoration: InputDecoration(
                  labelText: 'Projector',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter projector status';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',

                  border: OutlineInputBorder(),
                ),

                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _createLab,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  ColorManager.lcolor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                  child: Text('Creat Lab',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
