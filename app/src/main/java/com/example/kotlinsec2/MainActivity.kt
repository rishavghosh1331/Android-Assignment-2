package com.example.kotlinsec2

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.view.inputmethod.InputMethodManager
import androidx.databinding.DataBindingUtil
import com.example.kotlinsec2.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private  lateinit var binding: ActivityMainBinding

    private var myNumbers:MyNumbers = MyNumbers()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this,R.layout.activity_main)

        binding.myData = myNumbers

        binding.addOne.setOnClickListener {
            addName(it)
        }
    }

    private fun addName(view:View){

        binding.apply {
            myNumbers?.firstPlusOne = (first.text.toString().toInt()+1).toString()
            myNumbers?.secondPlusOne = (second.text.toString().toInt()+1).toString()
            myNumbers?.thirdPlusOne = (third.text.toString().toInt()+1).toString()

            binding.first.visibility = View.GONE
            binding.second.visibility = View.GONE
            binding.third.visibility = View.GONE
            binding.addOne.visibility = View.GONE

            binding.firstPlus.visibility = View.VISIBLE
            binding.secondPlus.visibility = View.VISIBLE
            binding.thirdPlus.visibility = View.VISIBLE

            invalidateAll()
        }

        val inputMethodManager = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        inputMethodManager.hideSoftInputFromWindow(view.windowToken,0)
    }
}
