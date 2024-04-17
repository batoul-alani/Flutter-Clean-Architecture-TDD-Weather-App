import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:weather_app/domain/entities/location.dart';
import 'package:weather_app/presentition/bloc/location_bloc.dart';
import 'package:weather_app/presentition/bloc/location_event.dart';
import 'package:weather_app/presentition/bloc/location_state.dart';
import 'package:weather_app/presentition/pages/location_page.dart';

class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

void main() {
  // we need to define the main method
  late MockLocationBloc mockLocationBloc;
  setUp(() {
    mockLocationBloc = MockLocationBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<LocationBloc>(
      create: (_) => mockLocationBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets("text field should trigger state to change from empty to loading",
      (widgetTester) async {
    // arrange
    // we need to make the state of the bloc in initial state
    // using mocktail for this when
    when(() => mockLocationBloc.state).thenReturn(LocationEmpty());

    // act
    // we need to define the widget but we need to define it with material app and bloc provider
    await widgetTester.pumpWidget(makeTestableWidget(const LocationPage()));
    var textField = find.byType(TextField);

    // assert
    expect(textField, findsOneWidget);

    // to type on text field
    await widgetTester.enterText(textField, "london");

    // to refresh the frame
    await widgetTester.pump();
    expect(find.text("london"), findsOneWidget);
  });

  testWidgets("should show progress indicator when state is loading",
      (widgetTester) async {
    // arrange

    when(() => mockLocationBloc.state).thenReturn(LocationLoading());

    // act
    await widgetTester.pumpWidget(makeTestableWidget(const LocationPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  const testLocationEntity = LocationEntity(
      name: "London",
      region: "City of London, Greater London",
      country: "United Kingdom",
      lat: 51.52,
      lon: -0.11,
      tzId: "Europe/London",
      localtimeEpoch: 1713302014,
      localtime: "2024-04-16 22:13");

  testWidgets(
      "should show widget contain location data when state is location loaded",
      (widgetTester) async {
    // arrange

    when(() => mockLocationBloc.state)
        .thenReturn(const LocationLoaded(testLocationEntity));

    // act
    await widgetTester.pumpWidget(makeTestableWidget(const LocationPage()));

    expect(find.byKey(const Key("weather_data")), findsOneWidget);
  });
}
