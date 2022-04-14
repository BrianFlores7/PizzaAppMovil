class OrderModel {
  int? id;
  String? pizzaName;
  String? pizzaDescription;
  String? direction;

  OrderModel(this.pizzaName, this.pizzaDescription, this.direction, [this.id]);

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pizzaName = json['pizzaName'];
    pizzaDescription = json['pizzaDescription'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pizzaName'] = this.pizzaName;
    data['pizzaDescription'] = this.pizzaDescription;
    data['direction'] = this.direction;
    return data;
  }
}
