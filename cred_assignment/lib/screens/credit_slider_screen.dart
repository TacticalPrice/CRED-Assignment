import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:cred_assignment/blocs/api_data_bloc/api_data_bloc.dart';
import 'package:cred_assignment/blocs/api_data_bloc/api_data_state.dart';
import 'package:cred_assignment/blocs/slider_cubit.dart';

class CreditSliderScreen extends StatefulWidget {
  @override
  State<CreditSliderScreen> createState() => _CreditSliderScreenState();
}

class _CreditSliderScreenState extends State<CreditSliderScreen> {
  final double maxAmount = 487891;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SliderCubit()),
      ],
      child: BlocBuilder<TestMintCubit, TestMintState>(
        builder: (context, state) {
          if (state is TestMintLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TestMintSuccess) {
            final data = state.data;
            final title = data['items']?[0]?['open_state']?['body']?['title'] ?? "How much do you need?";
            final subtitle = data['items']?[0]?['open_state']?['body']?['subtitle'];
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    BlocBuilder<SliderCubit, double>(
                      builder: (context, selectedAmount) {
                        return SleekCircularSlider(
                          innerWidget: (value) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '₹ ${value.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  data['items']?[0]?['open_state']?['body']?['card']['description'] ?? "hello",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            );
                          },
                          appearance: CircularSliderAppearance(
                            size: 300,
                            angleRange: 360,
                            startAngle: 270,
                            customWidths: CustomSliderWidths(
                              progressBarWidth: 12,
                              handlerSize: 12,
                            ),
                            customColors: CustomSliderColors(
                              progressBarColor: Colors.orangeAccent,
                              trackColor: Colors.orange.shade100,
                              dotColor: Colors.orange,
                            ),
                          ),
                          min: 500,
                          max: maxAmount,
                          initialValue: selectedAmount,
                          onChange: (double value) {
                            context.read<SliderCubit>().updateAmount(value);
                          },
                        );
                      },
                    ),
                    SizedBox(height: 40),
                    Text(
                      data['items']?[0]?['open_state']?['footer'] ?? "hello",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is TestMintError) {
            return Center(
              child: Text(
                "Failed to load data. Please try again.",
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Center(child: Text("Unknown state."));
          }
        },
      ),
    );
  }
}
