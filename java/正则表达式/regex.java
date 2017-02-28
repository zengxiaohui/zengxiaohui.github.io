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