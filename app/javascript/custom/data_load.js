// ES6
import Chart from 'chart.js/auto'

document.addEventListener("DOMContentLoaded", (event) => {
    $(document).on('turbolinks:load', () => {
        let extra_functions = () => {
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
                },
                error: (response) => {
                    toastr.error(`There has been an error fetching your ${page_title}`)
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

        if (window.location.href.includes('groups')) {
            let chart_pane = document.getElementById("chart_pane");

            if (chart_pane === undefined || chart_pane === null) return

            let ctx = chart_pane.getContext('2d')

            let draw_graph = (transactions) => {
                console.log(transactions['data'])
                console.log(transactions['dates'])
                $(chart_pane).empty()
                var dataChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: transactions.dates,
                        datasets: [{
                            label: 'Credit',
                            data: transactions.credit,
                            backgroundColor: 'blue',
                        }, {
                            label: 'Debit',
                            data: transactions.debit,
                            backgroundColor: 'red',
                        }]
                    },
                    options: {
                        plugins: {
                            title: {
                                display: true,
                                text: 'Group Transactions'
                            },
                        },
                        responsive: true,
                        scales: {
                            x: {
                                stacked: true,
                            },
                            y: {
                                stacked: true
                            }
                        }
                    }
                });
            }



            let fetch_graph_data = (from, to, data_path) => {
                $('#chart_pane').hide()
                $('#chart_image').show()
                $('#chart_area').hide()
                $.ajax({
                    url: data_path,
                    method: 'POST',
                    data: {
                        'authenticity_token': $('[name="csrf-token"]')[0].content,
                        'group_id': active_group,
                        'from': from,
                        'to': to
                    },
                    success: (response) => {
                        console.log(response)
                        $('#chart_image').hide()
                        if (response.type == 'error' || response.type == 'info') {
                            $('#chart_area').show()
                            $('#chart_area').html(response.message)
                        }
                        else {
                            $('#chart_pane').show()
                            draw_graph(response.data)
                        }
                    },
                    error: (error) => {
                        $('#chart_area').hide()
                        $('#chart_image').hide()
                        console.log(error.responseText)
                        console.error(error.responseText)
                        $('#chart_area').html('<div style="width: 100%; height: 100%;" class="m-3 p-3 d-flex align-items-center justify-content-center">There has been an error fetching your transactions</div>')
                    }
                })
            }

            $('.fetch_transactions').on('change', (e) => {
                fetch_graph_data($(e.target).val(), 0, $(chart_pane).attr('data-path'))
            })

            fetch_graph_data(7, 0, $(chart_pane).attr('data-path'))
        }
    })
})