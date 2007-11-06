/*
 * Copyright 2007 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.zxing;

/**
 * Encapsulates a type of hint that a caller may pass to a barcode reader to help it
 * more quickly or accurately decode it. It is up to implementations to decide what,
 * if anything, to do with the information that is supplied.
 *
 * @author srowen@google.com (Sean Owen), dswitkin@google.com (Daniel Switkin)
 * @see Reader#decode(MonochromeBitmapSource, java.util.Hashtable)
 */
public final class DecodeHintType {

  // No, we can't use an enum here. J2ME doesn't support it.

  /** Unspecified, application-specific hint. */
  public static final DecodeHintType OTHER = new DecodeHintType();
  /** Image is a pure monochrome image of a barcode. */
  public static final DecodeHintType PURE_BARCODE = new DecodeHintType();
  /**
   * Image is known to be of one of a few possible formats.
   * Maps to {@link java.util.Collection} of {@link BarcodeFormat}s.
   */
  public static final DecodeHintType POSSIBLE_FORMATS = new DecodeHintType();

  private DecodeHintType() {}

}
