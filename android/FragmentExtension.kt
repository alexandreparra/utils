import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController

fun<T> Fragment.getNavigationResult(key: String) =
    findNavController().currentBackStackEntry?.savedStateHandle?.getLiveData<T>(key)

fun<T> Fragment.setNavigationResult(key: String, value: T) = 
    findNavController().previousBackStackEntry?.savedStateHandle?.set(key, value)

