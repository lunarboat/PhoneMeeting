//
//  PersonNumberDAO.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "PersonNumberDAO.h"


@implementation PersonNumberDAO

+(BOOL)insertData:(PersonNumber*)person{
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    BOOL result = [db executeUpdate:@"INSERT INTO person(number,name,meeting_id,group_id) VALUES(?,?,?,?)",person.pNumber,person.pName,@(person.pMeetingId),@(person.pGroupId)];
    [db close];
    return result;
}

+(BOOL)deletePeopleWithGroupId:(int)groupId{
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    BOOL result = [db executeUpdate:@"DELETE FROM person WHERE person.group_id = (?)",@(groupId)];
    [db close];
    return result;
}
+(NSMutableArray*)queryPeopleWithGroupId:(int)groupId{
    NSMutableArray *people = [[NSMutableArray alloc]init];
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return nil;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM person WHERE person.group_id = (?)",@(groupId)];
    while([rs next]) {
        PersonNumber *person = [[PersonNumber alloc]init];
        person.pId = [rs intForColumn:@"id"];
        person.pName = [rs stringForColumn:@"name"];
        person.pNumber = [rs stringForColumn:@"number"];
        person.pMeetingId = [rs intForColumn:@"meeting_id"];
        person.pGroupId = [rs intForColumn:@"group_id"];
        [people addObject:person];
    }
    [rs close];
    [db close];
    return people;
}

@end
