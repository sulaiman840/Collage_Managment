
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/halls Bloc/hall_cubit.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/home_widgets/ common_scaffold.dart';


class CreateHallScreen extends StatefulWidget {
  @override
  _CreateHallScreenState createState() => _CreateHallScreenState();
}

class _CreateHallScreenState extends State<CreateHallScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _projectorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _createHall() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final projector = _projectorController.text;
      final description = _descriptionController.text;

      context.read<HallCubit>().createHall(name, projector, description);
      Navigator.pop(context); // Return to previous screen after creation
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Create New Hall',
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
                  labelText: 'Hall Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hall name';
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
                  onPressed: _createHall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.lcolor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                  child: Text('Create Hall', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
