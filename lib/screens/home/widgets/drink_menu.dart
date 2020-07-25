import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:waterlog/actions/history_actions.dart';
import 'package:waterlog/managers/database/drink_history.dart';
import 'package:waterlog/model/app_state.dart';
import 'package:waterlog/model/water/Drink.dart';
import 'package:waterlog/widgets/circle_menu/circle_menu.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

typedef OnDrinkAddedCallback = Function(Drink drink);

class DrinkMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnDrinkAddedCallback>(
      converter: (store) {
        return (drink) {
          var entry = DrinkHistoryEntry();
          entry.amount = drink.amount;
          entry.date = DateTime.now().millisecondsSinceEpoch;
          store.dispatch(AddDrinkToHistoryAction(entry));
        };
      },
      builder: (context, callback) {
        return AnchoredRadialMenu(
            menu: Menu(items: [
              RadialMenuItem(
                  text: '200',
                  onPressed: () {
                    callback(Drink.small());
                  }),
              RadialMenuItem(
                  text: '250',
                  onPressed: () {
                    callback(Drink.medium());
                  }),
              RadialMenuItem(
                  text: '300',
                  onPressed: () {
                    callback(Drink.big());
                  }),
            ]),
            child: IconButton(
              icon: Icon(
                EvaIcons.chevronDown,
              ),
              onPressed: () {},
            ));
      },
    );
  }
}
