package com.sad.service.system.impl;

import java.util.ArrayList;
import java.util.List;

public class MoneyBackupMessage {

	private List<String> infos = new ArrayList<String>();

	private List<String> errors = new ArrayList<String>();

	public List<String> getInfos() {
		return infos;
	}

	public void setInfos(List<String> infos) {
		this.infos = infos;
	}

	public List<String> getErrors() {
		return errors;
	}

	public void setErrors(List<String> errors) {
		this.errors = errors;
	}

}
