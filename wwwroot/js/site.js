$(function() {
    $('#spinner').hide();
    $(document).bind('ajaxStart', function() {
        $('#spinner').show();
    }).bind('ajaxStop', function() {
        $('#spinner').hide();
    });
});

showInModal = (url, title) => {
    $.ajax({
        type: "GET",
        url: url,
        success: function(res) {
            $('#form-modal .modal-body').html(res);
            $('#form-modal .modal-title').html(title);
            $('#form-modal').modal('show');

        }
    })
}

AjaxPost = form => {

    try {
        $.ajax({
            type: 'POST',
            url: form.action,
            data: new FormData(form),
            contentType: false,
            processData: false,
            success: function(res) {
                if (res.isValid) {
                    $('#view-all').html(res.html);
                    $('#form-modal .modal-body').html('');
                    $('#form-modal .modal-title').html('');
                    $('#form-modal').modal('hide');
                    $.notify("Work created", "success");
                } else {
                    $('#form-modal .modal-body').html(res.html);
                }
            },
            error: function(err) {
                console.log(err);
            }
        })
    } catch (e) {
        console.log(e);
    }

    return false;
}

ajaxDelete = form => {
    if (confirm('Are you sure to delete this record ?')) {
        try {
            $.ajax({
                type: 'POST',
                url: form.action,
                data: new FormData(form),
                contentType: false,
                processData: false,
                success: function(res) {
                    $('#view-all').html(res.html);
                    $.notify("Deleted sucessfully", "success");
                },
                error: function(err) {
                    console.log(err)
                }
            })
        } catch (ex) {
            console.log(ex)
        }
    }

    //prevent default form submit event
    return false;
}

ajaxRegister = form => {
    var password = document.getElementById("pass").value;
    var confirm = document.getElementById("pass-confirm").value;
    if (password !== confirm) {
        swal("Error!", "Passwords not equal!", "error");
        return false;
    }
    try {
        $.ajax({
            type: 'POST',
            url: form.action,
            data: new FormData(form),
            contentType: false,
            processData: false,
            success: function(res) {},
            error: function(err) {
                console.log(err);
            }
        })
    } catch (e) {
        console.log(e);
    }

    return false;
}

ajaxLogin = form => {
    try {
        $.ajax({
            type: 'POST',
            url: form.action,
            data: new FormData(form),
            contentType: false,
            processData: false,
            success: function(res) {
                swal("Error!", "Username or email wrong!", "error");
            },
            error: function(err) {
                console.log(err);
            }
        })
    } catch (e) {
        console.log(e);
    }

    return false;
}