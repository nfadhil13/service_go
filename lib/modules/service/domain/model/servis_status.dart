enum ServisStatus {
  diajukan(
    id: 1,
    statusName: 'Diajukan',
    description: 'Layanan sedang diajukan',
    colorHex: '#404040',
  ),
  pengajuanDiterima(
    id: 2,
    statusName: 'Permintaan Diterima',
    description: 'Permintaan perbaikan diterima',
    colorHex: '#00008B',
  ),
  unitDiterima(
    id: 3,
    statusName: 'Unit Diterima',
    description: 'Unit yang diperlukan telah diterima',
    colorHex: '#006400',
  ),
  unitDiperiksa(
    id: 4,
    statusName: 'Unit Diperika',
    description: 'Unit sedang diperiksa oleh bengkel',
    colorHex: '#B8860B',
  ),
  konfirmasiServis(
    id: 5,
    statusName: 'Konfirmasi Servis',
    description: 'Bengkel mengajukan detail servis kepada customer',
    colorHex: '#9400D3',
  ),
  menungguPengerjaan(
    id: 6,
    statusName: 'Menunggu Pengerjaan',
    description:
        'Customer dan Bengkel setuju terhadap servis yang akan dilakukan pada unit',
    colorHex: '#FF8C00',
  ),
  pengerjaanService(
    id: 7,
    statusName: 'Pengerjaan Service',
    description: 'Sedang dalam proses pengerjaan layanan',
    colorHex: '#8B0000',
  ),
  siapDiambil(
    id: 8,
    statusName: 'Siap Diambil',
    description: 'Layanan telah selesai dan siap diambil',
    colorHex: '#8FBC8F',
  ),
  serviceSelesai(
    id: 9,
    statusName: 'Service Selesai',
    description: 'Layanan selesai dan telah diambil',
    colorHex: '#556B2F',
  ),
  ditolak(
    id: 10,
    statusName: 'Ditolak',
    description: 'Permintaan layanan ditolak',
    colorHex: '#E9967A',
  ),
  dibatalkan(
    id: 11,
    statusName: 'Dibatalkan',
    description:
        'Permintaan layanan dibatalkan oleh bengkel atau customer karena alasan tertentu',
    colorHex: '#E9967A',
  ),
  ;

  final int id;
  final String statusName;
  final String description;
  final String colorHex;
  const ServisStatus(
      {required this.id,
      required this.statusName,
      required this.description,
      required this.colorHex});

  static ServisStatus fromID(int id) {
    switch (id) {
      case 1:
        return ServisStatus.diajukan;
      case 2:
        return ServisStatus.pengajuanDiterima;
      case 3:
        return ServisStatus.unitDiterima;
      case 4:
        return ServisStatus.unitDiperiksa;
      case 5:
        return ServisStatus.konfirmasiServis;
      case 6:
        return ServisStatus.menungguPengerjaan;
      case 7:
        return ServisStatus.pengerjaanService;
      case 8:
        return ServisStatus.siapDiambil;
      case 9:
        return ServisStatus.serviceSelesai;
      case 10:
        return ServisStatus.ditolak;
      case 11:
        return ServisStatus.dibatalkan;
      default:
        throw ArgumentError('ID tidak valid untuk ServiceStatus.');
    }
  }
}
