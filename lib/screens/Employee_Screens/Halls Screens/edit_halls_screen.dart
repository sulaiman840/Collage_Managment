
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/halls Bloc/hall_cubit.dart';
import '../../../core/utils/color_manager.dart';

import '../../../models/halls_model .dart';
import '../../../widgets/home_widgets/ common_scaffold.dart';


class EditHallScreen extends StatefulWidget {
  final Hall hall;

  const EditHallScreen({required this.hall, Key? key}) : super(key: key);

  @override
  _EditHallScreenState createState() => _EditHallScreenState();
}

class _EditHallScreenState extends State<EditHallScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _projectorController;
  late TextEditingController _descriptionController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.hall.name);
    _projectorController = TextEditingController(text: widget.hall.projector);
    _descriptionController = TextEditingController(text: widget.hall.descreption );
  }

  void _updateHall() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final projector = _projectorController.text;
      final description = _descriptionController.text;

      context.read<HallCubit>().updateHall(widget.hall.id, name, projector, description);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Edit Hall',
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
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _updateHall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.lcolor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                  child: Text('Edit Hall', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
