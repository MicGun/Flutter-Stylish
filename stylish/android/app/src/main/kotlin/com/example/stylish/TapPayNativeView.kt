package com.example.stylish
import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.View
import androidx.appcompat.widget.AppCompatButton
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.content.res.ResourcesCompat
import com.example.test_tappay.PrimeDialog
import tech.cherri.tpdirect.api.TPDCard
import tech.cherri.tpdirect.api.TPDForm
import tech.cherri.tpdirect.model.TPDStatus

class TapPayNativeView: ConstraintLayout {

    var listener: PrimeDialog.PrimeDialogListener? = null;

    constructor(context: Context): super(context) {
        initView(View.inflate(context, R.layout.dialog_message, this))
    }

    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs) {
        initView(View.inflate(context, R.layout.dialog_message, this))
    }

    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(
        context,
        attrs,
        defStyleAttr
    ) {
        initView(View.inflate(context, R.layout.dialog_message, this))
    }

    private fun initView(rootView: View) {
        val tpdForm: TPDForm = rootView.findViewById(R.id.form_tpd)
        var tpdErrorMessage = "Credit Card information error"
        var isCanGetPrime = false

        tpdForm.setTextErrorColor(ResourcesCompat.getColor(resources, R.color.red_d0021b, null))
        tpdForm.setOnFormUpdateListener { tpdStatus ->
            when {
                tpdStatus.cardNumberStatus == TPDStatus.STATUS_ERROR ->
                    tpdErrorMessage = "Invalid Card Number"
                tpdStatus.expirationDateStatus == TPDStatus.STATUS_ERROR ->
                    tpdErrorMessage = "Invalid Expiration Date"
                tpdStatus.ccvStatus == TPDStatus.STATUS_ERROR ->
                    tpdErrorMessage = "Invalid CCV"
            }
            isCanGetPrime = tpdStatus.isCanGetPrime
        }

        val tpdCard = TPDCard.setup(tpdForm)
            .onSuccessCallback { primeToken: String, _, _: String, _ ->
                Log.d(PrimeDialog.TAG, "onSuccessCallback, prime=$primeToken")

                listener?.onSuccess(primeToken)
//                dismiss()
            }
            .onFailureCallback { status: Int, message: String ->
                Log.d(PrimeDialog.TAG, "onFailureCallback, status: $status, message: $message")

                listener?.onFailure("status: $status, message: $message")
//                dismiss()
            }


        val buttonPrime: AppCompatButton = rootView.findViewById(R.id.button_prime)
        buttonPrime.setOnClickListener {
            Log.d(PrimeDialog.TAG, "click get prime")
            tpdCard?.getPrime()
        }
    }
}