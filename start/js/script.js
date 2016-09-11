
/*  Clock  *\
\*=========*/
function updateClock() {
	var currentTime = new Date ();
	var currentHours = currentTime.getHours ();
	var currentMinutes = currentTime.getMinutes ();
	var currentSeconds = currentTime.getSeconds ();

	// Pad the minutes and seconds with leading zeros, if required
	currentMinutes = (currentMinutes < 10 ? "0" : "") + currentMinutes;
	currentSeconds = (currentSeconds < 10 ? "0" : "") + currentSeconds;

	

	// Convert the hours component to 12-hour format if needed
	currentHours = (currentHours > 12) ? currentHours - 0 : currentHours;

	// Convert an hours component of "0" to "12"
	currentHours = (currentHours == 0) ? 0 : currentHours;

	// Compose the string for display
	var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds;

	// Fill '#clock' div with time
	$("#clock").html(currentTimeString);
}

$(document).ready(function() {
	
	/*  Get Links  *\
	\*=============*/
	var linkString = $('abruzzi').text();

	/*  Clear Page  *\
	\*==============*/
	$('abruzzi').empty();

	/*  Create Array from linkString  *\
	\*================================*/
	var linkArray = linkString.split("\n");

	/*  Go thru Array  *\
	\*=================*/
	var i;
	var count = 1;
	var html = '';

	for(i in linkArray) {

		/*  Get line  *\
		\*============*/
		var line = jQuery.trim(linkArray[i]);

		// If line is empty, skip
		if(!line)
			continue;

		/*  If it doesn't start with http,  *\
		|*  it must be a seperator          *|
		\*==================================*/
		if(line.substr(0,4) != 'http') {
			if(count > 1)
				html = html + '</div>';
				html = html + '<div class="block"><h1>' + line + '</h1><ul>';
				count++;
				continue;
		}

		/*  Split URL and Title  *\
		\*=======================*/
		var lineArray = line.split(" || ");
		var url = lineArray[0];
		var title = lineArray[1];

		/*  Add HTML code  *\
		\*=================*/
		if(newwindow)
			html = html + '<li><a href="' + url + '" target="_blank">' + title + '</a></li>'
		else
			html = html + '<li><a href="' + url + '">' + title + '</a></li>'
	}

	/*  Add generated content to page  *\
	\*=================================*/
	html = html + '</ul></div>';
	$('body').append(html);


	/*  Animation Time!  *\
	\*===================*/
	
	/*  Hide lists  *\
	\*==============*/
	$('ul').slideUp();

	/*  Show on hover  *\
	\*=================*/
	$('.block').mouseenter(function() {
		$('ul', this).slideDown();
	});

	/*  Hide on unhover  *\
	\*===================*/
	$('.block').mouseleave(function() {
		$('ul', this).slideUp();
	});


	/*  Search Engines  *\
	\*==================*/

	var search = '<div id="searches">';
	
	if(google) {
		var search = search + '<form method="get" action="http://www.google.com/search">',
		    search = search + '<input type="text" id="g" name="q" size="35" maxlength="255" value="" />',
		    search = search + '</form>';
	  }


	if(wikipedia) {
		var search = search + '<form method="get" action="http://www.wikipedia.org/w/index.php">',
		    search = search + '<input type="text" id="w" name="search" size="35" maxlength="255" value="" />',
		    search = search + '</form>';
	}


	if(flickr) {
		var search = search + '<form method="get" action="http://www.flickr.com/search">',
		    search = search + '<input type="text" id="da" name="q" size="35" maxlength="255" value="" />',
		    search = search + '</form>';
	}

	if(deviantart) {
		var search = search + '<form method="get" action="http://browse.deviantart.com/">',
		    search = search + '<input type="text" id="da" name="q" size="35" maxlength="255" value="" />',
		    search = search + '</form>';
	}

	var search = search + '</div>';

	/*  Add to page  *\
	\*===============*/
	$('body').append(search);
	if(focusSearch) {
		var searchDiv = document.getElementById ('searches');
		$(searchDiv.firstChild.firstChild).focus();
	}
 
	/*  Clock  *\
	\*=========*/

	if(showClock) {
		// Add empty '#clock' div
		$('body').append('<div id="clock"></div>');

		// Update clock
   	setInterval('updateClock()', 1000);
	}

});
