import 'dart:convert';

class Otp {
  final bool status;
  final String otp;
  Otp({
    this.status,
    this.otp,
  });

  Otp copyWith({
    bool status,
    String otp,
  }) {
    return Otp(
      status: status ?? this.status,
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'otp': otp,
    };
  }

  factory Otp.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Otp(
      status: map['status'],
      otp: map['otp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Otp.fromJson(String source) => Otp.fromMap(json.decode(source));

  @override
  String toString() => 'Otp(status: $status, otp: $otp)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Otp &&
      o.status == status &&
      o.otp == otp;
  }

  @override
  int get hashCode => status.hashCode ^ otp.hashCode;
}