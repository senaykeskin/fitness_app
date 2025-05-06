import 'package:rxdart/rxdart.dart';

class Order {
  final String id;
  final DateTime date;
  final Map<String, int> items;
  final double total;

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
  });
}

class OrderManager {
  static final OrderManager _instance = OrderManager._internal();
  factory OrderManager() => _instance;
  OrderManager._internal();

  final BehaviorSubject<List<Order>> _ordersSubject =
      BehaviorSubject<List<Order>>.seeded([]);

  Stream<List<Order>> get ordersStream => _ordersSubject.stream;
  List<Order> get currentOrders => _ordersSubject.value;

  void addOrder(Map<String, int> cartItems, double total) {
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      items: Map<String, int>.from(cartItems),
      total: total,
    );

    final updated = [...currentOrders, newOrder];
    _ordersSubject.add(updated);
  }

  void clearOrders() {
    _ordersSubject.add([]);
  }

  void dispose() {
    _ordersSubject.close();
  }
}

final orderManager = OrderManager();
