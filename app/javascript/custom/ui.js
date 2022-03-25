document.addEventListener('DOMContentLoaded', async () => {
    $(document).on('turbolinks:load', () => {
        console.log('UI Functions')

        $('.nav-hider').on('click', () => {
            hide_nav()
        })

        $('.nav-shower').on('click', () => {
            show_nav()
        })

        function show_nav() {
            $('.main-nav').css({ "-webkit-transform": "translate(0px,0px)" });
            $('.nav-hider').show(300)
        }

        function hide_nav() {
            $('.main-nav').css({ "-webkit-transform": "translate(-550px,0px)" });
            $('.nav-hider').hide(300)
        }

        const inform = (message, type) => {
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

            if (type.toLowerCase() == 'info')
                toastr.info(message, "Info:", opts)

            if (type.toLowerCase() == 'error')
                toastr.error(message, "Error:", opts)
        }
    })
})