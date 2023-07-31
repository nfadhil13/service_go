enum ServisStatus {
  diajukan(
    id: 1,
    statusName: 'Diajukan',
    description: 'Layanan sedang diajukan',
    colorHex: '#ADD8E6',
  ),
  pengajuanDiterima(
    id: 2,
    statusName: 'Permintaan Diterima',
    description: 'Layanan sedang ditinjau oleh begnkel',
    colorHex: '#FFFF00',
  ),
  unitDiterima(
    id: 3,
    statusName: 'Unit Diterima',
    description: 'Unit yang diperlukan telah diterima',
    colorHex: '#FFA500',
  ),
  unitDiperiksa(
    id: 4,
    statusName: 'Unit Diperika',
    description: 'Unit yang diperlukan sedang diperiksa oleh bengkel',
    colorHex: '#FFA500',
  ),
  konfirmasiServis(
    id: 5,
    statusName: 'Konfirmasi Servis',
    description: 'Unit yang diperlukan sedang diperiksa oleh bengkel',
    colorHex: '#FFA500',
  ),
  konfirmasiServis(
    id: 5,
    statusName: 'Konfirmasi Servis',
    description: 'Unit yang diperlukan sedang diperiksa oleh bengkel',
    colorHex: '#FFA500',
  ),
  pengerjaanService(
    id: 6,
    statusName: 'Pengerjaan Service',
    description: 'Sedang dalam proses pengerjaan layanan',
    colorHex: '#800080',
  ),
  siapDiambil(
    id: 7,
    statusName: 'Siap Diambil',
    description: 'Layanan telah selesai dan siap diambil',
    colorHex: '#008080',
  ),
  serviceSelesai(
    id: 8,
    statusName: 'Service Selesai',
    description: 'Layanan selesai dan telah diambil',
    colorHex: '#00FFFF',
  ),
  ditolak(
    id: 9,
    statusName: 'Ditolak',
    description: 'Permintaan layanan ditolak',
    colorHex: '#000000',
  );

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
        return ServisStatus.menungguUnit;
      case 4:
        return ServisStatus.menungguUnit;
      case 5:
        return ServisStatus.unitDiterima;
      case 6:
        return ServisStatus.pengerjaanService;
      case 7:
        return ServisStatus.siapDiambil;
      case 8:
        return ServisStatus.serviceSelesai;
      case 9:
        return ServisStatus.ditolak;
      default:
        throw ArgumentError('ID tidak valid untuk ServiceStatus.');
    }
  }
}
