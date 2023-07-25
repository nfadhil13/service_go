enum ServisStatus {
  pengajuanReschedule(
    id: 1,
    statusName: 'Pengajuan Reschedule',
    description: 'Permintaan pengajuan reschedule layanan',
    colorHex: '#FFC0CB',
  ),
  diajukan(
    id: 2,
    statusName: 'Diajukan',
    description: 'Layanan sedang diajukan',
    colorHex: '#ADD8E6',
  ),
  ditinjau(
    id: 3,
    statusName: 'Ditinjau',
    description: 'Layanan sedang ditinjau oleh pihak terkait',
    colorHex: '#FFFF00',
  ),
  menungguUnit(
    id: 4,
    statusName: 'Menunggu Unit',
    description: 'Menunggu unit yang diperlukan untuk pengerjaan',
    colorHex: '#008000',
  ),
  unitDiterima(
    id: 5,
    statusName: 'Unit Diterima',
    description: 'Unit yang diperlukan telah diterima',
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
  butuhReschedule(
    id: 9,
    statusName: 'Butuh Reschedule',
    description: 'Memerlukan reschedule layanan',
    colorHex: '#808080',
  ),
  ditolak(
    id: 10,
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
        return ServisStatus.pengajuanReschedule;
      case 2:
        return ServisStatus.diajukan;
      case 3:
        return ServisStatus.ditinjau;
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
        return ServisStatus.butuhReschedule;
      case 10:
        return ServisStatus.ditolak;
      default:
        throw ArgumentError('ID tidak valid untuk ServiceStatus.');
    }
  }
}
