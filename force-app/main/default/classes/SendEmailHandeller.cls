public with sharing class SendEmailHandeller {

    public static void sendEmailToAdmin(Account acc){

        String accName;
        String message='An account has been created and the name is';
        List<Messaging.SingleEmailMessage> mailList =  new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();    
        User userObj=[select Id,Profile.Name,Email from user where Profile.Name='System Administrator'];

        mail.toAddresses = new String[] {userObj.Email ,'mohamedalimohamed440@gmail.com'};
        mail.setSubject('New Account was Created.');
        
        accName = acc.Name;
        message = message + accName;

        mail.setHtmlBody(message);
        mailList.add(mail);

        if (mailList.size() > 0) {
            Messaging.SendEmailResult[] results = Messaging.sendEmail(mailList);  
            
            if (results[0].success) {
                System.debug('Sent Success '+ results[0]);
            }else {
                System.debug('The email failed to send: '+ results[0].errors[0].message);
            }
        }
        


        




    }
}