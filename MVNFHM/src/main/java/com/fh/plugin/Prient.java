package com.fh.plugin;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;

/**
 * 通用热敏打印机类
 * 
 * @author HL0523
 *
 */
public class Prient implements Printable {

     // 订单信息
	 
	// 包裹列表
	
	// 收件人
	
	
	// 寄件人

	
	
	/**
	 * 打印方法 graphics - 用来绘制页面的上下文，即打印的图形 pageFormat -
	 * 将绘制页面的大小和方向，即设置打印格式，如页面大小一点为计量单位（以1/72 英寸为单位，1英寸为25.4毫米。A4纸大致为595 × 842点）
	 * 小票纸宽度一般为58mm，大概为165点
	 * 
	 * pageIndex - 要绘制的页面从 0 开始的索引 ，即页号
	 */
	public int print(Graphics graphics, PageFormat pageFormat, int pageIndex) throws PrinterException {
		// TODO Auto-generated method stub
		// 此 Graphics2D 类扩展 Graphics 类，以提供对几何形状、坐标转换、颜色管理和文本布局更为复杂的控制。
		// 它是用于在 Java(tm) 平台上呈现二维形状、文本和图像的基础类。
		Graphics2D g2 = (Graphics2D) graphics;
		g2.setColor(Color.black);// 设置打印颜色为黑色

		// 打印起点坐标
		double x = pageFormat.getImageableX(); // 返回与此 PageFormat相关的 Paper对象的可成像区域左上方点的 x坐标。
		double y = pageFormat.getImageableY(); // 返回与此 PageFormat相关的 Paper对象的可成像区域左上方点的 y坐标。

		// Font.PLAIN： 普通样式常量 Font.ITALIC 斜体样式常量 Font.BOLD 粗体样式常量。
		Font font = new Font("宋体", Font.PLAIN, 8); // 根据指定名称、样式和磅值大小，创建一个新 Font
		g2.setFont(font);// 设置标题打印字体

		float heigth = font.getSize2D();// 获取字体的高度
		// 设置小票的标题标题
		g2.drawString("2016-09-08", (float) x + 10, (float) y + heigth);
		g2.drawString("订单号:20160908123123123", (float) x + 30, (float) y + heigth);

		float line = 2 * heigth; // 下一行开始打印的高度
		line += 2;
		g2.drawString("默认揽收门店:XXX店", (float) x + 10, (float) y + line);
		g2.drawString("总运费:100", (float) x + 60, (float) y + line);

		line += 2 * heigth;
		g2.drawString("寄件人信息:姓名:", (float) x + 10, (float) y + line);
		g2.drawString("电话:18659840060", (float) x + 60, (float) y + line);
		line += heigth;
		g2.drawString("联系地址:XXXXXXXXXXXXXXXXXXXXXXXX", (float) x + 60, (float) y + line);

		line += 2 * heigth;
		g2.drawString("收件人信息:姓名:郭芬", (float) x + 10, (float) y + line);
		g2.drawString("电话:18659840060", (float) x + 60, (float) y + line);
		line += heigth;
		g2.drawString("联系地址:XXXXXXXXXXXXXXXXXXXXXXXX", (float) x + 60, (float) y + line);

		
		// 包裹列表
		line += 2 * heigth;
		g2.drawString("包裹A", (float) x + 10, (float) y + line);
		line += heigth;
		g2.drawString("寄件物品信息", (float) x + 10, (float) y + line);
		g2.drawString("运单单号:XXXXXXX", (float) x + 60, (float) y + line);
		line += heigth;
		g2.drawString("类型", (float) x + 10, (float) y + line);
		g2.drawString("品牌", (float) x + 30, (float) y + line);
		g2.drawString("品名", (float) x + 60, (float) y + line);
		g2.drawString("X件", (float) x + 90, (float) y + line);
		g2.drawString("XXX(磅)", (float) x + 120, (float) y + line);
		g2.drawString("运费:XXX", (float) x + 150, (float) y + line);

		switch (pageIndex) {
		case 0:
			return PAGE_EXISTS; // 0
		default:
			return NO_SUCH_PAGE; // 1
		}

	}

}
