package org.xdemo.superutil.j2se.filewatch;
 
/**
 * 文件变动行为枚举
 * @author Goofy <a href="http://www.xdemo.org/">http://www.xdemo.org/</a>
 * @Date 2015年7月3日 上午10:40:04
 */
public enum FileAction {
    DELETE("ENTRY_DELETE"), CREATE("ENTRY_CREATE"), MODIFY("ENTRY_MODIFY");
    private String value;
 
    FileAction(String value) {
        this.value = value;
    }
 
    public String getValue() {
        return value;
    }
}