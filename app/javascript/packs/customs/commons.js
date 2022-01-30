// ES6

document.addEventListener("DOMContentLoaded", function (event) {
    const inform = (type, message) => {
        var opts = {
            "closeButton": true,
            "debug": false,
            "positionClass": "toast-top-right",
            "toastClass": "danger",
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "10000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };

        toastr.error(message, `${type}:`, opts)
    }

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
                inform(`There has been an error loading your ${data_set}`, 'Error')
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
                document.querySelector('.dashboard_content_block').innerHTML = '<img src="http://assets.prycely.com/images/preloader.gif" style="width: 100%; height: auto;">'
                data_set = e.target.innerText.toLowerCase()
                // console.log(data_set)
                load_dashboard_data(data_set)
            }
        [].map.call(dashboard_data_selectors, function (elem) {
            elem.addEventListener("click", dashboard_data, false)
        });
    }
})