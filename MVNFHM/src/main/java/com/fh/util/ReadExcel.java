package com.fh.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.fh.entity.order.ImportExcel;

/**
 * 工具类导入数据
 * 
 * @author hzc
 *
 */
public class ReadExcel {

	// 总行数
	private int totalRows = 0;
	// 总条数
	private int totalCells = 0;
	// 错误信息接收器
	private String errorMsg;

	// 构造方法
	public ReadExcel() {
	}

	// 获取总行数
	public int getTotalRows() {
		return totalRows;
	}

	// 获取总列数
	public int getTotalCells() {
		return totalCells;
	}

	// 获取错误信息
	public String getErrorInfo() {
		return errorMsg;
	}

	/**
	 * 验证EXCEL文件
	 * 
	 * @param filePath
	 * @return
	 */
	public boolean validateExcel(String filePath) {
		if (filePath == null || !(WDWUtil.isExcel2003(filePath) || WDWUtil.isExcel2007(filePath))) {
			errorMsg = "文件名不是excel格式";
			return false;
		}
		return true;
	}

	/**
	 * 读EXCEL文件，获取信息集合
	 * 
	 * @param templet
	 *            导入模板名称
	 * @param filePath
	 *            临时存储excel的路径
	 * @param name
	 *            文件名
	 * @param uploadExcel
	 *            要导入的excel文件
	 * @return
	 */
	public List<ImportExcel> getExcelInfo(String templet, String filePath, String name, MultipartFile uploadExcel) {

		// 把spring文件上传的MultipartFile转换成CommonsMultipartFile类型
		CommonsMultipartFile cf = (CommonsMultipartFile) uploadExcel;
		// 获取本地存储路径
		File file = new File(filePath);
		// 如果目录不存在则创建一个目录
		if (!file.exists()) {
			file.mkdirs();
		}
		// 新建一个文件
		File file1 = new File(filePath + "/" + new Date().getTime() + ".xlsx");
		// 将上传的文件写入新建的文件中
		try {
			cf.getFileItem().write(file1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 初始化信息的集合
		List<ImportExcel> customerList = new ArrayList<ImportExcel>();
		// 初始化输入流
		InputStream is = null;
		try {
			// 验证文件名是否合格
			if (!validateExcel(name)) {
				return null;
			}
			// 根据文件名判断文件是2003版本还是2007版本
			boolean isExcel2003 = true;
			if (WDWUtil.isExcel2007(name)) {
				isExcel2003 = false;
			}
			// 根据新建的文件实例化输入流
			is = new FileInputStream(file1);
			// 跟据模板，读取信息根据excel里面的内容
			customerList = getExcelInfo(is, isExcel2003, templet);
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					is = null;
					e.printStackTrace();
				}
			}
		}
		// 删除excel
		file1.delete();
		return customerList;
	}

	/**
	 * 根据excel里面的内容读取信息
	 * 
	 * @param is
	 *            输入流
	 * @param isExcel2003
	 *            excel是2003还是2007版本
	 * @return
	 * @throws IOException
	 */
	private List<ImportExcel> getExcelInfo(InputStream is, boolean isExcel2003, String templet) {
		List<ImportExcel> pmList = null;
		try {
			/** 根据版本选择创建Workbook的方式 */
			Workbook wb = null;
			// 当excel是2003时
			if (isExcel2003) {
				wb = new HSSFWorkbook(is);
			} else {// 当excel是2007时
				wb = new XSSFWorkbook(is);
			}
			// 根据模板名称，读取Excel里面的信息
			if (templet.equals("orderInfo")) {
				pmList = readExcelValueByEmpInfo(wb);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return pmList;
	}

	/**
	 * 读取Excel
	 * 
	 * @param wb
	 * @return
	 */
	private List<ImportExcel> readExcelValueByEmpInfo(Workbook wb) {

		// 得到第一个shell
		Sheet sheet = wb.getSheetAt(0);
		// 得到Excel的行数
		this.totalRows = sheet.getPhysicalNumberOfRows();
		// int totalRows = sheet.getLastRowNum() + 1;
		// 得到Excel的列数(前提是有行数)
		if (totalRows >= 1 && sheet.getRow(0) != null) {
			this.totalCells = sheet.getRow(0).getPhysicalNumberOfCells();
		}

		List<ImportExcel> pmList = new ArrayList<ImportExcel>();

		// 循环Excel行数,从第三行开始。标题不入库
		data: for (int r = 1; r < this.totalRows; r++) {
			Row row = sheet.getRow(r);
			if (row == null)
				continue;

			ImportExcel im = new ImportExcel();
			for (int c = 0; c < this.totalCells; c++) {
				Cell cel = row.getCell(0);
				if (cel == null) {
					break data;
				}
				switch (c) {
				case 0:
					Cell cell_0 = row.getCell(0);
					cell_0.setCellType(Cell.CELL_TYPE_STRING);
					im.setOrderId(Tools.replaceBlank(cell_0.getStringCellValue()));
					break;

				case 2:
					Cell cell_2 = row.getCell(2);
					cell_2.setCellType(Cell.CELL_TYPE_STRING);
					im.setConsignee(Tools.replaceBlank(cell_2.getStringCellValue()));
					break;
				case 3:
					Cell cell_3 = row.getCell(3);
					cell_3.setCellType(Cell.CELL_TYPE_STRING);
					im.setConsigneetelephone(Tools.replaceBlank(cell_3.getStringCellValue()));
					break;

				case 4:
					Cell cell_4 = row.getCell(4);
					cell_4.setCellType(Cell.CELL_TYPE_STRING);
					im.setConsigneeprovince(Tools.replaceBlank(cell_4.getStringCellValue()));
					break;

				case 5:
					Cell cell_5 = row.getCell(5);
					cell_5.setCellType(Cell.CELL_TYPE_STRING);
					im.setConsigneecity(Tools.replaceBlank(cell_5.getStringCellValue()));
					break;

				case 6:
					Cell cell_6 = row.getCell(6);
					cell_6.setCellType(Cell.CELL_TYPE_STRING);
					im.setConsigneedistrict(Tools.replaceBlank(cell_6.getStringCellValue()));
					break;

				case 7:
					Cell cell_7 = row.getCell(7);
					cell_7.setCellType(Cell.CELL_TYPE_STRING);
					im.setConsigneeaddress(Tools.replaceBlank(cell_7.getStringCellValue()));
					break;

				case 8:
					Cell cell_8 = row.getCell(8);
					cell_8.setCellType(Cell.CELL_TYPE_STRING);
					im.setTradename(Tools.replaceBlank(cell_8.getStringCellValue()));
					break;

				case 10:
					Cell cell_10 = row.getCell(c);
					cell_10.setCellType(Cell.CELL_TYPE_STRING);
					im.setCount(Tools.replaceBlank(cell_10.getStringCellValue()));
					break;
				
				case 14:
					Cell cell_14 = row.getCell(c);
					cell_14.setCellType(Cell.CELL_TYPE_STRING);
					im.setCardNO(Tools.replaceBlank(cell_14.getStringCellValue()));
					break;
				}
			}
			pmList.add(im);
			System.out.println("excel=====================================" + pmList.size());
		}
		return pmList;
	}

}
