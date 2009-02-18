REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('ticket list','1','Displays a list of open GM tickets.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('ticket onlinelist','1','Displays a list of open GM tickets whose owner is online.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('ticket viewname','1','Usage: .ticket viewname $creatorname. \r\nReturns details about specified ticket. Ticket must be open and not deleted.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('ticket viewid','1','Usage: .ticket viewid $ticketid.\r\nReturns details about specified ticket. Ticket must be open and not deleted.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('ticket close','2','Usage: .ticket close $ticketid.\r\nCloses the specified ticket. Does not delete permanently.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('ticket delete','3','Usage: .ticket delete $ticketid.\r\nDeletes the specified ticket permanently. Ticket must be closed first.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('ticket assign','3','Usage: .ticket assign $ticketid $gmname.\r\nAssigns the specified ticket to the specified Game Master.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('ticket unassign','3','Usage: .ticket unassign $ticketid.\r\nUnassigns the specified ticket from the current assigned Game Master.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('ticket comment','2','Usage: .ticket comment $ticketid $comment.\r\nAllows the adding or modifying of a comment to the specified ticket.');
REPLACE INTO `command` (`name`,`security`,`help`) VALUES ('reload tickets','4','Usage: .reload tickets.\r\nReloads GM Tickets from the database and re-caches them into memory.');

