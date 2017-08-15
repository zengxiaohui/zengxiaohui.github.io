import java.io.File;   

public class FindAllFile {      
	public static void main(String args[]){
		String dir ="d:/upload";          
		FindAllFile findAllFile =new FindAllFile();         
		findAllFile.findFileByDir(dir); 
	}
    
	public String findFileByDir(String dir){         
		File file =new File(dir);         
		if("".equals(dir)||dir==null){             
			return "";         
		}else{          
			String[] fileName = file.list();                   
			for (int i=0;i<fileName.length;i++){              
				if(new File(fileName[i]).isDirectory()){                 
					//如果发现文件夹 递归进行列出文件                
					findFileByDir(fileName[i]);                              
				}else{                  
					//如果为文件打印出文件                  
					System.out.println(fileName[i]);             
				}         
			}            
			return "";  
		}
	}
}
