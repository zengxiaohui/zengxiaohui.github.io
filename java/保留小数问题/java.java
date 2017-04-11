/*a=0.00001234
保留完之后，结果为0.000012.*/
double a = 0.00001234;  
BigDecimal b = new BigDecimal(String.valueOf(a));  
BigDecimal divisor = BigDecimal.ONE;  
MathContext mc = new MathContext(2);  
System.out.println(b.divide(divisor, mc)); 

MathContext mc = new MathContext(2, RoundingMode.DOWN);  //向零方向舍入的舍入模式。从不对舍弃部分前面的数字加 1（即截尾）。注意，此舍入模式始终不会增加计算值的绝对值。

double   f   =   111231.5585;  
BigDecimal   b2   =   new   BigDecimal(f);  
BigDecimal   f1   =   b2.setScale(2,   BigDecimal.ROUND_HALF_UP);  
System.out.println(f1);