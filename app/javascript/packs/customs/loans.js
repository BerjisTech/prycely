// ES6

if (window.location.href.includes('loan')) {
    let manager = ''
    let approval_path = ''
    let loan_id = ''
    let approval_class = ''

    const initiate_approval_buttons = () => {
        document.querySelector('.l_approval').addEventListener('click', (e) => {
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
}

document.addEventListener("DOMContentLoaded", function (event) {

})