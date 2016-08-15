function selectedId(id, form, idName) {
	var modelId = bg.input.getCheckBoxValues(id);
	if (modelId == "" || modelId.indexOf(",") != -1) {
		alert("请选择一项数据进行操作!");
		return false;
	}
	if (null != form) {
		if (null == idName) {
			bg.form.addInput(form, id, modelId);
		} else {
			bg.form.addInput(form, idName, modelId);
		}
	}
	return true;
}

function selectedIds(ids, form, idsName) {
	var modelIds = bg.input.getCheckBoxValues(ids);
	if (modelIds == "") {
		alert("请选择数据进行操作!");
		return false;
	}
	if (null != form) {
		if (null == idsName) {
			bg.form.addInput(form, ids, modelIds);
		} else {
			bg.form.addInput(form, idsName, modelIds);
		}
	}
	return true;
}

function getInputParams(form, prefix, getEmpty) {
	var elems = form.elements;
	var params = "";
	for (i = 0; i < elems.length; i++) {
		if (elems[i].name != "") {
			if (elems[i].value == "" && getEmpty == false)
				continue;
			if (null != prefix) {
				if (elems[i].name.indexOf(prefix) == 0
						&& elems[i].name.indexOf(".") > 1) {
					if ((elems[i].type == "radio" || elems[i].type == "checkbox")
							&& elems[i].checked == false)
						continue;
					if (params != "") {
						params += "&";
					}
					params += elems[i].name + "=" + elems[i].value;
				}
			} else {
				if ((elems[i].type == "radio" || elems[i].type == "checkbox")
						&& elems[i].checked == false)
					continue;
				if (params != "") {
					params += "&";
				}
				params += elems[i].name + "=" + elems[i].value;
			}
		}
	}
	return params;
}