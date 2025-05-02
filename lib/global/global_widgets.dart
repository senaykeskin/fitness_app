import 'package:fitness_app/global/theme_notifier.dart';
import 'package:fitness_app/module/auth/login/index.dart';
import 'package:fitness_app/module/products/product_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../module/login_history/login_history_list.dart';
import '../module/membership_info/index.dart';
import '../module/shopping_cart/shopping_cart_manager.dart';
import '../module/streak_screen/streak_list.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    required this.isPassword,
    required this.title,
    required this.hintText,
    required this.isEmail,
  });

  final bool isPassword;
  final String title;
  final String hintText;
  final bool isEmail;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: top20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style:
                kAxiformaRegular17.copyWith(fontSize: 15, color: Colors.black),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: border15,
            ),
            margin: top10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    style: kAxiformaRegular17.copyWith(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textInputAction: TextInputAction.next,
                    obscureText:
                        widget.isPassword ? !_isPasswordVisible : false,
                    autofillHints:
                        widget.isEmail ? [AutofillHints.email] : null,
                    keyboardType: widget.isEmail
                        ? TextInputType.emailAddress
                        : TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: border25,
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: border25,
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: border25,
                        borderSide: BorderSide(width: 2, color: Colors.green),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: horizontal20 + vertical15,
                      hintText: widget.hintText,
                      hintStyle: kAxiformaRegular17.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      suffixIcon: widget.isPassword
                          ? IconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

ElevatedButton signupAndLoginButton(
    BuildContext context, String text, VoidCallback navigation) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: GlobalConfig.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: border30),
          fixedSize: Size(W(context), 50)),
      onPressed: navigation,
      child: Text(
        text,
        style: kAxiformaRegular17.copyWith(color: Colors.white),
      ));
}

class RouteAnimation {
  static Route createRoute(Widget routePage, double dx, double dy,
      {Object? arguments}) {
    return PageRouteBuilder(
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionDuration: const Duration(milliseconds: 700),
      settings: RouteSettings(arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => routePage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(dx, dy);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}

Widget buildInfoRow(String title, String content) {
  return Padding(
    padding: vertical8,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: kAxiformaRegular17.copyWith(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        Expanded(
          child: Text(
            content,
            style: kAxiformaRegular17.copyWith(
                fontSize: 14, color: Colors.black54),
          ),
        ),
      ],
    ),
  );
}

PreferredSizeWidget customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title,
        style: kAxiforma18.copyWith(color: Colors.white, fontSize: 17)),
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    actions: [
      IconButton(
        icon: Icon(
          Icons.home,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            RouteAnimation.createRoute(
              CTabbar(),
              -1.0,
              0.0,
            ),
            (route) => false,
          );
        },
      ),
    ],
  );
}

Future<dynamic> productDetailBottomSheet(
    BuildContext context, ProductModel item, BuildContext rootContext) {
  final BehaviorSubject<int> quantitySubject = BehaviorSubject<int>.seeded(1);

  return showModalBottomSheet(
    isDismissible: false,
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: verticalTop20,
    ),
    builder: (context) {
      return Padding(
        padding: bottom10 + horizontal10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.highlight_remove_rounded,
                    size: 30,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    quantitySubject.close();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  item.image,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: kAxiforma18.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        item.description,
                        style: kAxiformaRegular17.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            StreamBuilder<int>(
              stream: quantitySubject.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                int quantity = snapshot.data!;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(zero),
                          ),
                          icon: Icon(
                            Icons.remove_circle_outline_outlined,
                            color: (quantity == 1)
                                ? Colors.grey.shade400
                                : GlobalConfig.primaryColor,
                            size: 30,
                          ),
                          onPressed: (quantity == 1)
                              ? null
                              : () {
                                  quantitySubject.add(quantity - 1);
                                },
                        ),
                        Text(
                          "$quantity",
                          style: kAxiformaRegular17.copyWith(fontSize: 16),
                        ),
                        IconButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(zero),
                          ),
                          icon: Icon(
                            Icons.add_circle_outline_rounded,
                            color: (quantity == 3)
                                ? Colors.grey.shade400
                                : GlobalConfig.primaryColor,
                            size: 30,
                          ),
                          onPressed: (quantity == 3)
                              ? null
                              : () {
                                  quantitySubject.add(quantity + 1);
                                },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cartManager.addToCart(item.id, quantity: quantity);

                        quantitySubject.close();
                        Navigator.pop(context);

                        Future.delayed(Duration(milliseconds: 200), () {
                          showSnackBar(rootContext, "Ürün sepete eklendi.");
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalConfig.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: border10,
                        ),
                      ),
                      child: Text(
                        "Sepete Ekle",
                        style: kAxiformaRegular17.copyWith(
                            fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

class InfoItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const InfoItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(subtitle,
            style: kAxiformaRegular17.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
        const SizedBox(height: 5),
        Text(title,
            style: kAxiformaRegular17.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ],
    );
  }
}

Widget profileTextInput(String label, TextEditingController controller) {
  return Padding(
    padding: vertical8,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: horizontal15 + vertical15,
        labelText: label,
        labelStyle: kAxiformaRegular17.copyWith(
          fontSize: 16,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: border15,
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: border15,
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: border15,
        ),
      ),
    ),
  );
}

