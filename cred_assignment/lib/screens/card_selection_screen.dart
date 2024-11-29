import 'package:cred_assignment/blocs/api_data_bloc/api_data_bloc.dart';
import 'package:cred_assignment/blocs/api_data_bloc/api_data_state.dart';
import 'package:cred_assignment/blocs/card_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardSelectionScreen extends StatefulWidget {
  @override
  State<CardSelectionScreen> createState() => _CardSelectionScreenState();
}

class _CardSelectionScreenState extends State<CardSelectionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CardSelectionCubit(),
      child: BlocBuilder<TestMintCubit, TestMintState>(
        builder: (context, state) {
          if (state is TestMintLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TestMintSuccess) {
            final data = state.data['items'][1]['open_state'];
            return Center(
              //color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left : 20.0 , top: 12),
                    child: Text(
                      data['body']['title'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      data['body']['subtitle'],
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  BlocBuilder<CardSelectionCubit, int>(
                    builder: (context, selectedIndex) {
                      final list = data['body']['items'];
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(list.length, (index) {
                            final plan = list[index];
                            final isSelected = selectedIndex == index;

                            return GestureDetector(
                              onTap: () {
                                context.read<CardSelectionCubit>().selectCard(index);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                padding: EdgeInsets.all(16.0),
                                height: isSelected ? 200 : 160,
                                width: isSelected ? 220 : 200,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.brown[700]
                                      : Colors.grey[850],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.brown.withOpacity(0.5),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                          )
                                        ]
                                      : [],
                                  border: isSelected
                                      ? Border.all(color: Colors.white, width: 2)
                                      : null,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (plan.containsKey('tag'))
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          plan['tag']!,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    SizedBox(height: 8),
                                    Text(
                                      plan['emi']!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      plan['duration']!,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      plan['subtitle'],
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Handle "Create your own plan" action
                      },
                      child: Text(
                        "Create your own plan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Unknown State',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
