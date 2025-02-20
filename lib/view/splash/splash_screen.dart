import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/controller/splash_controller.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/finite_state.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/size_config.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/home/home_screen.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/states/no_internet_state.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashController _provider;

  @override
  void initState() {
    _provider = Provider.of<SplashController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _provider.checkInternetConnection();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Consumer<SplashController>(
          builder: (context, value, child) {
            if (value.finiteState == FiniteState.loading) {
              return Center(
                child: Image.asset(
                  'assets/logo/text_me_up_logo.png',
                  width: getProportionateScreenWidth(133),
                  height: getProportionateScreenHeight(133),
                ),
              );
            } else if (value.finiteState == FiniteState.succeed) {
              if (value.isConnectingToInternet!) {
                return const HomeScreen();
              } else {
                return NoInternetState(
                  onPressed: () => _provider.checkInternetConnection(),
                );
              }
            } else if (value.finiteState == FiniteState.failed) {
            } else {
              return const SizedBox();
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
