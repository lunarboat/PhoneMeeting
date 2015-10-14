//
//  MeetingDAO.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "MeetingDAO.h"

@implementation MeetingDAO

+(BOOL)insertData:(Meeting*)meet{
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    BOOL result = [db executeUpdate:@"INSERT INTO meeting(theme,host,date,time) VALUES(?,?,?,?)",meet.mTheme,meet.mHost,meet.mDate,meet.mTime];
    [db close];
    return result;
}
+(int)queryMaxId{
    int i = 0;
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return -1;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT MAX(id) FROM meeting"];
    if ([rs next]) {
        i = [rs intForColumn:@"MAX(id)"];
    }
    [rs close];
    [db close];
    return i;
}
+(NSMutableArray*)queryMeeting{
    NSMutableArray *meets = [[NSMutableArray alloc]init];
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return nil;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM meeting"];
    while([rs next]) {
        Meeting *meet = [[Meeting alloc]init];
        meet.mId = [rs intForColumn:@"id"];
        meet.mTheme = [rs stringForColumn:@"theme"];
        meet.mHost = [rs stringForColumn:@"host"];
        meet.mDate = [rs stringForColumn:@"date"];
        meet.mTime = [rs stringForColumn:@"time"];
        [meets addObject:meet];
    }
    [rs close];
    [db close];
    return meets;
}
+(BOOL)deleteMeeting:(Meeting*)meet{
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    BOOL result = [db executeUpdate:@"DELETE FROM meeting WHERE meeting.id = (?)",@(meet.mId)];
    [db close];
    return result;
}

@end