Widget profileGenderDropdown({
  required String label,
  required String selectedGender,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
}) {
  return Padding(
    padding: vertical8,
    child: InputDecorator(
      decoration: InputDecoration(
        contentPadding: horizontal15 + vertical5,
        labelText: label,
        labelStyle:
            kAxiformaRegular17.copyWith(fontSize: 16, color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: border15,
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: border15,
          dropdownColor: Colors.white,
          menuWidth: W(context) * 0.5,
          style: kAxiformaRegular17.copyWith(fontSize: 14, color: Colors.black),
          value: selectedGender,
          items: genderList
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    ),
  );
}

class SettingsButton extends StatelessWidget {
  final IconData leadingIcon;
  final Color iconColor;
  final String text;
  final void Function() onPress;

  const SettingsButton({
    super.key,
    required this.leadingIcon,
    required this.iconColor,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: top10,
      decoration: BoxDecoration(
          borderRadius: border15,
          border: Border.all(width: 1, color: Colors.black)),
      child: ListTile(
        contentPadding: horizontal10,
        leading: Icon(leadingIcon, size: 30, color: iconColor),
        trailing: Icon(
          Icons.chevron_right_outlined,
          size: 25,
          color: Colors.black,
        ),
        title: Text(
          text,
          textAlign: TextAlign.left,
          style: kAxiformaRegular17,
        ),
        onTap: onPress,
      ),
    );
  }
}

Widget globalApp(Widget child) {
  return ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: Builder(
      builder: (context) {
        final themeNotifier = Provider.of<ThemeNotifier>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.currentTheme,
          home: child,
        );
      },
    ),
  );
}

