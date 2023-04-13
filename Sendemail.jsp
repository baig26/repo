<%--
Document   : Sendemail
Created on : 12 Apr, 2023, 6:13:19 PM
Author     : Aatifulla Baig
--%>

<%@page import="java.security.Security"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <title>JSP Page</title>
     </head>
     <body>
        <%@ page import="javax.mail.*, javax.mail.internet.*, java.util.*" %>
          <%
          // Sender's email ID needs to be mentioned
               final String from = "aub26pvt@gmail.com";

          // Recipient's email ID needs to be mentioned
               String to = request.getParameter("emailInput");

          // Your email ID for notification
               String notificationEmail = "aatifullabaigmm@gmail.com";

          // Sender's email password needs to be mentioned
               final String password = "wwreptkhilrggsqi";

          // SMTP server information
               String smtpServer = "smtp.gmail.com";
               int smtpPort = 587;

          // Get system properties
               Properties props = System.getProperties();

          // Setup mail server
               props.put("mail.smtp.auth", "true");
               props.put("mail.smtp.starttls.enable", "true");
               props.put("mail.smtp.host", smtpServer);
               props.put("mail.smtp.port", smtpPort);

          // Get the default Session object.
               Session usersession = Session.getDefaultInstance(props,
                       new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                         return new PasswordAuthentication(from, password);
                    }
               });

               try {
          // Create a default MimeMessage object for client email.
                    MimeMessage clientMessage = new MimeMessage(usersession);
          // Set From: header field of the header.
                    clientMessage.setFrom(new InternetAddress(from));

          // Set To: header field of the header.
                    clientMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

          // Set Subject: header field
                    clientMessage.setSubject("Confirmation Email");

          // Set the message text
                    String name = request.getParameter("nameInput");
                    String messageBody = "Dear " + name + ",\n\nThank you for your interest in our services/products. We have received your request and we will get back to you as soon as possible.\n"
                            + "To help us serve you better, could you please provide us with more information about what you are looking for? This will help us understand your needs and provide you with more accurate information.\n"
                            + "Additionally, please let us know your contact details so that we can reach out to you easily. We assure you that all the information you provide will be kept confidential.\n"
                            + "Thank you again for choosing our services/products. We look forward to hearing back from you soon.\n"
                            + "Best regards,\n"
                            + "\n[M M Aatifulla Biag].";
                    clientMessage.setText(messageBody);

          // Send client email
                    Transport.send(clientMessage);

          // Create a default MimeMessage object for notification email.
                    MimeMessage notificationMessage = new MimeMessage(usersession);

          // Set From: header field of the header.
                    notificationMessage.setFrom(new InternetAddress(from));

          // Set To: header field of the header.
                    notificationMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(notificationEmail));

          // Set Subject: header field
                    notificationMessage.setSubject("New message received");

          // Set the message text
                    String notificationBody = "You have received a new message from " + name + " (" + to + ").\n\nMessage content:\n\n" + request.getParameter("messageInput");
                    notificationMessage.setText(notificationBody);

          // Send notification email
                    Transport.send(notificationMessage);

          // Redirect to success page
                     response.sendRedirect("index.html");
               } catch (MessagingException mex) {
                    mex.printStackTrace();
               }
          %>


     </body>
</html>
