jQuery ->
	# remove no-js class to indicate JS support
	$('html').removeClass "no-js"

	# fire jKit
	$('body').jKit()