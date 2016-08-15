package com.sad.web.action.login;

import org.beangle.ems.web.action.SecurityActionSupport;

public class RegisterAction extends SecurityActionSupport{
	
	
	public String index(){
		
		return forward();
	}
	
	public String save(){
			
		return forward("home", null);
	}
}
