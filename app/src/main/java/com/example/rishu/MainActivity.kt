package com.example.rishu
import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.view.inputmethod.InputMethodManager
import androidx.databinding.DataBindingUtil
import com.example.rishu.R
import com.example.rishu.databinding.ActivityMainBinding
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    private  lateinit var binding: ActivityMainBinding

    private var myNumbers:R = R()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this,R.layout.activity_main)

        binding.myData = myNumbers

        binding.button.setOnClickListener {
            addName(it)
        }
    }

    private fun addName(view:View){

        binding.apply {
            myNumbers.line= "${date.text.toString()} ,${month.text.toString()} , ${year.text.toString()}"



            binding.date.visibility = View.GONE
            binding.month.visibility = View.GONE
            binding.year.visibility = View.GONE
            binding.button.visibility = View.GONE

            binding.line.visibility = View.VISIBLE


            invalidateAll()
        }

        val inputMethodManager = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        inputMethodManager.hideSoftInputFromWindow(view.windowToken,0)
    }
}

