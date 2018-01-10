package com.lh.crack;

import com.lh.crack.runnable.RunnableDemo;

public class App {

	public static void main(String[] args) {
		System.out.println("开始破解网站密码!");
		/*RunnableDemo R1 = new RunnableDemo("Thread-1", 4);
		R1.start();

		RunnableDemo R2 = new RunnableDemo("Thread-2", 5);
		R2.start();

		RunnableDemo R3 = new RunnableDemo("Thread-3", 6);
		R3.start();

		RunnableDemo R4 = new RunnableDemo("Thread-3", 7);
		R4.start();*/

		RunnableDemo R5 = new RunnableDemo("Thread-3", 8);
		R5.start();

	}

}
