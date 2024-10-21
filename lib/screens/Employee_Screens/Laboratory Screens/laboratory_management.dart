import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/Laboratory Bloc/lab_cubit.dart';
import '../../../Bloc/Laboratory Bloc/lab_detail_cubit.dart';
import '../../../core/utils/color_manager.dart';
import 'laboratory_detail_screen.dart';
import 'create_lab_screen.dart';
import 'edit_lab_screen.dart';
import '../../../services/lab_service.dart';

class LaboratoryManagement extends StatefulWidget {
  const LaboratoryManagement({super.key});

  @override
  _LaboratoryManagementState createState() => _LaboratoryManagementState();
}

class _LaboratoryManagementState extends State<LaboratoryManagement> {
  @override
  void initState() {
    super.initState();
    context.read<LabCubit>().fetchLabs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.hcolor,
      appBar: AppBar(
        title: Text('Laboratory Management' ,style: TextStyle(fontWeight: FontWeight.bold)),
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
                    MaterialPageRoute(builder: (context) => CreateLabScreen()),
                  );
                },
                tooltip: 'Add Laboratory',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LabCubit, LabState>(
          builder: (context, state) {
            if (state is LabLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LabLoaded) {
              return ListView.builder(
                itemCount: state.labs.length,
                itemBuilder: (context, index) {
                  final lab = state.labs[index];
                  return Card(
                    color: ColorManager.mcolor,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: ColorManager.lcolor,
                        child: Text(
                          lab.name[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(lab.name),
                      subtitle: Text('PCs: ${lab.pcNumber}, Projector: ${lab.projector}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditLabScreen(lab: lab),
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
                                    content: Text("Are you sure you want to delete this lab?"),
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
                                          context.read<LabCubit>().deleteLab(lab.id);
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
                              create: (context) => LabDetailCubit(LabService()),
                              child: LaboratoryDetailScreen(labId: lab.id),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is LabError) {
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
