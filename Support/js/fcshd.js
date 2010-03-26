document.title = "Flex shell daemon status"

function setState(newState)
{
    console.log('state -> ' + newState)

    var statusMsg = ""
    var linkMsg = ""
    switch (newState)
    {
        case "up":
        	statusMsg = "Daemon is running"
        	linkMsg = "Stop"
        break

        case "down":
        	statusMsg = "Daemon is down"
        	linkMsg = "Start"
        break

        case "launching":
        	statusMsg = "Launching..."
        break

		case "stopping":
			statusMsg = "Daemon is stopping..."
		break;

		case "starting":
			statusMsg = "Daemon is starting..."
		break;
		
        case "unknown":
        	statusMsg = "Unknown..."
        break;

    }

    document.getElementById('status').innerHTML = statusMsg;
    document.getElementById('status').className = newState;
    document.getElementById('toggle').innerHTML = linkMsg;
    document.getElementById('toggle').className = newState;

}

function refreshStatus()
{
    var scriptElt = document.getElementById('script-path')
    var scriptPath = scriptElt.firstChild.nodeValue
	console.log( scriptPath + "fcshd.rb");
    TextMate.system('echo `"' + scriptPath + 'fcshd.rb" -status`', 
	    function(e) {
			console.log(e.outputString);
	        if (e.outputString.match("Running"))
			{
	            setState('up')

	        }
			else if (e.outputString.match("Stopped"))
			{
	            setState('down')
	        } 
			else
			{
				setState('unknown');
			}
	    })
}

function toggleClick()
{
    var scriptElt = document.getElementById('script-path')
    var scriptPath = scriptElt.firstChild.nodeValue

    var linkElt = document.getElementById('toggle')
    switch (linkElt.className)
	{
        case 'up':

			setState('stopping');
        	console.log('stopping');

			TextMate.system('"' + scriptPath + 'fcshd.rb" -stop', 
        		function(e) {
        		    console.log('stdout: ' + e.outputString)
        		    console.log('stderr: ' + e.errorString)
        		    if (e.outputString.match("Stopped"))
					{
        		        setState('down')
        		    } 
					else
					{
        		        console.log('but no match: "' + e.outputString + '" vs "STOPPED"')
        		    }
        		});
        break;

        case 'down':

			console.log('launching')
			setState('launching')
	
			console.log('"' + scriptPath + 'fcshd.rb" -start');
			TextMate.system('"' + scriptPath + 'fcshd.rb" -start', 
				function(e) {

					console.log('stdout: ' + e.outputString)
					console.log('stderr: ' + e.errorString)
	
					if (e.outputString.match("Running"))
					{
						setState('up')
					} 
					else if (e.outputString.match("Stopped"))
					{
						setState('down')
					}
					else
					{
						setState('unknown')
					}
				})
	
		break;
 
		case 'launching':
			console.log('launching')
		break;

		case 'unknown':
			console.log('unknown')
		break;
		
	}

}