-- Update Trainertype where unit is NOT a trainer:
UPDATE `creature_template` SET `trainer_type`=0 WHERE entry IN (1300,1703,2855,2870,5749,5750,5753,5815,6027,6328,6373,6374,6376,6382,11048,11050,11051,15494,12776,16639,16649,16703,16727,16746,23535);
