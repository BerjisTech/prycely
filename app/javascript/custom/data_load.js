// ES6
import Chart from 'chart.js/auto'

window.colors = ["#ea795d", "#de7412", "#8bf9f3", "#729782", "#6a65d2", "#57755b", "#49fdc4", "#422bda", "#3b5837", "#2e50cc", "#2e50cc", "#26351c", "#1b5ca1", "#162bb1", "#0b0e06", "#0a5b76", "#050c8f"]

window.fetch_graph_data = (from = 0, to = 30, chart_pane_id) => {
    let chart_pane = $(`#${chart_pane_id} #chart_pane`)
    let chart_image = $(`#${chart_pane_id} #chart_image`)
    let chart_area = $(`#${chart_pane_id} #chart_area`)
    let data_path = $(`#${chart_pane_id}`).data('path')

    chart_pane.hide()
    chart_image.show()
    chart_area.hide()

    $.ajax({
        url: data_path,
        method: 'POST',
        data: {
            'authenticity_token': $('[name="csrf-token"]')[0].content,
            'from': from,
            'to': to
        },
        success: (response) => {
            console.log(response)
            chart_image.hide()
            if (response.type == 'error' || response.type == 'info') {
                chart_area.show()
                chart_area.html(response.message)
            }
            else {
                chart_pane.show()
                draw_graph(response, chart_pane_id)
            }
        },
        error: (error) => {
            chart_area.hide()
            chart_image.hide()
            console.log(error.responseText)
            console.error(error.responseText)
            chart_area.html('<div style="width: 100%; height: 100%;" class="m-3 p-3 d-flex align-items-center justify-content-center">There has been an error fetching your transactions</div>')
        }
    })
}

window.draw_graph = (data_set, chart_pane_id) => {
    if (dataChart !== undefined)
        dataChart.destroy()

    let height = $(`#${chart_pane_id}`).data('height')
    console.log(`height: ${height}`)
    $(`#${chart_pane_id} #chart_pane`).remove()
    $(`#${chart_pane_id}`).append(`<canvas id="chart_pane" width="100%" height="${height}" style="max-height: ${height} !important;"></canvas>`)

    let chart_pane = $(`#${chart_pane_id} #chart_pane`)

    if (chart_pane === undefined || chart_pane === null) return

    let ctx = chart_pane[0].getContext('2d')

    chart_pane.empty()
    let compiled_data = []
    let stacked = false

    if (data_set.blocks > 0) {
        for (let count = 0; count < data_set.sets.length; count++) {
            compiled_data.push({
                label: data_set.sets[count].title,
                data: data_set.sets[count].values,
                backgroundColor: data_set.sets[count].color,
            })
        }
        stacked = true
    } else {
        let background = '#41BB71'
        if (data_set.chart_type == 'doughnut' || data_set.chart_type == 'pie')
            background = colors

        compiled_data.push({
            label: data_set.title,
            data: data_set.values,
            backgroundColor: background,
        })
    }

    let options = null
    if (data_set.chart_type !== 'doughnut') {
        options = {
            plugins: {
                title: {
                    display: true,
                    text: data_set.title
                },
            },
            responsive: true,
            scales: {
                x: {
                    stacked: stacked,
                },
                y: {
                    stacked: stacked
                }
            }
        }
    } else {
        options = {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: data_set.title
                }
            }
        }
    }

    console.log(compiled_data)
    console.log(options)

    var dataChart = new Chart(ctx, {
        type: data_set.chart_type,
        data: {
            labels: data_set.keys,
            datasets: compiled_data
        },
        options: options
    });
}

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

        let initiate_approval_buttons = () => {
            $('.l_approval').on('click', (e) => {
                e.preventDefault()
                e.stopPropagation()

                let l_approval = $(e.target)

                let manager = l_approval.attr('loan_manager')
                let approval_path = l_approval.attr('loan_approval_path')
                let loan_id = l_approval.attr('loan_id')
                let approval_class = $(`.l_${loan_id}`)
                let approval_text = $(`.${loan_id}_approval_text`)

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
                        approval_text.html(response.approval_text)
                        toastr.info(response.message)
                    },
                    error: (error) => {
                        console.log(error)
                    }
                })
            })
        }

        if ($('.fetch_data')) {
            $('.fetch_data').on('change', (e) => {
                fetch_graph_data($(e.target).val(), 0, $(e.target).data('pane'))
            })
        }
    })
})