
/* Dynamic Disqus Inserter : inserts Disqus comments in your HTML Page */


/* ***** BEGIN LICENSE BLOCK *****
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
***** END LICENSE BLOCK ***** */


// change according to your Disqus forum identifier
disqus_shortname="barijaona-blog";

/* Comments counts : call to be inserted at the end of main page, just before </body>
	... <script type="text/javascript">getCounts();</script></body>
   (Directly derived from Disqus code)
*/
function getCounts() {
	var s = document.createElement('script'); s.async = true;
	s.type = 'text/javascript';
	s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';
	(document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
};


//id of comment
curRequest="";
//previous Disqus request accomplished
var cleaned = 1;
//frame where comment should be inserted
var iwin;

function writeFrameHead(theId){
	iwin=document.getElementById("HSd"+theId).contentWindow;
	iwin.document.close();
	iwin.document.write("<!DOCTYPE html><html>");
	iwin.document.write("<head><meta charset=\"UTF-8\" /><title><\/title><\/head>");
	iwin.document.write("<body onload=\"parent.alertSize('"+theId+"')\" >");
}

function writeFrameEnd(){
	iwin.document.write("<\/body><\/html>");
	iwin.document.close();
}

function cleanFrame(){
	writeFrameHead();
	writeFrameEnd();
	cleaned = 1;
}

/* insert in your HMTL : <a href="http://link-to-the-story#disqus-thread" onclick="return(getComment('...'));" data-disqus-identifier="...">
	<iframe id="HSd..." frameborder="0" style="border:0; height:0 ; width:100% ; overflow:hidden;" seamless></iframe>
*/
function getComment(commentId){
	if (window.setInterval && document.getElementById && document.createElement ){ //check browser functionalities
		if (commentId != curRequest){ //avoid extra work in case of multiple user's clicks
			if(cleaned == 1){ //previous treatment is finished
				writeFrameHead(commentId);
				curRequest=commentId;
				// this is strictly the transcription of the Disqus script, so we can blame them in case of problems
				iwin.document.write("<div id=\"disqus_thread\"></div>");
				iwin.document.write("<script type=\"text/javascript\">");
				iwin.document.write("var disqus_shortname = '"+ disqus_shortname + "';");
				iwin.document.write("var disqus_identifier = '"+commentId + "';");
				iwin.document.write("(function() { var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;");
				iwin.document.write("dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';");
				iwin.document.write("(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);})();");
				iwin.document.write("</script>");
				cleaned = null;
				writeFrameEnd();
				// let the user have a glimpse at Disqus visual feedback...
				document.getElementById("HSd"+commentId).height='32px';
				document.getElementById("HSd"+commentId).style.height='32px';
				// tells the browser not to follow the href link
				return false;
			} else { //a previous treatment is still running : delay our request
				setTimeout("getComment('"+commentId+"')",500);
				return false;
			}
		}
	}
	else {
		// unable to execute script : tell the browser to follow the href link to load the individual story page
		return true;
	}
}

/* resize the iframe when data is complete */
function alertSize(thisComment){
	var oFrame = document.getElementById("HSd"+thisComment);
	var oBody = oFrame.contentWindow.document.body;
	// by searching a characteristic string, check if Disqus data is loaded
	var pos= oBody.innerHTML.search(/dsq-comments/);
	if (pos >0 ){
		// adjust the iframe to its content
		// the 60 extra pixels are to handle the increase when the user clicks in the comment entry textarea
		mewHeight= oBody.scrollHeight + 60;  // + (oBody.offsetHeight - oBody.clientHeight);
		mewHeight=mewHeight + "px";
		oFrame.height=mewHeight;
		oFrame.style.height=mewHeight;
		// mark that we have finished
		cleaned=1;
		// allow to re-click to refresh
		if (thisComment==curRequest){
			curRequest='';
		}
    }
    else {
    	// Disqus data not yet loaded ; wait
    	setTimeout("alertSize('"+thisComment+"')",3000);
    }
}

