// ES6

document.addEventListener("DOMContentLoaded", (event) => {
    $(document).on('turbolinks:load', () => {
        if (window.location.href.includes('/loans/new')) {

            let guarantors = $('[name="loan[guarantors]"]')

            let submitable = {
                amount: false,
                guarantor: false
            }

            $('.user_field').on('change', (e) => {
                checkFaulPlay()
                if ($(e.target).val() != "") {
                    $('.loan_category_field').removeClass('hidden')
                }
                else {
                    $('.loan_category_field').addClass('hidden')
                }
            })

            $('.loan_category_select').on('change', (e) => {
                if ($(e.target).val() != "") {
                    $('.guarantor_field').removeClass('hidden')
                    $('.amount_field').removeClass('hidden')
                }
                else {
                    $('.guarantor_field').addClass('hidden')
                    $('.amount_field').addClass('hidden')
                }
            })

            $('.amount_field').on('input', (e) => {
                let amount = $(e.target).val()
                let loan_type = $('.loan_category_select').val()
                let requester = $('.user_field').val()

                $.ajax({
                    url: `${base_url}check_requested_amount/${loan_type}/${amount}/${active_group}/${requester}`,
                    method: 'POST',
                    success: (r) => {
                        if (r.allowed === true) {
                            submitable['amount'] = true
                        } else {
                            toastr.error(r.message)
                            submitable['amount'] = false
                        }
                        check_submitable()
                    },
                    error: (e) => {
                        toastr.error('Something went wrong!')
                    }
                })
            })

            function checkFaulPlay() {
                if ($('.guarantor_input').val().includes($('.user_field').val())) {
                    submitable['guarantor'] = false
                    toastr.error('You can not be your own guarantor')
                } else {
                    submitable['guarantor'] = true
                }

                check_submitable()
            }

            function check_submitable() {
                console.log(submitable)
                if (submitable['amount'] === true &&
                    submitable['guarantor'] === true) {
                    $('[type="submit"]').prop('disabled', false)
                } else {
                    $('[type="submit"]').prop('disabled', true)
                }
            }

            function own_gurantor(guarantors, user_id) {
                $.ajax({
                    url: `/own_guarantor/${guarantors}/${user_id}`,
                    method: 'GET',
                    success: (response) => {
                        if (response == 0)
                            guarantor_limit(guarantors)

                        if (response == 1)
                            toastr.error('You can not be your own guarantor')
                    },
                    error: (response) => {
                        toastr.error('Something went wrong. Please reload the page')
                    }
                })
            }

            function guarantor_limit(guarantors) {
                let loan_category = $('.loan_category_select').val()
                guarantor_list = guarantors.split(',')
                let gc = 0
                if (guarantor_list[0] != '')
                    gc = guarantor_list.length

                $.ajax({
                    url: `/guarantor_limit/${gc}/${loan_category}`,
                    method: 'GET',
                    success: (response) => {
                        if (response.status == 'success') {
                            submitable['guarantor'] == false
                            check_submitable()
                        }

                        if (response.status == 'error')
                            toastr.error(response.message)
                    },
                    error: (error) => {
                        toastr.error('Something went wrong. Please reload the page')
                    }
                })
            }

            $('[name="guarantor_select"]').on('change', (e) => {
                let id = $(e.target).val()
                let current_guarantors = guarantors.val()

                let name = $(`option[value='${id}']`).html()

                if (!current_guarantors.includes(id)) {
                    if (current_guarantors == '') {
                        guarantors.val(id)
                    } else {
                        guarantors.val(`${current_guarantors},${id}`)
                    }

                    $('.guarantor_list_block').append(`
                        <span class="guarantor_span guarantor_${id}">
                        <span>${name} <em class="material-icons remove_guarantor" data-id="${id}">cancel</em></span>
                        </span>
                    `)

                    $('.remove_guarantor').on('click', () => {
                        let current_guarantors = guarantors.val()
                        let new_guarantor_list = current_guarantors

                        new_guarantor_list = current_guarantors.replace(`,${id},`, '').replace(`,${id}`, '').replace(`${id},`, '').replace(`${id}`, '').replace(`,,`, '')

                        guarantors.val(new_guarantor_list)

                        $(`.guarantor_${id}`).remove()
                        if (guarantors.val() == '') {
                            guarantor_limit('')
                        } else {
                            own_gurantor(guarantors.val(), $('.user_field').val())
                        }
                        $('[name="guarantor_select"]').val('')
                    })

                    own_gurantor(guarantors.val(), $('.user_field').val())
                }
            })

        }

        if (window.location.href.includes('loan/pay/')) {
            let hide_reusables = () => { $("[class$='_reusable']").addClass('hidden') }
            let amount_on_ui = (amount) => {
                amount = (amount).toLocaleString(
                    undefined, // leave undefined to use the visitor's browser 
                    // locale or a string like 'en-US' to override it.
                    { minimumFractionDigits: 2 }
                )
                dot_count = amount.split(".")
                console.log(dot_count)
                $('.main_price').html(dot_count[0])
                if (dot_count[1] !== undefined)
                    $('.decimal_price').html(`.${dot_count[1]}`)
                $('.pay_submit').val(`Pay ${loan_pay_currency} ${amount}`)
            }
            hide_reusables()
            amount_on_ui(amount)
            $("[name='loan_payment[payment_method]']").on("change", (e) => {
                hide_reusables()
                new_reusable = `${$(e.target).val().toLowerCase()}_reusable`
                $(`.${new_reusable}`).removeClass('hidden')
            })
            $('[name="loan_payment[amount]"]').on('input', (e) => {
                amount = parseFloat($(e.target).val())
                amount_on_ui(amount)
            })
        }
    })
})