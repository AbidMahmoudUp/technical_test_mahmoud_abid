enum TobaccoUse {
  never('Never'),
  former('Former smoker'),
  occasional('Occasional', 'Less than 1 cigarette per day'),
  regular('Regular smoker', 'Up to 10 cigarettes per day'),
  heavy('Heavy smoker', 'More than 10 cigarettes per day');

  const TobaccoUse(this.label, [this.description]);

  final String label;
  final String? description;
}
