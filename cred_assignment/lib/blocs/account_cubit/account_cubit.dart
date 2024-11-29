import 'package:cred_assignment/blocs/account_cubit/account_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit()
      : super(AccountState(
          accounts: [],
          selectedAccount: {},
        ));

  // void setAccounts(List<dynamic> accounts) {
  //   emit(AccountState(
  //     accounts: accounts,
  //     selectedAccount: accounts.isNotEmpty ? accounts[0] : {},
  //   ));
  // }

  void changeAccount(Map<String, dynamic> newAccount) {
    emit(AccountState(
      accounts: state.accounts,
      selectedAccount: newAccount,
    ));
  }
}
