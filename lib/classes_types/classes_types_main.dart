class Expense{
  String? name;
  int? category;
  DateTime? time;
  int? prize;
  int? currency;

  Map<int, String> categoryOptions = {1: "Jídlo a nápoje",2: "Doprava",3: "Zábava",4: "Zdraví a péče",5: "Oblečení a obuv",6: "Cestování a dovolená",7: "Účty a domácnost"};
  Map<int, String> currencyOptions = {1: "CZK", 2: "EUR", 3: "USD"};

  Expense({required this.name, required this.category, required this.time, required this.prize, required this.currency});
}