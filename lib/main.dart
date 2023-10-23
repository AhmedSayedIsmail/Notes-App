import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/network/local/cach_helper.dart';
import 'package:todo_application/routes/routes.dart';
import 'package:todo_application/core/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:todo_application/core/controllers/todo_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoCubit()..readUsersData()),
        BlocProvider(
            create: (context) => ReadDataCubit()
              ..readUserCategoies()
              ..readUserTasks()
              ..readCategoies()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
