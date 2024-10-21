
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/Laboratory Bloc/lab_detail_cubit.dart';
import '../../../../models/reservation_model.dart';
import '../../../Bloc/halls Bloc/hall_detail_cubit.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/home_widgets/ common_scaffold.dart';

class UpdateReservationScreenHall extends StatefulWidget {
  final Reservation reservation;
  final int labId;

  const UpdateReservationScreenHall({required this.reservation, required this.labId, Key? key}) : super(key: key);

  @override
  _UpdateReservationScreenHallState createState() => _UpdateReservationScreenHallState();
}

class _UpdateReservationScreenHallState extends State<UpdateReservationScreenHall> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fromController;
  late TextEditingController _toController;
  String? _selectedDoctor;
  String? _selectedLecture;
  String? _selectedDay;
  String? _selectedYear;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fromController = TextEditingController(text: _formatTime(widget.reservation.from));
    _toController = TextEditingController(text: _formatTime(widget.reservation.to));
    _selectedDay = widget.reservation.day;
    _selectedYear = widget.reservation.year;
    _selectedDoctor = widget.reservation.doctor;
    _selectedLecture = widget.reservation.lecture;
    context.read<HallDetailCubit>().fetchHallDetails(widget.labId);
  }

  String _formatTime(String time) {
    final timeParts = time.split(':');
    final formattedTime = '${timeParts[0].padLeft(2, '0')}:${timeParts[1].padLeft(2, '0')}';
    return formattedTime;
  }

  void _updateReservation() {
    if (_formKey.currentState!.validate()) {
      context.read<HallDetailCubit>().updateReservation(
        widget.reservation.id,
        widget.reservation.place,
        _selectedYear!,
        _selectedDay!,
        _fromController.text,
        _toController.text,
        _selectedDoctor!,
        _selectedLecture!,
        widget.labId,
      );
      Navigator.pop(context, true); // Return to the previous screen after update
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
      title: 'Update Reservation',
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
              BlocBuilder<HallDetailCubit, HallDetailState>(
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
                  onPressed: _updateReservation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  ColorManager.lcolor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                  child: Text('Update Reservation', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
