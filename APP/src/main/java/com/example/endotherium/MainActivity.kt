package com.example.endotherium

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
lateinit var editText: EditText
        val Button= findViewById<Button>(R.id.button)
        val name1= findViewById<EditText>(R.id.name1)
        val age= findViewById<EditText>(R.id.age)
        val occupation= findViewById<EditText>(R.id.occup)

        Button.setOnClickListener()
        {
            editText= findViewById(R.id.name1)as EditText
            val name= editText.text.toString()
            editText= findViewById(R.id.age)as EditText
            val age1= editText.text.toString()
            editText= findViewById(R.id.occup)as EditText
            val occup1= editText.text.toString()

            textView2.text= (name+"My name is"+age1+"My age is"+occup1).toString()
            name1.visibility= View.GONE
            name2.visibility= View.GONE
            age.visibility= View.GONE
            age2.visibility= View.GONE
            occup.visibility= View.GONE
            occup2.visibility= View.GONE
        }
    }
}
