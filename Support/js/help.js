//Taken from source found in TextMate - Install "Edit in TextMate" command help.

/*
All internal page anchors need to have an offset. This controls those links. 
*/
function goTo (id) {
	document.body.scrollTop = document.getElementById(id).offsetTop + 8;
}

//Formatting for urls when they are passed to TextMate.system()
function e_sh(string) {
	return string.replace(/(?=[^a-zA-Z0-9_.\/\-\x7F-\xFF\n])/g, '\\').replace(/\n/g, "'\n'").replace(/^$/g, "''");
}

//Adds content to the specified node.
function insert_after(new_node, node) {
	var parent = node.parentNode;
	return node.nextSibling ? parent.insertBefore(new_node, node.nextSibling) : parent.appendChild(new_node);
}

function click_external_link(evt) {
	//if (!evt.metaKey) return;
	evt.preventDefault();
	TextMate.system("open " + e_sh(evt.srcElement.href), null);
}

//Find all the external links in the document and add listeners to catch click events.
function setup_external_links() {
	var link, links = document.links;
	for (i = 0; i < links.length; i++) {
		link = links[i];
		if (link.href.match(/^https?:/)) {
			// link.title = '⌘-click to open “' + link.href + '” in the default browser.';
			link.addEventListener('click', click_external_link, false);
			// insert_after(document.createTextNode("  ➲"), link);
		} else if (link.href.match(/^help:/)) {
			link.title = 'Open TexMate help in Help Viewer.';
			//insert_after(document.createTextNode(" ⓘ"), link);
		}
	}
}