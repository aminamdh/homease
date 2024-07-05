class Payment {
  int? id;
  String typeOfPayment;
  String paymentMethod;
  double billAmount;
  String? paymentProof;

  Payment({
    this.id,
    required this.typeOfPayment,
    required this.paymentMethod,
    required this.billAmount,
    this.paymentProof,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      typeOfPayment: json['type_of_payment'],
      paymentMethod: json['payment_method'],
      billAmount: json['bill_amount'] is String
          ? double.parse(json['bill_amount'])
          : json['bill_amount'],
      paymentProof: json['payment_proof'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_of_payment': typeOfPayment,
      'payment_method': paymentMethod,
      'bill_amount': billAmount,
      'payment_proof': paymentProof,
    };
  }

  Payment copyWith({
    int? id,
    String? typeOfPayment,
    String? paymentMethod,
    double? billAmount,
    String? paymentProof,
  }) {
    return Payment(
      id: id ?? this.id,
      typeOfPayment: typeOfPayment ?? this.typeOfPayment,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      billAmount: billAmount ?? this.billAmount,
      paymentProof: paymentProof ?? this.paymentProof,
    );
  }

  @override
  String toString() {
    return 'Payment{id: $id, typeOfPayment: $typeOfPayment, paymentMethod: $paymentMethod, billAmount: $billAmount, paymentProof: $paymentProof}';
  }
}
