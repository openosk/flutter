// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

import 'test_widgets.dart';

void main() {
  testWidgets('simultaneously dispose a widget and end the scroll animation', (WidgetTester tester) async {
    List<Widget> textWidgets = <Widget>[];
    for (int i = 0; i < 250; i++)
      textWidgets.add(new Text('$i'));
    await tester.pumpWidget(new FlipWidget(
      left: new Block(children: textWidgets),
      right: new Container()
    ));

    await tester.fling(find.byType(Scrollable), new Offset(0.0, -200.0), 1000.0);
    await tester.pump();

    FlipWidgetState flipWidget = tester.state(find.byType(FlipWidget));
    flipWidget.flip();
    await tester.pump(new Duration(hours: 5));
  });
}
