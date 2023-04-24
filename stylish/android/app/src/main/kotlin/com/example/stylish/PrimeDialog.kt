package com.example.test_tappay

import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatDialog
import androidx.core.content.res.ResourcesCompat
import com.example.stylish.R
import com.example.stylish.databinding.DialogMessageBinding
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import tech.cherri.tpdirect.api.TPDCard
import tech.cherri.tpdirect.api.TPDServerType
import tech.cherri.tpdirect.api.TPDSetup
import tech.cherri.tpdirect.model.TPDStatus

/**
 * Created by Wayne Chen in Apr. 2023.
 */
class PrimeDialog(context: Context, val listener: PrimeDialogListener) : BottomSheetDialogFragment() {

    private var _binding: DialogMessageBinding? = null

    private val binding get() = _binding!!

    interface PrimeDialogListener {
        fun onSuccess(prime: String)
        fun onFailure(error: String)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

//        _binding = DialogMessageBinding.inflate(layoutInflater)
//        val root: View = binding.root
//        setContentView(root)


        TPDSetup.initInstance(
            context,
            12348,
            "app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF",
            TPDServerType.Sandbox
        )
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = DialogMessageBinding.inflate(layoutInflater)

        val tpdForm = binding.formTpd
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
                Log.d(TAG, "onSuccessCallback, prime=$primeToken")

                listener.onSuccess(primeToken)
                dismiss()
            }
            .onFailureCallback { status: Int, message: String ->
                Log.d(TAG, "onFailureCallback, status: $status, message: $message")

                listener.onFailure("status: $status, message: $message")
                dismiss()
            }


        binding.buttonPrime.setOnClickListener {
            Log.d(TAG, "click get prime")
            tpdCard?.getPrime()
        }

        return binding.root
    }

    companion object {
        const val TAG = "anan-android"
    }
}