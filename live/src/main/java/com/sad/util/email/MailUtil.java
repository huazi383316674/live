package com.sad.util.email;

import java.net.MalformedURLException;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class MailUtil {

	/**
	 * 发送邮件
	 * 
	 * @param hostName
	 *            服务器名称
	 * @param fromMail
	 *            发送邮箱地址
	 * @param formName
	 *            发送人名称
	 * @param formPwd
	 *            发送邮箱密码
	 * @param subject
	 *            标题
	 * @param content
	 *            内容
	 * @param filePaths
	 *            附件
	 */
	public static void send(String hostName, String fromMail, String formName, String formPwd,
	        String subject, String content, List<String> filePaths) throws EmailException,
	        MalformedURLException {

		HtmlEmail mail = new HtmlEmail();
		mail.setCharset("gbk");
		mail.setHostName(hostName);
		mail.addTo(fromMail, formName);
		mail.setFrom(fromMail, formName);
		mail.setAuthentication(fromMail, formPwd);
		mail.setSubject(subject);
		if (content != null) mail.setHtmlMsg(content);

		// 附件
		if (CollectionUtils.isNotEmpty(filePaths)) {
			for (int i = 0; i < filePaths.size(); i++) {
				EmailAttachment attac = new EmailAttachment();
				attac.setPath(filePaths.get(i));
				mail.attach(attac);
			}
		}

		mail.send();
		System.out.println("The attachmentEmail send sucessful!!!");
	}
}
