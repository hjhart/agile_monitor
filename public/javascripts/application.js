$(function() {
    $('input[name=get_feeds]').click(function(e) {
        e.preventDefault();
        data = {}
        url = $('input[name="project[feed_url]"]').val()
        if (url == null || url.trim() == "") {
            alert("there is no data!")
        } else {
            alert("there is data!" + url)
            data = { url: url }
        }

        $.ajax({
            url: '/ci/names.json',
            data: data,
            success: function(data) {
                select = $('select[name="project[name]"]')
                select.children().remove()
                selects = ""
                $.each(data, function(index, element) {
                    selects += "<option value=\"" + element + "\">" + element + "</option>"
                })
                console.debug(selects)
                select.html(selects)
                select.removeAttr("disabled")
            }
        });
    });
});