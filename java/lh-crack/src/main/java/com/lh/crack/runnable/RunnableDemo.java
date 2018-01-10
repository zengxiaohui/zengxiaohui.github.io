package com.lh.crack.runnable;

import com.lh.crack.CrackPassword;

/**
 * 线程工厂
 * @author zeng_xiaohui
 *
 */
public class RunnableDemo implements Runnable {
   private Thread t;
   private String threadName;
   private String[] passChar ={ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "a", "b", "c", "d", "e", "f", "g", "h",
			"i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C",
			"D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X",
			"Y", "Z", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "=", "_", "+", "<", ">", "?", "/", "|" };
   private int digit;
   
   public RunnableDemo( String name,int digt) {
      threadName = name;
      digit = digt;
      System.out.println("创建 " +  threadName );
   }
   
   public void run() {
      System.out.println("运行 " +  threadName );
      CrackPassword crackPassword = new CrackPassword();
	  crackPassword.getPassword(passChar, digit);
      System.out.println("线程 " +  threadName + " 结束.");
   }
   
   public void start () {
      System.out.println("开始线程 " +  threadName );
      if (t == null) {
         t = new Thread (this, threadName);
         t.start ();
      }
   }
}