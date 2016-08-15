package com.sad.util.file;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.RandomAccessFile;

/**
 * 功能描述：创建TXT文件并进行读、写、修改操作
 */
public class FileUtil {

	public static BufferedReader bufread;
	private static String path = "D:/suncity.bat"; // 指定文件路径和名称
	private static File filename = new File(path);
	private static String readStr = "";

	/**
	 * 创建文件.
	 */
	public static void creatFile(File file, String path) throws IOException {
		if (!file.exists()) {
			file.createNewFile();
			System.out.println(file + "已创建!");
		}
	}

	/**
	 * 读取文本文件.
	 */
	public static String readFile() {
		String read;
		FileReader fileread;
		try {
			fileread = new FileReader(filename);
			bufread = new BufferedReader(fileread);
			try {
				while ((read = bufread.readLine()) != null) {
					readStr = readStr + read + "\r\n";
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		// System.out.println("文件内容是:" + "\r\n" + readStr);
		return readStr;
	}

	/**
	 * 写文件.
	 */
	public static void writeFile(File file, String newStr) throws IOException {
		// 先读取原有文件内容，然后进行写入操作
		String filein = newStr + "\r\n" + readStr + "\r\n";
		RandomAccessFile mm = null;
		try {
			mm = new RandomAccessFile(file, "rw");
			mm.writeBytes(filein);
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			if (mm != null) {
				try {
					mm.close();
				} catch (IOException e2) {
					e2.printStackTrace();
				}
			}
		}
	}

	/**
	 * 将文件中指定内容的第一行替换为其它内容.
	 * 
	 * @param oldStr
	 *            查找内容
	 * @param replaceStr
	 *            替换内容
	 */
	public static void replaceTxtByStr(String oldStr, String replaceStr) {
		String temp = "";
		try {
			File file = new File(path);
			FileInputStream fis = new FileInputStream(file);
			InputStreamReader isr = new InputStreamReader(fis);
			BufferedReader br = new BufferedReader(isr);
			StringBuffer buf = new StringBuffer();

			// 保存该行前面的内容
			for (int j = 1; (temp = br.readLine()) != null && !temp.equals(oldStr); j++) {
				buf = buf.append(temp);
				buf = buf.append(System.getProperty("line.separator"));
			}

			// 将内容插入
			buf = buf.append(replaceStr);

			// 保存该行后面的内容
			while ((temp = br.readLine()) != null) {
				buf = buf.append(System.getProperty("line.separator"));
				buf = buf.append(temp);
			}

			br.close();
			FileOutputStream fos = new FileOutputStream(file);
			PrintWriter pw = new PrintWriter(fos);
			pw.write(buf.toString().toCharArray());
			pw.flush();
			pw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void deleteFile(File file) {
		if (file != null && file.exists()) {
			file.delete();
		}
	}

	/**
	 * main方法测试
	 * 
	 * @param s
	 * @throws IOException
	 */
	public static void main(String[] s) throws IOException {
		/*
		 * ReadWriteFile.creatTxtFile();
		 * ReadWriteFile.readTxtFile();
		 * ReadWriteFile.writeTxtFile("imp money/money@orcl file=c:\\money-home.dmp owner=money");
		 * ReadWriteFile.readTxtFile();
		 */
		// ReadWriteFile.replaceTxtByStr("ken", "zhang");
	}
}
