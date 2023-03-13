/*
 * Copyright (C) 2023 The Android Open Source Project
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

package android.hardware.audio.effect;

import android.hardware.audio.effect.Range;
import android.hardware.audio.effect.VendorExtension;

/**
 * Automatic Gain Control (AGC) is an audio pre-processor which automatically normalizes the output
 * of the captured signal by boosting or lowering input from the microphone to match a preset level
 * so that the output signal level is virtually constant. AGC can be used by applications where the
 * input signal dynamic range is not important but where a constant strong capture level is desired.
 *
 * All parameters defined in union AutomaticGainControlV1 must be gettable and settable. The
 * capabilities defined in AutomaticGainControlV1.Capability can only acquired with
 * IEffect.getDescriptor() and not settable.
 */
@VintfStability
union AutomaticGainControlV1 {
    /**
     * Effect parameter tag to identify the parameters for getParameter().
     */
    @VintfStability
    union Id {
        int vendorExtensionTag;
        AutomaticGainControlV1.Tag commonTag;
    }

    /**
     * Vendor AutomaticGainControlV1 implementation definition for additional parameters.
     */
    VendorExtension vendor;

    /**
     * Capability supported by AutomaticGainControlV1 implementation.
     */
    @VintfStability
    parcelable Capability {
        /**
         * AutomaticGainControlV1 capability extension, vendor can use this extension in case
         * existing capability definition not enough.
         */
        ParcelableHolder extension;
        /**
         * Supported range for parameters.
         */
        Range[] ranges;
    }

    /**
     * Target peak level (or envelope) of the AGC implementation in dBFs (dB relative to full
     * scale).
     * Must be in range of AutomaticGainControlV1.Capability.ranges with targetPeakLevelDbFs tag.
     */
    int targetPeakLevelDbFs;
    /*
     * Sets the maximum gain the digital compression stage may apply, in dB. A higher number
     * corresponds to greater compression, while a value of 0 will leave the signal uncompressed.
     * Must be in range of AutomaticGainControlV1.Capability.ranges with maxCompressionGainDb tag.
     */
    int maxCompressionGainDb;
    /**
     * Enable or disable limiter.
     * When enabled, the compression stage will hard limit the signal to the target level.
     * Otherwise, the signal will be compressed but not limited above the target level.
     */
    boolean enableLimiter;
}
