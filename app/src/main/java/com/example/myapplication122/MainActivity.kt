package com.example.myapplication122
import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.view.inputmethod.InputMethodManager
import androidx.databinding.DataBindingUtil
import com.example.myapplication122.sam
import com.example.myapplication122.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private  lateinit var binding: ActivityMainBinding

    private var myNumbers:sam = sam()

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
            myNumbers.sentence = "${name.text.toString()} ,who is ${age.text.toString()} yrs is a ${occupation.text.toString()}"



            binding.name.visibility = View.GONE
            binding.age.visibility = View.GONE
            binding.occupation.visibility = View.GONE
            binding.button.visibility = View.GONE

            binding.sentence.visibility = View.VISIBLE


            invalidateAll()
        }

        val inputMethodManager = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        inputMethodManager.hideSoftInputFromWindow(view.windowToken,0)
    }
}