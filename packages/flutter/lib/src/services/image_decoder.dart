// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui show Image, decodeImageFromDataPipe, decodeImageFromList;

import 'package:mojo/core.dart' show MojoDataPipeConsumer;

/// Creates an image from a stream of bytes.
///
/// This function drains the given data pipe and attempts to interpret the bytes
/// in the data pipe as an image. If successful, the returned [Future] resolves
/// to the decoded image. Otherwise, the [Future] resolves to [null].
Future<ui.Image> decodeImageFromDataPipe(MojoDataPipeConsumer consumerHandle) {
  assert(consumerHandle != null);
  assert(consumerHandle.handle != null);
  assert(consumerHandle.handle.h != null);
  Completer<ui.Image> completer = new Completer<ui.Image>();
  ui.decodeImageFromDataPipe(consumerHandle.handle.h, (ui.Image image) {
    completer.complete(image);
  });
  return completer.future;
}

/// Creates an image from a list of bytes.
///
/// This function attempts to interpret the given bytes an image. If successful,
/// the returned [Future] resolves to the decoded image. Otherwise, the [Future]
/// resolves to [null].
Future<ui.Image> decodeImageFromList(Uint8List list) {
  Completer<ui.Image> completer = new Completer<ui.Image>();
  ui.decodeImageFromList(list, (ui.Image image) {
    completer.complete(image);
  });
  return completer.future;
}