Widget infoTile(String label, String value) {
  return Container(
    padding: vertical15 + horizontal20,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: border15,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: kAxiformaRegular17.copyWith(fontSize: 16)),
        Text(value,
            style: kAxiformaRegular17.copyWith(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget entryCard(GymEntryModel entry) {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: bottom15,
    elevation: 2,
    child: Padding(
      padding: all15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.gymName, style: kAxiforma18.copyWith(fontSize: 17)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 18, color: Colors.red.shade700),
              const SizedBox(width: 6),
              Expanded(
                child: Text(entry.location,
                    style: kAxiformaRegular17.copyWith(fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, size: 18, color: Colors.black),
              const SizedBox(width: 6),
              Text(
                formatDateTimeHorizontal(entry.entryDateTime),
                style: kAxiformaRegular17.copyWith(fontSize: 13),
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.login, size: 18, color: Colors.black),
              const SizedBox(width: 6),
              Text("Yöntem: ${entry.entryMethod}",
                  style: kAxiformaRegular17.copyWith(fontSize: 13)),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget sssContainers(BuildContext context, String title, String content) {
  return Column(
    children: [
      Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          onExpansionChanged: (bool expanded) {
            FocusScope.of(context).unfocus();
          },
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
          tilePadding: vertical5,
          childrenPadding: vertical5,
          title: Text(
            title,
            style: kAxiformaRegular17.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                content,
                style: kAxiformaRegular17.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
      Divider(
        thickness: 0.4,
        height: 1,
        color: Colors.grey.shade400,
      ),
    ],
  );
}

Widget feedbackForm(BuildContext context) {
  return Column(
    children: [
      TextField(
        style: kAxiformaRegular17.copyWith(fontSize: 14),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: border15,
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: border15,
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: border15,
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        maxLines: 5,
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () {
          showSnackBar(context, "Geri bildiriminiz gönderildi");
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(W(context), 55),
          backgroundColor: GlobalConfig.primaryColor,
          padding: vertical10,
          shape: RoundedRectangleBorder(
            borderRadius: border10,
          ),
        ),
        child: Text(
          "Gönder",
          style: kAxiformaRegular17.copyWith(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 10)
    ],
  );
}

Widget aboutUsTitle(String title) {
  return Text(
    title,
    style: kAxiformaRegular17.copyWith(fontWeight: FontWeight.bold),
  );
}

Widget aboutUsText(String text) {
  return Padding(
    padding: top10,
    child: Text(
      text,
      style: kAxiformaRegular17.copyWith(fontSize: 14),
    ),
  );
}

Widget homeScreenInfoCard({
  required String title,
  required String value,
  required Widget leading,
  IconData? navigationIcon,
  VoidCallback? onTap,
}) {
  final card = GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: all5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade200.withAlpha(20),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: border20,
        border: Border.all(color: Colors.black38, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: leading,
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: kAxiformaRegular17.copyWith(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: kAxiforma18.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    ),
  );
  if (onTap != null) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        card,
        Positioned(
          top: 10,
          right: 10,
          child:
              Icon(navigationIcon, color: GlobalConfig.primaryColor, size: 25),
        ),
      ],
    );
  }
  return card;
}

class WeeklyGymCalendar extends StatelessWidget {
  const WeeklyGymCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final weekDays =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Bu Hafta Salon Ziyareti",
            style: kAxiforma18.copyWith(fontSize: 16)),
        const SizedBox(height: 10),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays.map((day) {
              final dayLabel = DateFormat.E('tr_TR').format(day);
              final dayNumber = day.day.toString();

              final isToday = DateUtils.isSameDay(day, today);
              final isVisited = pastGymEntries.any(
                  (entry) => DateUtils.isSameDay(entry.entryDateTime, day));

              final dayColor =
                  isVisited ? GlobalConfig.primaryColor : Colors.grey.shade400;

              return Container(
                padding: horizontal5,
                decoration: isToday
                    ? BoxDecoration(
                        border: Border.all(
                            color: GlobalConfig.primaryColor, width: 1),
                        borderRadius: border10,
                      )
                    : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayLabel,
                      style: kAxiformaRegular17.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: dayColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dayNumber,
                      style: kAxiformaRegular17.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: dayColor),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

Widget waterAmountButton(int amount, String desc) {
  return StreamBuilder<Map<int, int>>(
    stream: waterSubject.stream,
    builder: (context, snapshot) {
      return Padding(
        padding: bottom10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle_outline_outlined,
                  color: GlobalConfig.primaryColor, size: 25),
              onPressed: () => toggleAmount(amount, false),
            ),
            Container(
              width: W(context) * 0.65,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: border15,
                border:
                    Border.all(color: GlobalConfig.primaryColor, width: 1.5),
              ),
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$amount ml",
                      style: kAxiformaRegular17.copyWith(
                          fontSize: 16, height: 1.2),
                    ),
                    SizedBox(height: 5),
                    Text(desc,
                        style: kAxiformaRegular17.copyWith(fontSize: 13)),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline_rounded,
                  color: GlobalConfig.primaryColor, size: 25),
              onPressed: () => toggleAmount(amount, true),
            ),
          ],
        ),
      );
    },
  );
}

Widget streakContainer(BuildContext context, List<Streak> streaks) {
  return Column(
    children: List.generate(streaks.length, (index) {
      final streak = streaks[index];
      final isRight = index % 2 == 0;

      return Align(
        alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: vertical10,
          padding: all15,
          width: W(context) * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: border20,
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(90),
                blurRadius: 6,
                offset: const Offset(2, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.local_fire_department_rounded,
                      color: Colors.red, size: 25),
                  SizedBox(width: 7),
                  Text(
                    "${streak.days} gün",
                    style: kAxiformaRegular17.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 25,
                    color: Colors.grey.shade800,
                  ),
                  SizedBox(width: 7),
                  Text(
                    "${formatDateTimeWithoutHour(streak.start)} - ${formatDateTimeWithoutHour(streak.end)}",
                    style: kAxiformaRegular17.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }),
  );
}

Widget streakInfoCard(String text, String value, Color color) {
  return Container(
    width: 160,
    padding: all15,
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: border20,
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Text(value, style: kAxiforma18.copyWith(color: color)),
        const SizedBox(height: 4),
        Text(text,
            style: kAxiformaRegular17.copyWith(fontSize: 15, color: color)),
      ],
    ),
  );
}

Widget barChart(List<Streak> streaks) {
  final maxDays = streaks.map((s) => s.days).reduce((a, b) => a > b ? a : b);
  final maxY = (maxDays * 1.2).ceilToDouble();

  return Column(
    children: [
      Text("Seri Süreleri", style: kAxiforma18.copyWith(fontSize: 17)),
      const SizedBox(height: 12),
      SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: false),
            alignment: BarChartAlignment.spaceAround,
            maxY: maxY,
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 38,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= streaks.length) return const SizedBox();
                    final date = DateFormat.Md().format(streaks[index].start);
                    return Text(date,
                        style: kAxiformaRegular17.copyWith(fontSize: 10));
                  },
                  interval: 1,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 42,
                  interval: (maxY / 5).ceilToDouble(),
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: kAxiformaRegular17.copyWith(fontSize: 12),
                      textAlign: TextAlign.left,
                    );
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(streaks.length, (index) {
              return BarChartGroupData(x: index, barRods: [
                BarChartRodData(
                  toY: streaks[index].days.toDouble(),
                  width: 18,
                  borderRadius: border10,
                  color: GlobalConfig.primaryColor,
                )
              ]);
            }),
          ),
        ),
      ),
    ],
  );
}

