function locking(){
	document.all.lightbox.style.display="block";
	document.all.lightbox.style.width=document.body.clientWidth;
	document.all.smallLay.style.display='block';
}
function Lock_CheckForm(theForm){
	document.all.lightbox.style.display='none';document.all.smallLay.style.display='none';
	return   false;
}


