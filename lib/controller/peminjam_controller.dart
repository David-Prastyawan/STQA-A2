import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawn_book/model/peminjam_model.dart';

/// Impor pustaka yang diperlukan
class PeminjamController {
  final pinjamcollection = FirebaseFirestore.instance.collection('peminjam');

  /// Deklarasi koleksi Firestore untuk 'peminjam'
  /// FirebaseFirestore.instance adalah instance Firebase Firestore
  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  /// Membuat StreamController untuk mengelola aliran data Firestore
  /// .broadcast() memungkinkan banyak pendengar untuk aliran ini
  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  /// Getter untuk mengakses aliran data Firestore
  Future<void> addPeminjam(PeminjamModel pjmodel) async {
    final peminjam = pjmodel.toMap();

    /// Mengonversi objek PeminjamModel menjadi bentuk peta (Map)
    final DocumentReference docRef = await pinjamcollection.add(peminjam);

    /// Menambahkan dokumen baru ke koleksi 'peminjam' dan mendapatkan referensi dokumen baru
    final String docId = docRef.id;

    /// Mendapatkan ID dokumen yang baru saja dibuat
    final PeminjamModel peminjamModel = PeminjamModel(
      pid: docId,
      namapeminjam: pjmodel.namapeminjam,
      selectedBuku: pjmodel.selectedBuku,
      pengarang: pjmodel.pengarang,
      tglpinjam: pjmodel.tglpinjam,
      tglkembali: pjmodel.tglkembali,
    );

    /// Membuat objek PeminjamModel baru dengan ID dokumen yang baru saja dibuat
    await docRef.update(peminjamModel.toMap());

    /// Memperbarui dokumen dengan data PeminjamModel baru
  }

  Future<void> updatePeminjam(PeminjamModel pjmodel) async {
    final PeminjamModel peminjamModel = PeminjamModel(
        pid: pjmodel.pid,
        namapeminjam: pjmodel.namapeminjam,
        selectedBuku: pjmodel.selectedBuku,
        pengarang: pjmodel.pengarang,
        tglpinjam: pjmodel.tglpinjam,
        tglkembali: pjmodel.tglkembali);

    // Membuat objek PeminjamModel baru berdasarkan data yang diberikan
    await pinjamcollection.doc(pjmodel.pid).update(peminjamModel.toMap());

    // Memperbarui dokumen dengan data PeminjamModel yang baru
  }

  Future<void> removePeminjam(String pid) async {
    await pinjamcollection.doc(pid).delete();

    // Menghapus dokumen dengan ID yang diberikan
  }

  Future getPinjam() async {
    final contact = await pinjamcollection.get();
    streamController.add(contact.docs);

    // Mengambil data dari koleksi 'peminjam' dan menambahkannya ke aliran data
    // Kemungkinan typo, "contact" seharusnya "querySnapshot"
    return contact.docs;
  }
}
