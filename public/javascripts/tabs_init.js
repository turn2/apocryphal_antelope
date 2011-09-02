function init() {
    hideByClass('prizes');
    hideByClass('prizegroup');
}

var alreadyrunflag=0; //flag to indicate whether target function has already been run
if (document.addEventListener)
  document.addEventListener("DOMContentLoaded", function(){alreadyrunflag=1; init()}, false);
else if (document.all && !window.opera){
  document.write('<script type="text/javascript" id="contentloadtag" defer="defer" src="javascript:void(0)"><\/script>');
  var contentloadtag=document.getElementById("contentloadtag");
  contentloadtag.onreadystatechange=function() {
    if (this.readyState=="complete") {
      alreadyrunflag=1;
      init();
    }
  }
}

window.onload=function(){
  setTimeout("if (!alreadyrunflag) init();", 0)
}
