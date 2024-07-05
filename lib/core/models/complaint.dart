class Complaint {
  final String id;
  final String address;
  final String description;
  final String category;
  final String responsible;
  final String status;
  final String priority;
  final String? attachmentUrl;

  Complaint({
    required this.id,
    required this.address,
    required this.description,
    required this.category,
    required this.responsible,
    required this.status,
    required this.priority,
    this.attachmentUrl,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'].toString(),
      address: json['address'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      responsible: json['responsible'] as String? ?? '',
      status: json['status'] as String? ?? '',
      priority: json['priority'] as String? ?? '',
      attachmentUrl: json['attachment'] != null ? json['attachment'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'description': description,
      'category': category,
      'responsible': responsible,
      'status': status,
      'priority': priority,
      'attachment': attachmentUrl,
    };
  }

  Complaint copyWith({
    String? id,
    String? address,
    String? description,
    String? category,
    String? responsible,
    String? status,
    String? priority,
    String? attachmentUrl,
  }) {
    return Complaint(
      id: id ?? this.id,
      address: address ?? this.address,
      description: description ?? this.description,
      category: category ?? this.category,
      responsible: responsible ?? this.responsible,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
    );
  }
}
