
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/halls Bloc/hall_cubit.dart';
import '../../../Bloc/halls Bloc/hall_detail_cubit.dart';
import '../../../core/utils/color_manager.dart';


import '../../../services/halls_service.dart';
import 'create_halls_screen.dart';
import 'edit_halls_screen.dart';
import 'halls_detail_screen.dart';


class HallManagement extends StatefulWidget {
  const HallManagement({super.key});

  @override
  _HallManagementState createState() => _HallManagementState();
}

class _HallManagementState extends State<HallManagement> {
  @override
  void initState() {
    super.initState();
    context.read<HallCubit>().fetchHalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.hcolor,
      appBar: AppBar(
        title: Text('Halls Management', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: ColorManager.hcolor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.lcolor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateHallScreen()),
                  );
                },
                tooltip: 'Add Hall',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HallCubit, HallState>(
          builder: (context, state) {
            if (state is HallLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HallLoaded) {
              return ListView.builder(
                itemCount: state.halls.length,
                itemBuilder: (context, index) {
                  final hall = state.halls[index];
                  return Card(
                    color: ColorManager.mcolor,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: ColorManager.lcolor,
                        child: Text(
                          hall.name[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(hall.name),
                      subtitle: Text('Projector: ${hall.projector}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditHallScreen(hall: hall),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirm Delete"),
                                    content: Text("Are you sure you want to delete this hall?"),
                                    actions: [
                                      TextButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text("Delete"),
                                        onPressed: () {
                                          context.read<HallCubit>().deleteHall(hall.id);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => HallDetailCubit(HallService()),
                              child: HallDetailScreen(hallId: hall.id),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is HallError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
