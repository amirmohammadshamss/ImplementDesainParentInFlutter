import 'package:flutter/cupertino.dart';

enum PizzaSize {
  small,
  medium,
  large,
  extraLarge,
}

enum PizzaSauce {
  none,
  tomato,
  garlic,
  hot,
  mild,
}

enum PizzaCrust { classic, deepDish, panBaked, cross, newYork }

class Pizza {
  late final PizzaSize _size;
  late final PizzaCrust _crust;
  late final PizzaSauce _sauce;
  final List<String> _toppings = [];
  late final String _notes;
  late final double _price;
  late final String _name;


  PizzaSize get size => _size;
  PizzaCrust get crust => _crust;
  PizzaSauce get sauce => _sauce;
  String get toppings => _stringifiedToppings();
  String get notes => _notes;
  double get price => _price;


  void addTopping(String topping) {
    _toppings.add(topping);
  }

  void setPrice(double price) {
    _price = price;
  }

  void setName(String name) {
    _name = name;
  }

  void setSize(PizzaSize size) {
    _size = size;
  }

  void setCrust(PizzaCrust crust) {
    _crust = crust;
  }

  void setSauce(PizzaSauce sauce) {
    _sauce = sauce;
  }

  void addNotes(String notes) {
    _notes = notes;
  }

  String _stringifiedToppings() {
    var stringToppings = _toppings.join(", ");
    var lastComma = stringToppings.lastIndexOf(",");
    var replacement =
        ",".allMatches(stringToppings).length > 1 ? ", and" : " and";

    return stringToppings.replaceRange(lastComma, lastComma + 1, replacement);
  }

  @override
  String toString() {
    return "A delicious $_name pizza with ${_crust.toString().split(".")[1]} crust covered in ${_stringifiedToppings()}";
  }
}

abstract class PizzaBuilder {
  @protected

  late Pizza pizza;
  @protected

  late String name;

  void createPizza() {
    pizza = Pizza();
    pizza.setName(name);
  }

  Pizza getPizza() {
    return pizza;
  }

  void setPizzaPrice(double price) {
    pizza.setPrice(price);
  }

  void setSize(PizzaSize size) {
    pizza.setSize(size);
  }

  void addNotes(String notes) {
    pizza.addNotes(notes);
  }

  void buildSauce();
  void buildToppings();
  void buildCrust();
}

class HawaiianPizzaBuilder extends PizzaBuilder {
  static const String pizzaName = "Hawaiian Style";

  HawaiianPizzaBuilder() {
    super.name = pizzaName;
  }

  @override
  void buildCrust() {
    pizza.setCrust(PizzaCrust.classic);
  }

  @override
  void buildSauce() {
    pizza.setSauce(PizzaSauce.mild);
  }

  @override
  void buildToppings() {
    pizza.addTopping("ham");
    pizza.addTopping("pinnaple");
  }
}


class NewYorkPizzaBuilder extends PizzaBuilder {
  static const String pizzaName = "New York Style";

  NewYorkPizzaBuilder() {
    super.name = pizzaName;
  }

  @override
  void buildCrust() {
    pizza.setCrust(PizzaCrust.newYork);
  }

  @override
  void buildSauce() {
    pizza.setSauce(PizzaSauce.tomato);
  }

  @override
  void buildToppings() {
    pizza.addTopping("mozzarella cheese");
    pizza.addTopping("pepperoni");
  }
}

class PizzaDirector {
  late PizzaBuilder _pizzaBuilder;

  void setPizzaBuilder(PizzaBuilder pb) {
    _pizzaBuilder = pb;
  }

  Pizza getPizza() {
    return _pizzaBuilder.getPizza();
  }

  void makePizza() {
    _pizzaBuilder.createPizza();
    _pizzaBuilder.buildCrust();
    _pizzaBuilder.buildSauce();
    _pizzaBuilder.buildToppings();
  }
}
