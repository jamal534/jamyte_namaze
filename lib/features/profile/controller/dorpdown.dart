
class ChooseCar {
  static String? carSelectedValue = 'Select Complain';
  static List<String> carItems = [
    'Select Complain',
    "Billing Issue",
    "Service Delay",
    "Wrong Product",
    "Technical Support",
    "Other"
  ];


  void onChanged(String? newValue) {
    carSelectedValue = newValue!;
    print(carSelectedValue);
  }

}