function dropDownNav()
{
    var sfEls = document.getElementById("nav").getElementsByTagName("LI");
    for (var i=0; i<sfEls.length; i++)
    {
        sfEls[i].onmouseover=function()
        {
            this.className += ' sfhover';
            this.style.zIndex=200;
        }
        sfEls[i].onmouseout=function()
        {
            this.className = this.className.replace(/\s?sfhover/g,'');
        }
    }
}

function windowLoad() { 
 	if (!document.getElementsByTagName) return; 
 	var anchors = document.getElementsByTagName("a"); 
 	for (var i=0; i<anchors.length; i++) { 
   		var anchor = anchors[i]; 
   		if (anchor.getAttribute("href") && anchor.getAttribute("rel") == "external") 
     		anchor.target = "_blank"; 
 	}
 	
 	if (document.getElementById('nav') != null)
    {
        dropDownNav();
    }
}

if (window.attachEvent)
{
    window.attachEvent("onload", windowLoad);
}