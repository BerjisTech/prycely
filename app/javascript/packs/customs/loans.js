// e.stopPropagation()
$(document).ready(() => {
    $('.l_approval').on('click', (e) => {
        e.preventDefault()
        e.stopPropagation()

        let l_approval = $('.l_approval')

        manager = l_approval.attr('loan_manager')
        approval_path = l_approval.attr('loan_approval_path')
        loan_id = l_approval.attr('loan_id')

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
            },
            error: (error) => {
                console.log(error)
            }
        })
    })
})