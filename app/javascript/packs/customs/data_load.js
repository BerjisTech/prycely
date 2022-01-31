// ES6

document.addEventListener("DOMContentLoaded", (event) => {
    $(document).on('turbolinks:load', () => {
        let extra_functions = () => {
            if (window.location.href.includes('loan')) {
                initiate_approval_buttons()
            }
        }

        let fetch_data = (from, to) => {
            $.ajax({
                url: `${base_url}fetch_group_${page_title.replace('group_', '')}`,
                method: 'POST',
                data: {
                    'authenticity_token': $('[name="csrf-token"]')[0].content,
                    'from': from,
                    'to': to
                },
                success: (response) => {
                    document.querySelector('.fetched_data_js_block').innerHTML = response
                    extra_functions()
                },
                error: (response) => {
                    inform(`There has been an error fetching your ${page_title}`, 'Error')
                    document.querySelector('.fetched_data_js_block').innerHTML = '<img src="https://assets.prycely.com/images/close-and-reply.gif" style="width: 100%; height: auto;">'
                }
            })
        }

        $('.fetched_data_js_select').on('change', (e) => {
            $('.fetched_data_js_block').html('<img src="https://assets.prycely.com/images/preloader.gif" style="width: 100%; height: auto;">')
            fetch_data($(e.target).val(), 0)
        })

        if (window.location.href.includes(`/${page_title}/g/`))
            fetch_data(7, 0)



        let initiate_approval_buttons = () => {
            let manager = ''
            let approval_path = ''
            let loan_id = ''
            let approval_class = ''
            $('.l_approval').on('click', (e) => {
                e.preventDefault()
                e.stopPropagation()

                let l_approval = $(e.target)

                manager = l_approval.attr('loan_manager')
                approval_path = l_approval.attr('loan_approval_path')
                loan_id = l_approval.attr('loan_id')
                approval_class = $(`.l_${loan_id}`)

                $.ajax({
                    url: approval_path,
                    data: {
                        'authenticity_token': $('[name="csrf-token"]')[0].content,
                        'user_id': manager,
                        'loan_id': loan_id
                    },
                    method: 'POST',
                    success: (response) => {
                        console.log(response)
                        response = response[0]
                        if (!response.type == 'success') return
                        approval_class.attr('loan_approval_path', response.approval_path)
                        approval_class.html(response.icon)
                        approval_class.removeClass(response.remove_color)
                        approval_class.addClass(response.add_color)
                        inform('info', response.message)
                    },
                    error: (error) => {
                        console.log(error)
                    }
                })
            })
        }
    })
})