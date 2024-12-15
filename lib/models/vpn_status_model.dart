class VpnStatusModel {
  String? byteIn;
  String? byteOut;
  String? durationTime;
  String? lastPacketRecived;

  VpnStatusModel(
      {this.byteIn, this.byteOut, this.durationTime, this.lastPacketRecived});

  factory VpnStatusModel.fromjson(Map<String, dynamic> jsonData) =>
      VpnStatusModel(
        byteIn: jsonData['byte_in'],
        byteOut: jsonData['byte_out'],
        durationTime: jsonData['duration'],
        lastPacketRecived: jsonData['last_packet_receive'],
      );

  Map<String, dynamic> toJson() => {
        'byte_in': byteIn,
        'byte_out': byteOut,
        'duration': durationTime,
        'last_packet_receive': lastPacketRecived,
      };
}
