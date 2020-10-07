import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter.dart';
import '../providers/labels.dart';
import '../providers/transactions.dart';
import '../widgets/balance_cards_view.dart';
import '../widgets/dashboard_list_header.dart';
import '../widgets/dashboard_screen_fab.dart';
import '../widgets/transactions_list.dart';

// This screen is a tab under home_screen.
class DashboardScreen extends StatelessWidget {
  SliverList buildSliverBalanceCard() {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          BalanceCardsView(),
        ],
      ),
    );
  }

  Future<void> fetchAndSetData(BuildContext context) async {
    Provider.of<Transactions>(context, listen: false).fetchAndSetTransactions();
    Provider.of<Labels>(context, listen: false).fetchAndSetLabels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DashboardScreenFAB(),
      backgroundColor:Colors.white,
      body: ChangeNotifierProvider(
        create: (_) => Filter(),
        // Fetch and set data in this screen because it is the first screen the user sees.
        child: FutureBuilder(
          future: fetchAndSetData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomScrollView(
              slivers: <Widget>[
                buildSliverBalanceCard(),
                DashboardListHeader(),
                TransactionsList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
