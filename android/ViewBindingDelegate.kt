import android.view.LayoutInflater
import android.view.View
import androidx.activity.ComponentActivity
import androidx.fragment.app.Fragment
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import androidx.viewbinding.ViewBinding
import kotlin.propreties.ReadOnlyProperty
import kotlin.reflect.KProperty

inline fun <reified T: ViewBinding> Fragment.viewBinding() = 
        FragmentViewBindingDelegate(T::class.java)

class FragmentViewBindingDelegate<reified T : ViewBinding>(
    private val bindingClass: T
) : ReadOnlyProperty<Fragment, T>, DefaultLifecycleObserver {
    
    private var binding: T? = null

    override fun getValue(thisRef: Fragment, property: KProperty<*>): T {
        if (binding == null) {
            binding = bindingClass
                .getMethod("bind", View::class.java)
                .invoke(null, thisRef.requireView()) as T
            thisRef.viewLifecycleOwner.lifecycle.addObserver(this)
        }

        return binding!!
    }

    override fun onDestroy(owner: LifecycleOwner) {
        super.onDestroy(owner)
        owner.lifecycle.removeObserver(this)
        binding = null
    }
}

inline fun <reified T: ViewBinding> ComponentActivity.viewBinding() = 
        ActivityViewBindingDelegate(T::class.java)

class ActivityViewBindingDelegate<reified T : ViewBinding>(
    private val bindingClass: T
) : ReadOnlyProperty<Fragment, T>, DefaultLifecycleObserver {
    
    private var binding: T? = null

    override fun getValue(thisRef: Fragment, property: KProperty<*>): T {
        if (binding == null) {
            binding = bindingClass
                .getMethod("inflate", LayoutInflater::class.java)
                .invoke(null, thisRef.requireView()) as T
            thisRef.viewLifecycleOwner.lifecycle.addObserver(this)
        }

        return binding!!
    }

    override fun onDestroy(owner: LifecycleOwner) {
        super.onDestroy(owner)
        owner.lifecycle.removeObserver(this)
        binding = null
    }
}

