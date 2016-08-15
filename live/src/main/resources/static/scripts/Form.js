function boxAction(box, action){
	var val = "";
	if (box)
	{
		if (! box[0])
		{
			if (action == "selected")
			{
				return box.checked;
			} else if (action == "value")
			{
				if (box.checked)
					val = box.value;
			} else if (action == "toggle")
			{
				box.checked = ! box.checked;
			}
		} else
		{
			for (var i=0; i<box.length; i++)
			{
				if (action == "selected")
				{
					if (box[i].checked)
						return box[i].checked;
				} else if (action == "value")
				{
					if (box[i].checked)
					{
						if (box[i].type == "radio")
						{
							val = box[i].value;
						} else if (box[i].type == "checkbox")
						{
							if (val != "")
								val = val + ",";	
							val = val + box[i].value;
						}
					}
				} else if (action == "toggle")
				{
					box[i].checked = ! box[i].checked;
				}
			}
		}
	}

    if (action == "selected")
        return false;
	else
        return val;
}

function checkboxSelected(chk)
{
	return boxAction(chk, "selected");
}

function getRadioValue(radio)
{
	return boxAction(radio, "value");
}
	
function getCheckBoxValue(chk)
{
	return boxAction(chk, "value");
}

function getCheckBoxRelativeValue(input, chkBox)
{
	var val = "";
	if (chkBox)
	{
		if (! chkBox[0])
		{
			if (chkBox.checked)
				val = input.value;
		} else
		{
			for (var i=0; i<chkBox.length; i++)
			{
				if (chkBox[i].checked)
				{
					if(val!="")
					{
					  val = val + ",";	
					}
					val = val + input[i].value;
					
				}
			}
		}
	}
	return val;
}

//
function toggleCheckBox(chk)
{		
    boxAction(chk, "toggle");
}

function getAllOptionValue(select)
{
	var val = "";
	var options = select.options;
	for (var i=0; i<options.length; i++)
	{   
		if (val != "")
			val = val + ",";	
		val = val + options[i].value;
	}
	return val;
}

function getSelectedOptionValue(select)
{
	var val = "";
	var options = select.options;
	for (var i=0; i<options.length; i++)
	{   
		if (options[i].selected)
		{
			if (val != "")
				val = val + ",";	
			val = val + options[i].value;
		}
	}
	return val;
}

function hasOption(select, op)
{ 
	for (var i=0; i<select.length; i++ )
    {
		if (select.options[i].value == op.value)
            return true;
    }
    
	return false;
}

function clearSelectStatus(select){
    //CLEAR
    for (var i=0; i<select.length; i++)
        select.options[i].selected = false;
}

function appendSelectedOption(srcSelect, destSelect){ 
	for (var i=0; i<srcSelect.length; i++){
	   
		if (srcSelect.options[i].selected){ 
		 
			var op = srcSelect.options[i];
			if (hasOption(destSelect, op)){
			   window.alert("?????????????????????");
			}else{
			   destSelect.options[destSelect.length]= new Option(op.text, op.value);
			}
		 }
	 }
              
     clearSelectStatus(srcSelect);
}

function removeSelectedOption(select){
	var options = select.options;
	for (var i=options.length-1; i>=0; i--){   
		if (options[i].selected){  
			options[i] = null;
		}
	}
}

function moveSelectedOption(srcSelect, destSelect){
	for (var i=0; i<srcSelect.length; i++){
	   
		if (srcSelect.options[i].selected){ 
		 
			var op = srcSelect.options[i];
			if (!hasOption(destSelect, op)){
			   destSelect.options[destSelect.length]= new Option(op.text, op.value);
			}
		 }
	 }      
	 removeSelectedOption(srcSelect);   
     clearSelectStatus(srcSelect);
}

function unCheckAllBox(box){
     for (var i=0; i<box.length; i++){
           box[i].checked = false;
     }
}

function setSelectorIdAndDescriptions(){

   var args = setSelectorIdAndDescriptions.arguments;
   var ids = args[0]; 
   var descriptions = args[1];
   var idsTarget = args[2];
   var descriptionsTarget = args[3];
   
   var tempIds, tempDescriptions;
   
   if (args.length>4){
       if (args[4]=="join"){
          tempIds = joinIds(document.all[idsTarget].value, ids);
          tempDescriptions = joinNames(document.all[descriptionsTarget].value, descriptions);
       }
       if (args[4]=="reset"){
          tempIds = "";
          tempDescriptions = "";
       }
   } else {
       tempIds = ids;
       tempDescriptions = descriptions;
   }
   
   document.all[idsTarget].value = tempIds;
   document.all[descriptionsTarget].value = tempDescriptions;
}

/*?????????id????????????????????????*/
function joinIds(targetIds, joinIds){
   if (targetIds != ""){
       var tempIds = joinIds.split(",");
       var currentIds = "," + targetIds + ",";
       
       for (var i=0; i<tempIds.length; i++){
          if (!(currentIds.indexOf(tempIds[i]+",")>0)){
              currentIds = currentIds + tempIds[i] + ",";
          }
       }
       
       var ids = currentIds.split(",");
       var finalIds = ",";
       for (var i=0; i<ids.length; i++){
           if (ids[i]!=""){
              finalIds = finalIds + ids[i] + ",";
           }
       }
       return finalIds.substr(1, finalIds.length-2);
   } else {
       return joinIds;
   }
}

/*???????????????????????????????????????*/
function joinNames(targetNames, joinNames){
   if (targetNames!=""){
       var tempNames = joinNames.split(",");
       var currentNames = "," + targetNames + ",";
       
       for (var i=0; i<tempNames.length; i++){
          if (!(currentNames.indexOf(tempNames[i]+",")>0)){
              currentNames = currentNames + tempNames[i] + ",";
          }
       }
       
       var names = currentNames.split(",");
       var finalNames = ",";
       for (var i=0; i<names.length; i++){
          if (names[i]!=""){
              finalNames = finalNames + names[i] + ",";
          }
       }
       return finalNames.substr(1, finalNames.length-2);
   } else {
       return joinNames;
   }     
}

/*??????????????????????????????*/
function choiceTargetSelectorOption(selected, targetSelectorName){
    if (selected!=""){
        var targetSelector = document.all[targetSelectorName];
        for (var index=0; index<targetSelector.options.length; index++){
            if (targetSelector.options[index].value==selected){
                targetSelector.selectedIndex = index;
            }
        }
     }
}

/*??????radioBox*/
function choiceTargetRadioBox(selected, targetRadioName){
   if (selected != ""){
       var targetRadio=document.all[targetRadioName];
	   for(var i=0; i<targetRadio.length; i++){
	      if (targetRadio[i].value == selected){
	          targetRadio[i].checked=true;
	      }
	  }
   }
}