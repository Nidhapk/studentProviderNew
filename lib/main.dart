import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/model/student_model.dart';
import 'package:studentprovider/provider/student_provider.dart';
import 'package:studentprovider/provider/theme_provider.dart';
import 'package:studentprovider/view/add_screen.dart';
import 'package:studentprovider/view/edit_screen.dart';
import 'package:studentprovider/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>('studentBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => StudentProvider()),
          ChangeNotifierProvider(create: (context) => Imageprovider()),
          ChangeNotifierProvider(create: (context) => StudentProvider()),
          ChangeNotifierProvider(create: (context) => EditImageprovider()),
        ],
        builder: (context, child) {
          final provider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: provider.thememode,
            home: const HomeScreen(),
          );
        });
  }
}
