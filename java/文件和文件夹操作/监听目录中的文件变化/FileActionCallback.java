package org.xdemo.superutil.j2se.filewatch;
 
import java.io.File;
 
/**
 * 文件操作的回调方法
 * @author Goofy <a href="http://www.xdemo.org/">http://www.xdemo.org/</a>
 * @Date 2015年7月6日 上午11:11:34
 */
public abstract class FileActionCallback {
 
    public void delete(File file) {
    };
 
    public void modify(File file) {
    };
 
    public void create(File file) {
    };
 
}