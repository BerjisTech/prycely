$(document).ready(() => {

    let fetch_data = (from, to) => {
        $.ajax({
            url: `${base_url}fetch_group_${page_title}`,
            method: 'POST',
            data: {
                'authenticity_token': $('[name="csrf-token"]')[0].content,
                'from': from,
                'to': to
            },
            success: (response) => {
                $('.fetched_data_js_block').html(response)
            },
            error: (response) => {
                $('.fetched_data_js_block').html(`<div style="width: 100%; height: 100%;" class="m-3 p-3 d-flex align-items-center justify-content-center">There has been an error fetching your ${page_title}</div>`)
            }
        })
    }

    $('.fetched_data_js_select').on('change', (e) => {
        $('.fetched_data_js_block').html('<img src="http://assets.prycely.com/images/preloader.gif" style="width: 100%; height: auto;">')
        fetch_data($(e.target).val(), 0)
    })

    if (window.location.href.includes(`/${page_title}/g/`))
        fetch_data(7, 0)
})