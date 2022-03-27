// ES6
document.addEventListener("DOMContentLoaded", (event) => {
    $(document).on('turbolinks:load', () => {

        const load_dashboard_data = (data_set) => {
            $.ajax({
                url: `${base_url}dashboard/load/${data_set}`,
                method: 'GET',
                success: (result) => {
                    // console.log(result)
                    document.querySelector('.dashboard_content_block').innerHTML = result
                },
                error: (result) => {
                    // console.log(result)
                    toastr.error(`There has been an error loading your ${data_set}`)
                    document.querySelector('.dashboard_content_block').innerHTML = '<img src="https://assets.prycely.com/images/close-and-reply.gif" style="width: 100%; height: auto;">'
                }
            })
        }

        if (window.location.href.includes('dashboard')) {
            let data_set = ''

            load_dashboard_data('groups')
            let dashboard_data_selectors = document.querySelectorAll('.dashboard_content_picker div'),
                dashboard_data = (e) => {
                    [].map.call(dashboard_data_selectors, function (elem) { elem.classList.remove("active") })
                    e.target.classList.add("active")
                    document.querySelector('.dashboard_content_block').innerHTML = '<img src="https://assets.prycely.com/images/preloader.gif" style="width: 100%; height: auto;">'
                    data_set = e.target.innerText.toLowerCase()
                    // console.log(data_set)
                    load_dashboard_data(data_set)
                }
            [].map.call(dashboard_data_selectors, function (elem) {
                elem.addEventListener("click", dashboard_data, false)
            });
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
                $('.pay_submit').val(`${loan_pay_currency} ${amount}`)
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