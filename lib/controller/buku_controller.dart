import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawn_book/model/buku_model.dart';

/// Impor pustaka yang diperlukan
class BukuController {
  final bukucollection = FirebaseFirestore.instance.collection('buku');

  // Deklarasi koleksi Firestore untuk 'buku'
  // FirebaseFirestore.instance adalah instance Firebase Firestore
  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  // Membuat StreamController untuk mengelola aliran data Firestore
  // .broadcast() memungkinkan banyak pendengar untuk aliran ini
  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  /// Getter untuk mengakses aliran data Firestore
  Future<void> addBuku(BukuModel bkmodel) async {
    final buku = bkmodel.toMap();

    /// Mengonversi objek BukuModel menjadi bentuk peta (Map)
    final DocumentReference docRef = await bukucollection.add(buku);

    /// Menambahkan dokumen baru ke koleksi 'buku' dan mendapatkan referensi dokumen baru
    final String docId = docRef.id;

    /// Mendapatkan ID dokumen yang baru saja dibuat
    final BukuModel bukuModel = BukuModel(
        bukuid: docId,
        judulbuku: bkmodel.judulbuku,
        pengarangbuku: bkmodel.pengarangbuku,
        penerbitbuku: bkmodel.penerbitbuku,
        selectedValue: bkmodel.selectedValue);

    // Membuat objek BukuModel baru dengan ID dokumen yang baru saja dibuat
    await docRef.update(bukuModel.toMap());
  }

  /// Memperbarui dokumen dengan data BukuModel baru
  Future<void> updateBuku(BukuModel bkmodel) async {
    final BukuModel bukuModel = BukuModel(
        bukuid: bkmodel.bukuid,
        judulbuku: bkmodel.judulbuku,
        pengarangbuku: bkmodel.pengarangbuku,
        penerbitbuku: bkmodel.penerbitbuku,
        selectedValue: bkmodel.selectedValue);

    // Membuat objek BukuModel baru berdasarkan data yang diberikan
    await bukucollection.doc(bkmodel.bukuid).update(bukuModel.toMap());

    // Memperbarui dokumen dengan data BukuModel yang baru
  }

  Future<void> removeBuku(String bukuid) async {
    await bukucollection.doc(bukuid).delete();

    // Menghapus dokumen dengan ID yang diberikan
  }

  Future getBuku() async {
    final contact = await bukucollection.get();
    streamController.add(contact.docs);

    // Mengambil data dari koleksi 'buku' dan menambahkannya ke aliran data
    // Kemungkinan typo, "contact" seharusnya "querySnapshot"
    return contact.docs;
  }
}
