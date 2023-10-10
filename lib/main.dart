import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawn_book/view/add_daftarbuku.dart';
import 'package:pawn_book/view/add_daftarpeminjam.dart';
import 'package:pawn_book/view/detail_daftarbuku.dart';
import 'package:pawn_book/view/detail_daftarpeminjam.dart';
import 'package:pawn_book/view/edit_daftarbuku.dart';
import 'package:pawn_book/view/edit_daftarpeminjam.dart';
import 'package:pawn_book/view/homepage.dart';
import 'package:pawn_book/view/loginpage.dart';
import 'package:pawn_book/view/splash.dart';

// Inisialisasi aplikasi Flutter
// Mendefinisikan fungsi main sebagai titik masuk utama aplikasi
Future main() async {
  // Memastikan bahwa pustaka WidgetsFlutterBinding telah diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // Menginisialisasi Firebase, memastikan Firebase siap digunakan
  await Firebase.initializeApp();

  // Menjalankan aplikasi Flutter dengan widget MyApp sebagai root widget
  runApp(const MyApp());
}

// Kelas utama yang mewakili aplikasi
class MyApp extends StatelessWidget {
  // Konstruktor kelas MyApp
  const MyApp({super.key});

  /// metode build dari kelas MyApp yang merupakan bagian dari framework
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Menyembunyikan banner "Debug"
      debugShowCheckedModeBanner: false,
      // Judul aplikasi (PawnBook)
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor:
                // Konfigurasi skema warna
                Color.fromARGB(255, 209, 131, 102)),
        // Mengaktifkan Material You (Material Design 3)
        useMaterial3: true,
      ),
      // Tampilan awal aplikasi
      home: LoginPage(),
    );
  }
}
