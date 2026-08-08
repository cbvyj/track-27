/**
 * 
 */

function isEmpty(obj,msg){
	var val = obj.value;
	var result= false;
	if(val==""){
		alert(msg)
		result=true;
		obj.focus();
	}
	return result;
}