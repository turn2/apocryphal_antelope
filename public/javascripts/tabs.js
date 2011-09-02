function setDisplayByClass( searchClass, display, node, tag ) {
	if ( node == null )
		node = document;
	if ( tag == null )
		tag = '*';
	var els = node.getElementsByTagName(tag);
	var elsLen = els.length;
	var pattern = new RegExp("(^|\\s)"+searchClass+"(\\s|$)");
	var classElements = new Array();
	for (i = 0, j = 0; i < elsLen; i++) {
    if (els[i].className != "") {
			if ( pattern.test(els[i].className) ) {
				classElements[j] = els[i];
				j++;
			}
    }
	}
	for (i = 0; i < classElements.length; i++) {
		var el = classElements[i];
	  el.style.display = display;
	}
}

function hideByClass( searchClass, node, tag ) {
	if ( node == null )
		node = document;
	if ( tag == null )
		tag = '*';
  setDisplayByClass( searchClass, 'none', node, tag );
}

function showByClass( searchClass, node, tag ) {
	if ( node == null )
		node = document;
	if ( tag == null )
		tag = '*';
  setDisplayByClass( searchClass, 'inline-block', node, tag );
}