Widget messageContainer(BuildContext context, Map<String, String> message) {
  final isUser = message["sender"] == "user";

  BorderRadius messageBorderRadius = isUser
      ? BorderRadius.only(
          topLeft: radius25,
          topRight: radius25,
          bottomLeft: radius25,
        )
      : BorderRadius.only(
          topRight: radius25,
          topLeft: radius25,
          bottomRight: radius25,
        );

  return Padding(
    padding: vertical5,
    child: Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: horizontal15 + vertical15,
            decoration: BoxDecoration(
              color: isUser ? GlobalConfig.primaryColor : Colors.grey.shade300,
              borderRadius: messageBorderRadius,
            ),
            constraints: BoxConstraints(
              maxWidth: W(context) * 0.75,
            ),
            child: Text(
              message["text"] ?? "",
              style: kAxiformaRegular17.copyWith(
                  fontSize: 15, color: isUser ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}

class VideoContainer extends StatelessWidget {
  const VideoContainer({
    super.key,
    required this.item,
  });

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: GlobalConfig.primaryColor,
            fixedSize: Size(W(context), H(context) * 0.15),
            padding: horizontal5,
            shape: RoundedRectangleBorder(
              borderRadius: border15,
            ),
            elevation: 2),
        onPressed: () {},
        child: Row(
          children: [
            Image.asset('assets/images/video.png', width: W(context) * 0.3),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: W(context) * 0.57,
                    child: Text(
                      item['name'],
                      style: kAxiformaRegular17.copyWith(
                          color: Colors.black, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: Colors.grey,
                      size: 23,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      item['time'],
                      style: kAxiformaRegular17.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}

Widget notificationCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required BehaviorSubject<bool> subject,
}) {
  return StreamBuilder<bool>(
    stream: subject.stream,
    initialData: subject.value,
    builder: (context, snapshot) {
      final value = snapshot.data ?? false;
      return Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: border15),
        child: ListTile(
          contentPadding: all10,
          leading: Icon(icon, color: Colors.black),
          title: Text(
            title,
            style: kAxiforma18.copyWith(fontSize: 15),
          ),
          subtitle: Text(
            subtitle,
            style: kAxiformaRegular17.copyWith(fontSize: 13),
          ),
          trailing: Switch(
            value: value,
            onChanged: subject.add,
            thumbColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? GlobalConfig.primaryColor
                  : Colors.grey;
            }),
            trackColor: WidgetStateProperty.all(Colors.white),
            trackOutlineColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? GlobalConfig.primaryColor
                  : Colors.grey;
            }),
            trackOutlineWidth: WidgetStateProperty.all(2),
          ),
        ),
      );
    },
  );
}
