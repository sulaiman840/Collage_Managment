
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/Laboratory Bloc/lab_detail_cubit.dart';
import '../../../Bloc/halls Bloc/hall_detail_cubit.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/home_widgets/ common_scaffold.dart';

class AddReservationScreenHall extends StatefulWidget {
  final int labId;
  final String place;

  const AddReservationScreenHall({required this.labId, required this.place, Key? key}) : super(key: key);

  @override
  _AddReservationScreenHallState createState() => _AddReservationScreenHallState();
}

class _AddReservationScreenHallState extends State<AddReservationScreenHall> {
  final _formKey = GlobalKey<FormState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  String? _selectedDoctor;
  String? _selectedLecture;
  String? _selectedDay;
  String? _selectedYear;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<HallDetailCubit>().fetchHallDetails(widget.labId);
  }

  void _addReservation() {
    if (_formKey.currentState!.validate()) {
      final year = _selectedYear ?? '';
      final day = _selectedDay ?? '';
      final from = _fromController.text;
      final to = _toController.text;
      final doctor = _selectedDoctor ?? '';
      final lecture = _selectedLecture ?? '';

      context.read<HallDetailCubit>().addReservation(widget.place, year, day, from, to, doctor, lecture, widget.labId);
      Navigator.pop(context, true);
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final formattedTime = _convertTo24HourFormat(picked);
        controller.text = formattedTime;
      });
    }
  }

  String _convertTo24HourFormat(TimeOfDay timeOfDay) {
    final formattedTime = '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Add Reservation',
      scaffoldKey: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedDay,
                decoration: InputDecoration(labelText: 'Day', border: OutlineInputBorder()),
                items: [
                  DropdownMenuItem(value: '1', child: Text('Saturday')),
                  DropdownMenuItem(value: '2', child: Text('Sunday')),
                  DropdownMenuItem(value: '3', child: Text('Monday')),
                  DropdownMenuItem(value: '4', child: Text('Tuesday')),
                  DropdownMenuItem(value: '5', child: Text('Wednesday')),
                  DropdownMenuItem(value: '6', child: Text('Thursday')),
                  DropdownMenuItem(value: '7', child: Text('Friday')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedDay = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a day';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedYear,
                decoration: InputDecoration(labelText: 'Year', border: OutlineInputBorder()),
                items: [
                  DropdownMenuItem(value: '1', child: Text('1 Year')),
                  DropdownMenuItem(value: '2', child: Text('2 Year')),
                  DropdownMenuItem(value: '3', child: Text('3 Year')),
                  DropdownMenuItem(value: '4', child: Text('4 Year')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedYear = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a year';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _fromController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'From',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () => _selectTime(context, _fromController),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a start time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _toController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'To',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () => _selectTime(context, _toController),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an end time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              BlocBuilder<HallDetailCubit, HallDetailState>(
                builder: (context, state) {
                  if (state is HallDetailLoaded) {
                    return DropdownButtonFormField<String>(
                      value: _selectedDoctor,
                      decoration: InputDecoration(labelText: 'Doctor', border: OutlineInputBorder()),
                      items: state.doctors.map<DropdownMenuItem<String>>((String doctor) {
                        return DropdownMenuItem<String>(
                          value: doctor,
                          child: Text(doctor),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDoctor = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a doctor';
                        }
                        return null;
                      },
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: 16),
              BlocBuilder<HallDetailCubit,HallDetailState>(
                builder: (context, state) {
                  if (state is HallDetailLoaded) {
                    return DropdownButtonFormField<String>(
                      value: _selectedLecture,
                      decoration: InputDecoration(labelText: 'Lecture', border: OutlineInputBorder()),
                      items: state.lectures.map<DropdownMenuItem<String>>((String lecture) {
                        return DropdownMenuItem<String>(
                          value: lecture,
                          child: Text(lecture),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLecture = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a lecture';
                        }
                        return null;
                      },
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _addReservation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.lcolor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                  child: Text('Add Reservation', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
