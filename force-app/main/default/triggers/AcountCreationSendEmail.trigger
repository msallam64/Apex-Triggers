trigger AcountCreationSendEmail on Account (after insert) {

    Account acc = Trigger.new[0];

    if (Trigger.isAfter && Trigger.isInsert) {

        SendEmailHandeller.sendEmailToAdmin(acc); 
        
    }

}