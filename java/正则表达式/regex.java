String str="<p style=\"font-size:1.3em;font-weight:bold\">No page with that title exists.</p> ";
String regex="<p(.*?)>(.*?)</p> ";
Pattern p =Pattern.compile(regex);
Matcher m=p.matcher(str);
while(m.find()){
	System.out.println(m.group(0));
 System.out.println(m.group(1));
 System.out.println(m.group(2));
 	str = "<div>"+m.group(2)+"</div>";
}
System.out.println(str);

? 是懒惰匹配，一旦匹配到第一个就不往下走了。
.表示除\n之外的任意字符
*表示匹配0-无穷
+表示匹配1-无穷

"^\\w{6,16}$" //必须含有数字和字母的组合(\S 匹配所有非空白，而 \w 只匹配单词字符，等价于 [a-zA-Z0-9_] 共63个字符（字母数字下划线）。)

syso(Pattern.compile("^\\w{6,20}$").matcher("123456").find()) true;
console.log("123456".match("^(\\w){6,20}$") == null); true
