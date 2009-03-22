delete from command where name in ('server difftime', 'npc addtemp', 'gobject addtemp', '');
insert into `command` (`name`, `security`, `help`) values('gobject tempadd','2','Adds a temporary gameobject that is not saved to DB.');
insert into `command` (`name`, `security`, `help`) values('npc tempadd','2','Adds temporary NPC, not saved to database.');
update command set name = "ahbotoption" where name = "ahbotoptions";
update command set name = "reload gm_tickets" where name = "reload tickets";
delete from command where name like "path%";
insert  into `command`(`name`,`security`,`help`) values ('wp load',2,'Syntax: .path load $pathid\nLoad pathid number for selected creature. Creature must have no waypoint data.');
insert  into `command`(`name`,`security`,`help`) values ('wp event',2,'Syntax: .path event $subcommand\nType .path event to see the list of possible subcommands or .help path event $subcommand to see info on subcommands.');
insert  into `command`(`name`,`security`,`help`) values ('wp event add',2,'Syntax: .path event add $subcommand\nAdd new waypoint action in DB.');
insert  into `command`(`name`,`security`,`help`) values ('wp event mod',2,'Syntax: .path mod $eventid $parameter $parameter_value\nModify parameter value for specified eventid.\nPossible parameters: pos_x, pos_y, pos_z, command, datalong, datalon2, dataint.');
insert  into `command`(`name`,`security`,`help`) values ('wp event listid',2,'Syntax: .path event listid $eventid\nShows specified eventid info.');
insert  into `command`(`name`,`security`,`help`) values ('wp unload',2,'Syntax: .path unload\nUnload path for selected creature.');
insert  into `command`(`name`,`security`,`help`) values ('wp show',2,'Syntax: .path show $option\nOptions:\non $pathid (or selected creature with loaded path) - Show path\noff - Hide path\ninfo $slected_waypoint - Show info for selected waypoint.');
insert  into `command`(`name`,`security`,`help`) values ('wp mod ',2,'Syntax: .path mod\nType .path mod to see the list of possible subcommands or .help path mod $subcommand to see info on subcommands.');
insert  into `command`(`name`,`security`,`help`) values ('wp mod del',2,'Syntax: .path mod del\nDelete selected waypoint.');
insert  into `command`(`name`,`security`,`help`) values ('wp mod move',2,'Syntax: .path mod move\nChange selected waypoint coordinates to your position.');
insert  into `command`(`name`,`security`,`help`) values ('wp mod move_flag',2,'Syntax: .path mod move_flag\nSet move/run flag.');
insert  into `command`(`name`,`security`,`help`) values ('wp mod action',2,'Syntax: .path mod action\nAssign action (waypoint script id) to selected waypoint.');
insert  into `command`(`name`,`security`,`help`) values ('wp mod action_chance',2,'Syntax: .path mod action_chance\nAssign chance.');