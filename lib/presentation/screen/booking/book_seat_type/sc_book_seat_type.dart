import 'package:find_seat/model/entity/entity.dart';
import 'package:find_seat/model/repo/repo.dart';
import 'package:find_seat/presentation/common_widgets/barrel_common_widgets.dart';
import 'package:find_seat/presentation/router.dart';
import 'package:find_seat/presentation/screen/booking/barrel_booking.dart';
import 'package:find_seat/presentation/screen/booking/book_seat_type/barrel_book_seat_type.dart';
import 'package:find_seat/presentation/screen/booking/book_seat_type/bloc/bloc.dart';
import 'package:find_seat/utils/my_const/my_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookSeatTypeScreen extends StatefulWidget {
  @override
  _BookSeatTypeScreenState createState() => _BookSeatTypeScreenState();
}

class _BookSeatTypeScreenState extends State<BookSeatTypeScreen> {
  ItemCineTimeSlot _itemCineTimeSlot;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<BookSeatTypeBloc>(
        create: (context) => BookSeatTypeBloc(
          sessionRepository: RepositoryProvider.of<SessionRepository>(context),
        )..add(
            OpenScreen(),
          ),
        child: BlocConsumer<BookSeatTypeBloc, BookSeatTypeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedData) {
              BookTimeSlot bookTimeSlot = state.bookTimeSlot;
              int selectedIndex =
                  bookTimeSlot.timeSlots.indexOf(state.selectedTimeSlot);
              String showName = state.show.name;

              _itemCineTimeSlot =
                  ItemCineTimeSlot.fromBookTimeSlot(bookTimeSlot: bookTimeSlot);

              return Scaffold(
                body: Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            WidgetToolbar(
                                title: showName, actions: Container()),
                            WidgetCineTimeSlot.selected(
                              item: _itemCineTimeSlot,
                              selectedIndex: selectedIndex,
                              showCineName: true,
                              showCineDot: false,
                            ),
                            WidgetSpacer(height: 14),
                            WidgetHowManySeats(),
                          ],
                        ),
                      ),
                      _buildBtnSelectSeat(),
                    ],
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  _buildBtnSelectSeat() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 54,
        child: FlatButton(
          color: COLOR_CONST.DEFAULT,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Select seats', style: FONT_CONST.MEDIUM_WHITE_16),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, Router.BOOK_SEAT_SLOT);
          },
        ),
      ),
    );
  }
}
