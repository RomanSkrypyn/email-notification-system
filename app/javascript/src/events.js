$( document ).on('turbolinks:load', function() {

    if($('#event_event_type').val() == 'interval_event') {
        $('#event-days').css('display', 'block');
        $('#event-time-interval').css('display', 'block')
    }

    if($('#event_event_type').val() == 'single_occurrence_event') {
        $('#event-scheduled-date').css('display', 'block');
    }

    $('#event_event_type').on('change', function (e) {
        if(this.value == 'interval_event') {
            $('#event-days').css('display', 'block');
            $('#event-time-interval').css('display', 'block')
        }else {
            $('#event-days').css('display', 'none');
            $('#event-time-interval').css('display', 'none')
        }

        if(this.value == 'single_occurrence_event') {
            $('#event-scheduled-date').css('display', 'block');
        }else {
            $('#event-scheduled-date').css('display', 'none')
        }
    })
});
