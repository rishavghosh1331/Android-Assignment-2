package com.example.enideddieno

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.view.inputmethod.InputMethodManager
import androidx.databinding.DataBindingUtil
import com.example.enideddieno.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private  lateinit var binding: ActivityMainBinding

    private var myWordss:MyWords = MyWords()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this,R.layout.activity_main)

        binding.myData = myWords

        binding.addOne.setOnClickListener {
            addName(it)
        }
    }

    private fun addName(view:View){

        binding.apply {
            myWords?.name1 = (name1.text.toString()+1).toString()
            myWords?.name2= (name2.text.toString()+1).toString()
            myWords?.age = (age.text.toString()+1).toString()

            binding.name1.visibility = View.GONE
            binding.name2.visibility = View.GONE
            binding.age.visibility = View.GONE
            binding.addOne.visibility = View.GONE

            binding.age2.visibility = View.VISIBLE
            binding.occup.visibility = View.VISIBLE
            binding.occup2.visibility = View.VISIBLE

            invalidateAll()
        }