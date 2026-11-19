<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreOrderRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            // بيانات العميل
            'name' => 'required|string|max:255',
            'company' => 'nullable|string|max:255',
            'country' => 'required|in:eg,sa',
            'state' => 'nullable|string|max:255',
            'governorate' => 'nullable|string|max:255',
            'phone' => 'required|string|max:30',
            'whatsapp_number' => 'nullable|string|max:30',
            'email' => 'nullable|email|max:255',

            // العنوان
            'city' => 'required|string|max:255',
            'district' => 'nullable|string|max:255',
            'address' => 'required|string',
            'latitude' => 'nullable|numeric|between:-90,90',
            'longitude' => 'nullable|numeric|between:-180,180',
            'notes' => 'nullable|string|max:2000',

            // الطلب
            'user_id' => 'nullable|exists:users,id',
            'coupon_code' => 'nullable|string|max:100',
            'products' => 'required|array|min:1',
            'products.*.product_id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|integer|min:1',

            // الموافقة على الشروط
            'terms_accepted' => 'accepted',

            // الدفع
            'payment_type' => 'required|in:cash,vodafone_cash,instapay',

            'sender_phone' => [
                Rule::requiredIf(fn () => $this->input('payment_type') === 'vodafone_cash'),
                'nullable',
                'string',
                'max:30',
            ],

            'reference_number' => [
                Rule::requiredIf(fn () => $this->input('payment_type') === 'instapay'),
                'nullable',
                'string',
                'max:255',
            ],

            'receipt' => [
                Rule::requiredIf(fn () => in_array($this->input('payment_type'), ['vodafone_cash', 'instapay'], true)),
                'nullable',
                'file',
                'mimes:jpg,jpeg,png,pdf',
                'max:5120',
            ],
        ];
    }

    public function attributes(): array
    {
        return [
            'name' => 'الاسم الكامل',
            'company' => 'الشركة',
            'country' => 'الدولة',
            'state' => 'المنطقة',
            'governorate' => 'المحافظة',
            'phone' => 'رقم الهاتف',
            'whatsapp_number' => 'رقم الواتساب',
            'city' => 'المدينة',
            'district' => 'الحي',
            'address' => 'العنوان',
            'notes' => 'الملاحظات',
            'products' => 'المنتجات',
            'products.*.quantity' => 'الكمية',
            'terms_accepted' => 'الموافقة على الشروط',
            'payment_type' => 'طريقة الدفع',
            'sender_phone' => 'رقم التحويل',
            'reference_number' => 'رقم العملية',
            'receipt' => 'الإيصال',
        ];
    }

    public function messages(): array
    {
        return [
            'terms_accepted.accepted' => 'لازم توافق على الشروط والأحكام.',
            'receipt.mimes' => 'الإيصال لازم يكون jpg أو png أو pdf.',
            'receipt.max' => 'حجم الإيصال لازم يكون أقل من 5 ميجا.',
        ];
    }
}