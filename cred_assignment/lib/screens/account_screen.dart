import 'package:cred_assignment/blocs/account_cubit/account_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cred_assignment/blocs/account_cubit/account_cubit.dart';
import 'package:cred_assignment/blocs/api_data_bloc/api_data_bloc.dart';
import 'package:cred_assignment/blocs/api_data_bloc/api_data_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit(),
      child: BlocBuilder<DataCubit, ApiDataState>(
        builder: (context, state) {
          if (state is ApiDataLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ApiDataSuccess) {
            final List<dynamic> accounts = state.data['items'][2]['open_state']['body']['items'];

            return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left : 16.0 , top: 8),
                      child: Text(
                        'Choose Your Bank Account',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<AccountCubit, AccountState>(
                      builder: (context, state) {
                        return Column(
                          children: List.generate(
                             accounts.length, (index) {
                            final account = accounts[index];
                            return GestureDetector(
                              onTap: () {
                                context.read<AccountCubit>().changeAccount(account);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2C2C2E),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: state.selectedAccount == account
                                        ? Colors.blueAccent
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.account_balance_wallet_outlined,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          account['title'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          account['subtitle'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Radio(
                                      value: true,
                                      groupValue: true,
                                      onChanged: (_) {},
                                      activeColor: Colors.blueAccent,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // final selectedAccount = context.read<AccountCubit>().state.selectedAccount;
                          // if (selectedAccount.isNotEmpty) {
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3A3A3C),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Change account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Unexpected Error',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
