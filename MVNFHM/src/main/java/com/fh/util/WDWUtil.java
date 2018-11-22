package com.fh.util;

public class WDWUtil {
    // 判断是否为excel2003
  public static boolean isExcel2003(String filePath)  {  
       return filePath.matches("^.+\\.(?i)(xls)$");  
   }  
 
  // 判断是否为excel2007
  public static boolean isExcel2007(String filePath)  {  
       return filePath.matches("^.+\\.(?i)(xlsx)$");  
   } 
}
