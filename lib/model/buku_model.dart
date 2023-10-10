// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// Definisi kelas BukuModel untuk merepresentasikan data buku
class BukuModel {
  /// Variabel untuk menyimpan ID buku (opsional)
  String? bukuid;

  /// Variabel untuk menyimpan judul buku
  final String judulbuku;

  /// Variabel untuk menyimpan nama pengarang buku
  final String pengarangbuku;

  /// Variabel untuk menyimpan nama penerbit buku
  final String penerbitbuku;

  /// Variabel untuk menyimpan nilai terpilih (selected value)
  final String selectedValue;

  /// Konstruktor untuk membuat objek BukuModel
  BukuModel({
    this.bukuid,
    required this.judulbuku,
    required this.pengarangbuku,
    required this.penerbitbuku,
    required this.selectedValue,
    // Konstruktor untuk membuat objek BukuModel
  });

  /// Metode untuk mengonversi objek BukuModel menjadi Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bukuid': bukuid,
      'judulbuku': judulbuku,
      'pengarangbuku': pengarangbuku,
      'penerbitbuku': penerbitbuku,
      'selectedValue': selectedValue,
      // Metode untuk mengonversi objek BukuModel menjadi Map
    };
    // Metode untuk mengonversi objek BukuModel menjadi Map
  }

  /// Factory method untuk membuat objek BukuModel dari Map
  factory BukuModel.fromMap(Map<String, dynamic> map) {
    return BukuModel(
      bukuid: map['bukuid'] != null ? map['bukuid'] as String : null,
      judulbuku: map['judulbuku'] as String,
      pengarangbuku: map['pengarangbuku'] as String,
      penerbitbuku: map['penerbitbuku'] as String,
      selectedValue: map['selectedValue'] as String,
      // Factory method untuk membuat objek BukuModel dari Map
    );
    // Factory method untuk membuat objek BukuModel dari Map
  }

  // Metode untuk mengonversi objek BukuModel menjadi JSON
  String toJson() => json.encode(toMap());

  // Factory method untuk membuat objek BukuModel dari JSON
  factory BukuModel.fromJson(String source) =>
      BukuModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
