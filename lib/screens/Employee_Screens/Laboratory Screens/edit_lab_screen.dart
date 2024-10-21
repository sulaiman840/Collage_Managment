
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/Laboratory Bloc/lab_cubit.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/lab_model.dart';
import '../../../widgets/home_widgets/ common_scaffold.dart';


class EditLabScreen extends StatefulWidget {
  final Lab lab;

  const EditLabScreen({required this.lab, Key? key}) : super(key: key);

  @override
  _EditLabScreenState createState() => _EditLabScreenState();
}

class _EditLabScreenState extends State<EditLabScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _pcNumberController;
  late TextEditingController _projectorController;
  late TextEditingController _descriptionController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.lab.name);
    _pcNumberController = TextEditingController(text: widget.lab.pcNumber.toString());
    _projectorController = TextEditingController(text: widget.lab.projector);
    _descriptionController = TextEditingController(text: widget.lab.descreption );
  }

  void _updateLab() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final pcNumber = int.parse(_pcNumberController.text);
      final projector = _projectorController.text;
      final description = _descriptionController.text;

      context.read<LabCubit>().updateLab(widget.lab.id, name, pcNumber, projector, description);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Edit Lab',
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
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _updateLab,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.lcolor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                  child: Text('Edit Lab',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
