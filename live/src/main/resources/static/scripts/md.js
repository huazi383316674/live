
var prefix = "";

var count = 0;

function addMD() {
	var newMD = jQuery("#" + prefix + "blueprint").clone(true);
	count++;
	newMD.attr('id', prefix + count);
	newMD.removeAttr('style');
	newMD.insertBefore(jQuery("#" + prefix + "addbutton"));
	
	newMD.find("select[role='department']").attr('name', prefix + count + ".depart.id").addClass("requiredDepart");
	newMD.find("select[role='education']").attr('name', prefix + count + ".education.id").addClass("requiredEducation");
	newMD.find(':text').each(function(index, input) {
		if(index == 0) {
			jQuery(input).attr('name', prefix + count + ".effectiveAt").addClass("requiredEffectiveAt");
		}
		if(index == 1) {
			jQuery(input).attr('name', prefix + count + ".invalidAt");
		}
	})
}

function removeMD(button) {
	jQuery(button).parent('div').remove();
}

function beforesubmit() {
	jQuery(":hidden[name=" + prefix + "count]").val(count);
}

