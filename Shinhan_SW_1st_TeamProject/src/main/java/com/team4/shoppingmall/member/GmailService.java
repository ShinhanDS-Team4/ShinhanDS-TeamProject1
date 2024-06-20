package com.team4.shoppingmall.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class GmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendEmail(String to, String subject, String body) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject(subject);
        message.setText(body);
        message.setFrom("ljk5252525@gmail.com"); // 실제 발신자 이메일 주소

        javaMailSender.send(message);
    }
    public void sendEmail() {
    	SimpleMailMessage message = new SimpleMailMessage();
    	message.setTo("kimsh142536@gmail.com");
    	message.setSubject("종경이형 테스트");
    	message.setText("테스트 완료 하자 ");
    	message.setFrom("ljk5252525@gmail.com"); // 실제 발신자 이메일 주소
    	
    	javaMailSender.send(message);
    }
}
