package com.sad.service.system.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.mail.EmailException;
import org.beangle.commons.archiver.ZipUtils;
import org.beangle.commons.collection.CollectUtils;
import org.beangle.ems.config.model.PropertyConfigItemBean;
import org.beangle.model.persist.impl.BaseServiceImpl;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.service.system.MoneyDataService;
import com.sad.util.MoneyConstants;
import com.sad.util.email.MailUtil;
import com.sad.util.file.FileUtil;

public class MoneyDataServiceImpl extends BaseServiceImpl implements MoneyDataService {

	private SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");

	public void backupDatas(MoneyBackupMessage message) {

		/** 获取参数配置 */
		PropertyConfigItemBean batPathConfig = getPropertyConfigItem(MoneyConstants.batPath);
		PropertyConfigItemBean dmpPathConfig = getPropertyConfigItem(MoneyConstants.dmpPath);
		PropertyConfigItemBean zipPathConfig = getPropertyConfigItem(MoneyConstants.zipPath);
		PropertyConfigItemBean commandConfig = getPropertyConfigItem(MoneyConstants.expCommand);
		PropertyConfigItemBean mailAddConfig = getPropertyConfigItem(MoneyConstants.backupMailAdd);
		PropertyConfigItemBean mailHostConfig = getPropertyConfigItem(MoneyConstants.backupMailHost);
		PropertyConfigItemBean mailPwdConfig = getPropertyConfigItem(MoneyConstants.backupMailPwd);

		if (batPathConfig == null) message.getErrors().add("没有找到对应的系统参数:" + MoneyConstants.batPath);
		if (dmpPathConfig == null) message.getErrors().add("没有找到对应的系统参数:" + MoneyConstants.dmpPath);
		if (commandConfig == null) message.getErrors().add("没有找到对应的系统参数:" + MoneyConstants.expCommand);
		if (zipPathConfig == null) message.getErrors().add("没有找到对应的系统参数:" + MoneyConstants.zipPath);
		if (mailAddConfig == null) message.getErrors().add("没有找到对应的系统参数:" + MoneyConstants.backupMailAdd);
		if (mailHostConfig == null) message.getErrors().add("没有找到对应的系统参数:" + MoneyConstants.backupMailHost);
		if (mailPwdConfig == null) message.getErrors().add("没有找到对应的系统参数:" + MoneyConstants.backupMailPwd);
		if (CollectionUtils.isNotEmpty(message.getErrors())) return;

		String filePath = batPathConfig.getValue().replace("$(date)", sdf.format(new Date())); // 创建的bat文件路径
		String dmpPath = dmpPathConfig.getValue().replace("$(date)", sdf.format(new Date())); // 创建的dmp文件路径
		String command = commandConfig.getValue().replace("$(" + MoneyConstants.dmpPath + ")", dmpPath); // 执行的命令
		String zipPath = zipPathConfig.getValue().replace("$(date)", sdf.format(new Date())); // 创建的zip文件路径

		// 判断是有存在该文件，如果存在则先删除
		List<String> paths = CollectUtils.newArrayList();
		paths.add(filePath);
		paths.add(dmpPath);
		paths.add(zipPath);
		deleteFiles(paths);

		/** 创建文件 */
		File file = new File(filePath);
		try {
			FileUtil.creatFile(file, filePath);
		} catch (Exception e) {
			e.printStackTrace();
			message.getErrors().add("创建bat文件出现意外错误");
			return;
		}

		/** 写入文件内容 */
		try {
			FileUtil.writeFile(file, command);
		} catch (Exception e) {
			e.printStackTrace();
			message.getErrors().add("将内容写入bat文件出现意外错误");
			return;
		}

		/** 执行导出命令 */
		try {
			Process proc = Runtime.getRuntime().exec("cmd.exe /C " + filePath);// 执行命令
			proc.getOutputStream().close();

			StreamThread errorGobbler = new StreamThread(proc.getErrorStream(), "Error");
			StreamThread outputGobbler = new StreamThread(proc.getInputStream(), "Output");
			errorGobbler.start();
			outputGobbler.start();

			proc.waitFor();
			message.getInfos().add("数据备份成功，文件路径为：" + dmpPath);
		} catch (Exception e) {
			e.printStackTrace();
			message.getErrors().add("执行bat文件出现意外错误");
			return;
		}

		/** 将导出的文件压缩成zip格式 */
		List<String> fileNames = CollectUtils.newArrayList();
		fileNames.add(dmpPath);
		ZipUtils.zip(fileNames, zipPath, "GBK");
		message.getInfos().add("数据备份文件压缩成功，文件路径为：" + zipPath);

		/** 将压缩文件作为附件发送到指定邮箱 */
		List<String> attachments = CollectUtils.newArrayList();
		attachments.add(zipPath);
		try {
			MailUtil.send(mailHostConfig.getValue(), mailAddConfig.getValue(), "Money", mailPwdConfig
			        .getValue(), "backup datas-" + sdf.format(new Date()), null, attachments);
		} catch (MalformedURLException e) {
			e.printStackTrace();
			message.getErrors().add("将数据备份文件发送指定邮箱时出现意外错误");
			return;
		} catch (EmailException e) {
			e.printStackTrace();
			message.getErrors().add("将数据备份文件发送指定邮箱时出现意外错误");
			return;
		}
		message.getInfos().add("数据备份文件发送指定邮箱成功，邮箱名称为：" + mailAddConfig.getValue());

		/** 删除产生的文件 */
		deleteFiles(paths);
		message.getInfos().add("删除临时文件成功");
	}

	public PropertyConfigItemBean getPropertyConfigItem(String configName) {
		OqlBuilder<PropertyConfigItemBean> query = OqlBuilder.from(PropertyConfigItemBean.class, "config");
		query.where("config.name =:name", configName);
		List<PropertyConfigItemBean> items = entityDao.search(query);
		return CollectionUtils.isNotEmpty(items) ? items.get(0) : null;
	}

	/**
	 * 删除文件
	 */
	private void deleteFiles(List<String> paths) {
		for (String path : paths) {
			FileUtil.deleteFile(new File(path));
		}
	}

}

class StreamThread extends Thread {
	InputStream is;
	String type;

	StreamThread(InputStream is, String type) {
		this.is = is;
		this.type = type;
	}

	public void run() {
		try {
			InputStreamReader isr = new InputStreamReader(is);
			BufferedReader br = new BufferedReader(isr);
			String line = null;
			while ((line = br.readLine()) != null) {
				System.out.println(line);
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
	}
}
