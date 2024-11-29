import 'package:bloc/bloc.dart';


class AccountState {
 final String bankName;
 final String accountNumber;


 AccountState({required this.bankName, required this.accountNumber});
}


class AccountCubit extends Cubit<AccountState> {
 AccountCubit()
     : super(AccountState(
         bankName: "Paytm Payments Bank",
         accountNumber: "919935670475",
       ));


 void changeAccount(String bankName, String accountNumber) {
   emit(AccountState(bankName: bankName, accountNumber: accountNumber));
 }
}
