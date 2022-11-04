import 'package:air_line_task/features/presentation/controllers/bloc/air_line_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utilies/values_manger.dart';
import '../controllers/bloc/air_line_state.dart';
import '../widgets/mainWidget.dart';
import '../widgets/loadingWidget.dart';

class AirLineList extends StatelessWidget {

  const AirLineList({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AirLineBloc, AirLineState>(
      builder: (context, state) {
        if (state is AirLineLoading)
          {
            return const LoadingWidget();
          }
       else if(state is AirLineLoaded)
          {
            return  MainWidget(airLine: state.airline,);
          }
        else if (state is AirLineError)
          {
            return  SizedBox(
              height: AppSize.s400,
                child: Center(child: Text(state.message),));

          }
        else
          {
            return const SizedBox();
          }



      },
    );}




}


