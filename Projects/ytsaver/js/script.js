
const is_valid_title = (title) => {
	if (/^[a-z?A-Z?0-9?.?\-?,?_?\s?]+$/.test(title)) {
		return true;
	}
	return false;
}

const is_valid_link = (ytlink) => {
	if (/^((https?):\/\/)?([w|W]{3}\.)?[a-zA-Z0-9\-\.]{3,}\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})?$/.test(ytlink)) {
		return true;
	}
	return false;
} 


const toggle_modal = (head, body) => {
	$('#modal_head_text').text(head);
	$('#modal_body_text').text(body);
	$('#info_modal').modal();
}

const video_popup = (link) => {

	videoID = ""
	videoURL = "https://www.youtube.com/embed/"

	delayInMili = 250;

	if (link.includes("youtu.be")) {

		videoID = link.split('/').slice(-1)[0]

		videoURL += videoID

		$('#myFrame').attr('src', videoURL)

		setTimeout(function() {
  			$('#video_modal').modal();
		}, delayInMili);

		

	} else if (link.includes("watch?v=")) {

		videoID = link.split('?v=').slice(-1)[0]

		videoURL += videoID

		$('#myFrame').attr('src', videoURL)

		setTimeout(function() {
  			$('#video_modal').modal();
		}, delayInMili);

	} else {

		toggle_modal("Info", "It seems it is not a YouTube video URL! Use the direct video URL or Share URL from YouTube only!");
	}
}

const fetch_data = () => {
	$.ajax({
	  url: './backend/request-handler.php',
	  type: 'POST',
	  data: {
	  	"action": "fetch"
	  },
	  error: function(e) {
	  	console.log("Error : " + e.responseText);
	    toggle_modal("Error", "Oops! Something went wrong!");
	  },
	  dataType: 'json',
	  success: function(data) {
	    if (data['code'] === "0") {
	    	toggle_modal("Error", data['msg']);
	    } else {

	    	html = '';

	    	if (data.length == 0) {
	    		html += '<tr><td colspan="4">No Records Found!</td></tr>';
	    	} else {
	    		for (var i = 0; i < data.length; i++) {

	    			ytl = "'" + data[i]['ylink'] + "'";

	    			if (data[i]['is_watched'] == "1") {
	    				t_class = 'table-secondary';
	    				title = '<s>'+data[i]['title']+'</s>';
	    				ylink = '<s>'+data[i]['ylink']+'</s>';
	    				icon = 'fa-eye-slash';
	    				iconText = 'Un-Watched';
	    			} else {
	    				t_class = '';
	    				title = data[i]['title'];
	    				ylink = data[i]['ylink'];
	    				icon = 'fa-eye';
	    				iconText = 'Watched';
	    			}

	    			html += '<tr class="'+t_class+'"><th>'+(i+1)+'</th><td>'+ title +'</td><td><a onclick="video_popup('+ytl+');" href="#">'+ ylink +'</a></td><td><a onclick="toggle_it('+data[i]['id']+');" class="link_item" href="#" data-toggle="tooltip" data-placement="left" title="Mark as '+iconText+'"><i class="fa '+icon+'" aria-hidden="true"></i></a>&nbsp;&nbsp;<a class="link_item" onclick="edit_it('+data[i]['id']+');" href="#" data-toggle="tooltip" data-placement="top" title="Edit"><i class="fa fa-edit" aria-hidden="true"></i></a>&nbsp;&nbsp;<a class="link_item" href="#" data-toggle="tooltip" data-placement="right" onclick="delete_it('+data[i]['id']+');" title="Delete"><i class="fa fa-trash" aria-hidden="true"></i></a></td></tr>';
	    		}
	    	}
	    	
	    	$('#insert_table').html(html);
	    }
	  }
	});
}

const edit_it = (id) => {

	$.ajax({
	  url: './backend/request-handler.php',
	  type: 'POST',
	  data: {
	  	"action": "edit",
	    "id": id
	  },
	  error: function(e) {
	  	console.log("Error : " + e.responseText);
	    toggle_modal("Error", "Oops! Something went wrong!");
	  },
	  dataType: 'json',
	  success: function(data) {
	    if (data['code'] === "0") {
	    	toggle_modal("Error", data['msg']);
	    } else {
	    	$('#title_edit').val(data[0]['title']);
	    	$('#ytlink_edit').val(data[0]['ylink']);
	    	$('#update_btn').attr('onclick', 'update_it("' + data[0]['id'] + '");');
	    	$('#edit_modal').modal();
	    }
	  }
	});

}

