document.addEventListener("DOMContentLoaded", function (event) {
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
                document.querySelector('.fetched_data_js_block').innerHTML = document.querySelector('.dashboard_content_block').innerHTML = '<img src="https://assets.prycely.com/images/close-and-reply.gif" style="width: 100%; height: auto;">'
            }
        })
    }

    $('.fetched_data_js_select').on('change', (e) => {
        $('.fetched_data_js_block').html('<img src="http://assets.prycely.com/images/preloader.gif" style="width: 100%; height: auto;">')
        fetch_data($(e.target).val(), 0)
    })

    if (window.location.href.includes(`/${page_title}/g/`))
        fetch_data(7, 0)
});