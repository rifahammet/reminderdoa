// import 'package:doa/utils/reflector.dart';

// @myReflectable
class Master_Bank {
  String? bank_name;
  int? isAktif;
  /* standard */
  int? id;
  int? dibuat_oleh;
  String? tanggal_dibuat;
  int? dimodifikasi_oleh;
  String? tanggal_dimodifikasi;
  int? isHapus;
  int? isSync;
  String? tanggal_sync;
  int? id_server;
  /* end standard */

  Master_Bank(
      {this.bank_name,
      this.isAktif,
      this.id,
      this.dibuat_oleh,
      this.tanggal_dibuat,
      this.dimodifikasi_oleh,
      this.tanggal_dimodifikasi,
      this.isHapus,
      this.isSync,
      this.tanggal_sync,
      this.id_server});
}
