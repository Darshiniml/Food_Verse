package com.food_application.email;

import java.util.Properties;
import java.io.File;

import jakarta.mail.Multipart;
import jakarta.mail.BodyPart;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtility {

    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";

    public static boolean sendEmail(String to,
                                    String subject,
                                    String body) {

        try {

        	Properties props = new Properties();

        	props.put("mail.smtp.auth", "true");

        	props.put("mail.smtp.starttls.enable", "true");

        	props.put("mail.smtp.host", "smtp.gmail.com");

        	props.put("mail.smtp.port", "587");

        	props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        	props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
            Session session = Session.getInstance(props,
                    new Authenticator() {

                        @Override
                        protected PasswordAuthentication getPasswordAuthentication() {

                            return new PasswordAuthentication(
                                    EmailConfig.getUsername(),
                                    EmailConfig.getPassword());

                        }

                    });

            Message message = new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(
                            EmailConfig.getUsername()));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to));

            message.setSubject(subject);

            message.setContent(body, "text/html");

            Transport.send(message);

            System.out.println("Email Sent Successfully");

            return true;

        }

        catch (Exception e) {

            e.printStackTrace();

            return false;

        }

    }
    public static boolean sendEmailWithAttachment(
            String to,
            String subject,
            String body,
            File attachment) {

        try {

            Properties props = new Properties();

            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", HOST);
            props.put("mail.smtp.port", PORT);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

            Session session = Session.getInstance(
                    props,
                    new Authenticator() {

                        @Override
                        protected PasswordAuthentication getPasswordAuthentication() {

                            return new PasswordAuthentication(
                                    EmailConfig.getUsername(),
                                    EmailConfig.getPassword());

                        }

                    });

            MimeMessage message = new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(
                            EmailConfig.getUsername()));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to));

            message.setSubject(subject);

            Multipart multipart = new MimeMultipart();

            BodyPart htmlPart = new MimeBodyPart();

            htmlPart.setContent(body, "text/html");

            multipart.addBodyPart(htmlPart);

            MimeBodyPart attachmentPart =
                    new MimeBodyPart();

            attachmentPart.attachFile(attachment);

            multipart.addBodyPart(attachmentPart);

            message.setContent(multipart);

            Transport.send(message);

            return true;

        }

        catch (Exception e) {

            e.printStackTrace();

            return false;

        }

    }

}