const update_it = (id) => {

	var title = $('#title_edit').val();

	var ytlink = $('#ytlink_edit').val();

	$('#edit_modal').modal('hide');


	$.ajax({
	  url: './backend/request-handler.php',
	  type: 'POST',
	  data: {
	  	"action": "update",
	  	"id": id,
	    "title": title,
	    "ytlink": ytlink
	  },
	  error: function(e) {
	  	console.log("Error : " + e.responseText);
	    toggle_modal("Error", "Oops! Something went wrong!");
	  },
	  dataType: 'json',
	  success: function(data) {
	    if (data['code'] === "0") {
	    	toggle_modal("Error", data['msg']);
	    } else {
	    	toggle_modal("Success", data['msg']);
	    	fetch_data();
	    }
	  }
	});

}

const add_data = (title, ytlink) => {

	$.ajax({
	  url: './backend/request-handler.php',
	  type: 'POST',
	  data: {
	  	"action": "save",
	    "title": title,
	    "ytlink": ytlink
	  },
	  error: function(e) {
	  	console.log("Error : " + e);
	    toggle_modal("Error", "Oops! Something went wrong!");
	  },
	  dataType: 'json',
	  success: function(data) {
	    if (data['code'] === "0") {
	    	toggle_modal("Error", data['msg']);
	    } else {
	    	toggle_modal("Success", data['msg']);
	    	fetch_data();
	    }
	  }
	});

}

const toggle_data = (id) => {
	$.ajax({
	  url: './backend/request-handler.php',
	  type: 'POST',
	  data: {
	  	"action": "toggle",
	    "id": id,
	  },
	  error: function(e) {
	  	console.log("Error : " + e.responseText);
	    toggle_modal("Error", "Oops! Something went wrong!");
	  },
	  dataType: 'json',
	  success: function(data) {
	    if (data['code'] === "0") {
	    	toggle_modal("Error", data['msg']);
	    } else {
	    	fetch_data();
	    }
	  }
	});
}

const toggle_it = (id) => {
	toggle_data(id);
}

const delete_data = (id) => {
	$.ajax({
	  url: './backend/request-handler.php',
	  type: 'POST',
	  data: {
	  	"action": "delete",
	    "id": id,
	  },
	  error: function(e) {
	  	console.log("Error : " + e.responseText);
	    toggle_modal("Error", "Oops! Something went wrong!");
	  },
	  dataType: 'json',
	  success: function(data) {
	    if (data['code'] === "0") {
	    	toggle_modal("Error", data['msg']);
	    } else {
	    	toggle_modal("Success", data['msg']);
	    	fetch_data();
	    }
	  }
	});
}

const delete_it = (id) => {

	$('#confirm_delete_btn').attr('del-id', id);

	$('#delete_modal').modal('show');
}

const delete_from_modal = () => {
	$('#delete_modal').modal('hide');
	let id = $('#confirm_delete_btn').attr('del-id');
	delete_data(id);
}

$(function () {
  $('[data-toggle="tooltip"]').tooltip({ boundary: 'window' });
  $('#video_modal').on('hidden.bs.modal', function () {
        var memory = $(this).html();
     	$(this).html(memory);
     	$('#myFrame').attr('src', '#');
    });
  
  fetch_data();

  $('#add_btn').click(function(event){
  	event.preventDefault();
  	
  	let title = $('#title').val();
  	let ytlink = $('#ylink').val();

  	// Validation

  	// if (!is_valid_title(title)) {
  	// 	$('#title_error').text("Invalid Title! Please Check!");
  	// 	return;
  	// }

  	// if (!is_valid_link(ytlink)) {
  	// 	$('#ylink_error').text("Invalid Youtube Link! Please Check!");
  	// 	return;
  	// }

  	add_data(title, ytlink);
  	$('#title').val("");
  	$('#ylink').val("");
  	$('#title_error').text("");
  	$('#ylink_error').text("");
  });



});

