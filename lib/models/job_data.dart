
class JobData {
  String title;
  String description;
  List<String> countries;

  JobData({
    required this.title,
    required this.description,
    required this.countries,
  });

  factory JobData.fromJson(Map<String, dynamic> json) {
    return JobData(
      title: json['title'],
      description: json['description'],
      countries: List<String>.from(json['countries']),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'countries': countries,
  };
}
