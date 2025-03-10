class Expense{
  String? name;
  int? category;
  DateTime? time;
  int? prize;
  int? currency;

  Map<int, String> categoryOptions = {0: "Účty a domácnost", 1: "Jídlo a nápoje",2: "Doprava",3: "Zábava",4: "Zdraví a péče",5: "Oblečení a obuv",6: "Cestování a dovolená"};
  Map<int, String> currencyOptions = {0: "USD", 1: "CZK", 2: "EUR"};

  Expense({required this.name, required this.category, required this.time, required this.prize, required this.currency});
}