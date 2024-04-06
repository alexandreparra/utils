import android.content.Context
import androidx.biometric.BiometricManager

fun Context.getDeviceBiometricStatus(): Int = BiometricManager
    .from(this)
    .canAuthenticate(
        BiometricManager.Authenticators.BIOMETRIC_WEAK or
        BiometricManager.Authenticators.BIOMETRIC_STRONG
    )

fun Context.deviceHasBiometric() =
    getDeviceBiometricStatus() == BiometricManager.BIOMETRIC_SUCCESS

