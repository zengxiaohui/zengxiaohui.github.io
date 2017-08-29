public class EmailUtils {

	//发送邮件到草稿箱
	public static void sendMail(String to, String title, String content) {  
		// 第一步：创建Session
		Properties props = new Properties();
		// 指定邮件的传输协议，smtp(Simple Mail Transfer Protocol 简单的邮件传输协议)
		props.put("mail.transport.protocol", smtp);
		// 指定邮件发送服务器服务器 "smtp.qq.com"
		props.put("mail.host", smtpHost);
		// 指定邮件的发送人(您用来发送邮件的服务器，比如您的163\sina等邮箱)
		props.put("mail.from", sendName);
		if (true) {
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.socketFactory.fallback", "false");
			props.put("mail.smtp.socketFactory.port", smtpSendPort);
		}
		Session session = Session.getDefaultInstance(props);
        try {         
        	Store store = session.getStore("imap");
	         store.connect(imapHost, userName, userPwd); 
            Folder folder = store.getFolder("Drafts");// 打开草稿箱    
            MimeMessage mmessage = new MimeMessage(session);  
            mmessage.setFrom(new InternetAddress(nick + " <" + sendName + ">")); 
            mmessage.setRecipient(Message.RecipientType.TO,new InternetAddress(to));  
            mmessage.setSubject(title);  
            Multipart mainPart = new MimeMultipart();  
            BodyPart html = new MimeBodyPart();  
            html.setContent(content, "text/html; charset=utf-8");  
            mainPart.addBodyPart(html);  
            mmessage.setContent(mainPart);  
            mmessage.setSentDate(new Date());  
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = sdf.parse("2017-08-26 18:08:00");
			mmessage.setSentDate(date);
            mmessage.saveChanges();  
            mmessage.setFlag(Flags.Flag.DRAFT, true);  
            MimeMessage draftMessages[] = {mmessage};  
            System.out.println(mmessage.getSubject());  
            folder.appendMessages(draftMessages);  
//          Transport.send(mmessage);  
            System.out.println("保存成功");  
        } catch (Exception ex) {  
            ex.printStackTrace();  
        }  
    }  	
}