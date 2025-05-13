import 'package:rxdart/rxdart.dart';

class Order {
  final Map<String, int> items;
  final double totalPrice;
  final bool isDiscountApplied;
  final DateTime date;
  final String id;

  Order({
    required this.items,
    required this.totalPrice,
    required this.isDiscountApplied,
    required this.date,
    required this.id,
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

  void addOrder(
      Map<String, int> cartItems, double total, bool isDiscountApplied) {
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      items: Map<String, int>.from(cartItems),
      totalPrice: total,
      isDiscountApplied: isDiscountApplied,
    );

    final updatedOrders = [...currentOrders, newOrder];
    _ordersSubject.add(updatedOrders);
  }

  void clearOrders() {
    if (_ordersSubject.isClosed) return;
    _ordersSubject.add([]);
  }

  void dispose() {
    _ordersSubject.close();
  }
}

final orderManager = OrderManager();
