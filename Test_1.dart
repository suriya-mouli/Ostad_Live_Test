import 'dart:io';
void main() {
  print("Enter number of students:");
  int n = int.parse(stdin.readLineSync()!);
  Map<String, double> averages = {};

  for (int i = 0; i < n; i++) {
    print("\nEnter name of student ${i + 1}:");
    String name = stdin.readLineSync()!;

    print("Enter scores  $name :");
    List<String> scoreStrings = stdin.readLineSync()!.split(' ');
    List<int> scores = scoreStrings.map(int.parse).toList();

    double average = scores.reduce((a, b) => a + b) / scores.length;
    averages[name] = double.parse(average.toStringAsFixed(2));
  }

  var sortedEntries = averages.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  Map<String, double> sortedMap = {
    for (var entry in sortedEntries) entry.key: entry.value
  };

  print("\nSorted Averages:");
  print(sortedMap);
}
