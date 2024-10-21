import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itcollage/services/complaint_service.dart';
import 'package:itcollage/services/halls_service.dart';
import 'package:itcollage/services/lab_service.dart';
import 'package:itcollage/services/reservation_service.dart';
import 'Bloc/Laboratory Bloc/lab_cubit.dart';
import 'Bloc/Laboratory Bloc/lab_detail_cubit.dart';
import 'Bloc/complaint_cubit.dart';
import 'Bloc/halls Bloc/hall_cubit.dart';
import 'Bloc/halls Bloc/hall_detail_cubit.dart';
import 'Bloc/reserve_cubit.dart';
import 'core/utils/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LabCubit(LabService())),
        BlocProvider(create: (context) => HallCubit(HallService())),
        BlocProvider(create: (context) => LabDetailCubit(LabService())),
        BlocProvider(create: (context) => HallDetailCubit(HallService())),
        BlocProvider(create: (context) => ReserveCubit(ReservationService())),
        BlocProvider(create: (context) => ComplaintCubit(ComplaintService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppRouter.home,
        routes: AppRouter.routes,
      ),
    );
  }
}
