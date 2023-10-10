// Mengimpor package yang diperlukan
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawn_book/model/user_model.dart';

// Membuat kelas AuthController
class AuthController {
  final auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Property getter yang selalu mengembalikan nilai false
  bool get success => false;

  /// Fungsi untuk melakukan proses login dengan email dan password
  Future<UserModel?> signInWithEmailAndPassword(

      /// Fungsi untuk melakukan proses login dengan email dan password
      String email,
      String password) async {
    try {
      // Melakukan login menggunakan FirebaseAuth
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        // Jika login berhasil, mengambil data pengguna dari Firestore
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();

        // Membuat objek UserModel dari data pengguna yang diambil
        final UserModel currentUser = UserModel(
          uID: user.uid,
          email: user.email ?? '',
          name: snapshot['name'] ?? '',
        );

        return currentUser;
      }
    } catch (e) {
      // Menangani kesalahan yang mungkin terjadi saat login
      //print('Error signIn user: $e');
    }

    return null;
  }

  /// Fungsi untuk melakukan proses registrasi dengan email, password, dan nama
  Future<UserModel?> registerWithEmailAndPassword(

      /// Fungsi untuk melakukan proses registrasi dengan email, password, dan nama
      String email,
      String password,
      String name) async {
    /// Fungsi untuk melakukan proses registrasi dengan email, password, dan nama
    try {
      // Melakukan registrasi menggunakan FirebaseAuth
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        // Jika registrasi berhasil, membuat objek UserModel baru
        final UserModel newUser =
            UserModel(uID: user.uid, email: user.email ?? '', name: name);

        // Menyimpan data pengguna ke Firestore
        await userCollection.doc(newUser.uID).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      // Menangani kesalahan yang mungkin terjadi saat registrasi
      print('Error registering user: $e');
    }

    return null;
  }

  /// Fungsi untuk mendapatkan pengguna yang saat ini sedang masuk
  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  /// Fungsi untuk keluar dari akun
  Future<void> signOut() async {
    await auth.signOut();

    /// Fungsi untuk keluar dari akun
  }
}
