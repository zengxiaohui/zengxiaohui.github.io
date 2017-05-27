package org.zeng.win;

import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

import org.zeng.file.Operation;

public class WindowFrame {
	
	//新建一个JFrame对象frame，同时其标题栏为No Title
	private JFrame jFrame = new JFrame("将手机号转换为sha256密文");
	private JButton jb = new JButton("上传");
	
	public void show(){
		jb.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				JFileChooser jfc = new JFileChooser();
				if (jfc.showOpenDialog(jFrame) == JFileChooser.APPROVE_OPTION) {
					// 解释下这里,弹出个对话框,可以选择要上传的文件,如果选择了,就把选择的文件的绝对路径打印出来,有了绝对路径,通过JTextField的settext就能设置进去了,那个我没写
					String filePath=jfc.getSelectedFile().getAbsolutePath();
					if(".txt".equals(filePath.substring(filePath.length()-4, filePath.length()))){
						Operation operation = new Operation();
						operation.writeStringToTxtFile(operation.readTxtFile(filePath));
						// 弹出对话框可以改变里面的参数具体得靠大家自己去看，时间很短  
			            JOptionPane.showMessageDialog(null, "手机号转换为sha256密文完成请到D盘下查看", "提示", 2);  
					}else{
						JOptionPane.showMessageDialog(null, "请选择txt文本文档", "提示", 2);  
					}
				}
			}
		});
		// 这下面的不用在意 一些设置
		jFrame.add(jb);
		jFrame.setLayout(new FlowLayout());
		jFrame.setSize(480, 320);//定义窗口大小
		//jFrame.setLocation(100,200);//定义窗口位置
		jFrame.setLocationRelativeTo(null);
		jFrame.setVisible(true);//定义是否可见，true为不可见
		
		//使右上角的关闭按钮生效，如果没有这句，点击右上角的关闭按钮只能关闭窗口，无法结束进程 
		jFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
}
