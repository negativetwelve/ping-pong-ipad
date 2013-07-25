//
//  KBKegboardMessage.m
//  KegPad
//
//  Created by John Boiles on 9/27/10.
//  Copyright 2010 Yelp. All rights reserved.
//

#import "KBKegboardMessage.h"

char *const KBSP_PREFIX = kKBSP_PREFIX;
char *const KBSP_TRAILER = kKBSP_TRAILER;

@interface KBKegboardMessage ()
@property (assign, nonatomic) NSTimeInterval timeStamp;
- (void)parsePayload:(char *)payload length:(NSUInteger)length;
- (BOOL)parsePayload:(char *)data forTag:(NSUInteger)tag length:(NSUInteger)length;
@end

@implementation KBKegboardMessage

@synthesize messageId=_messageId, timeStamp=_timeStamp;

+ (id)messageWithId:(NSUInteger)messageId payload:(char *)payload length:(NSUInteger)length timeStamp:(NSTimeInterval)timeStamp {
  KBKegboardMessage *message = nil;
  switch (messageId) {
    case KB_MESSAGE_ID_HELLO:
      message = [[KBKegboardMessageHello alloc] initWithMessageId:messageId payload:payload length:length];
      break;
    case KB_MESSAGE_ID_BOARD_CONFIGURATION:
      message = [[KBKegboardMessageBoardConfiguration alloc] initWithMessageId:messageId payload:payload length:length];
      break;
    case KB_MESSAGE_ID_METER_STATUS:
      message = [[KBKegboardMessageMeterStatus alloc] initWithMessageId:messageId payload:payload length:length];
      break;
    case KB_MESSAGE_ID_TEMPERATURE_READING:
      message = [[KBKegboardMessageTemperatureReading alloc] initWithMessageId:messageId payload:payload length:length];
      break;
    case KB_MESSAGE_ID_OUTPUT_STATUS:
      message = [[KBKegboardMessageOutputStatus alloc] initWithMessageId:messageId payload:payload length:length];
      break;
    case KB_MESSAGE_ID_AUTH_TOKEN:
      message = [[KBKegboardMessageAuthToken alloc] initWithMessageId:messageId payload:payload length:length];
      break;
  }
  message.timeStamp = timeStamp;
  if (!message) NSLog(@"Got unknown message with ID %x", messageId);
  return message;
}

- (id)initWithMessageId:(NSUInteger)messageId payload:(char *)payload length:(NSUInteger)length {
  if ((self = [super init])) {
    _messageId = messageId;
    [self parsePayload:payload length:length];
  }
  return self;
}

- (void)parsePayload:(char *)payload length:(NSUInteger)length {
  NSUInteger index = 0;
  while (index < length) {
    NSUInteger tag = [KBKegboardMessage parseUInt8:&payload[index]];
    index++;
    NSUInteger length = [KBKegboardMessage parseUInt8:&payload[index]];
    index++;
    if (![self parsePayload:&payload[index] forTag:tag length:length]) NSLog(@"Failed to parse tag: %d", tag);
    index += length;
  }
}

- (BOOL)parsePayload:(char *)data forTag:(NSUInteger)tag length:(NSUInteger)length {
  NSAssert(NO, @"Abstract Method");
  return NO;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"KBKegboardMessage with messageId %u", _messageId];
}

+ (NSString *)parseString:(char *)stringData length:(NSUInteger)length {
  // NOTE: Kegboard docs say strings are null terminated, but in the latest version (as of 7/29/2010), they are not.
  // To be safe, check for null termination
  if (!stringData[length - 1]) length -= 1;
  return [[NSString alloc] initWithBytes:stringData length:length encoding:NSASCIIStringEncoding];
}

+ (NSUInteger)parseUInt32:(char *)data length:(NSUInteger)length {
  NSUInteger output = 0;
  for (NSInteger i = 0; i < length; i++) {
    output += (unsigned char)data[i] << (i * 8);
  }
  return output;
}

+ (NSUInteger)parseUInt8:(char *)data {
  return [KBKegboardMessage parseUInt32:data length:1];
}

+ (NSUInteger)parseUInt16:(char *)data {
  return [KBKegboardMessage parseUInt32:data length:2];
}

+ (NSUInteger)parseUInt32:(char *)data {
  return [KBKegboardMessage parseUInt32:data length:4];
}

+ (NSInteger)parseInt32:(char *)data {
  return (NSInteger)[KBKegboardMessage parseUInt32:data];
}

+ (double)parseTemp:(char *)data {
  NSInteger tempInteger = [KBKegboardMessage parseInt32:data];
  return ((double)tempInteger / 1000000);
}

+ (BOOL)parseBool:(char *)data {
  if (data[0] & 0xFF) return YES;
  else return NO;
}

@end

@implementation KBKegboardMessageHello
@synthesize protocolVersion=_protocolVersion;

- (BOOL)parsePayload:(char *)data forTag:(NSUInteger)tag length:(NSUInteger)length {
  switch (tag) {
    case 0x01:
      _protocolVersion = [KBKegboardMessage parseUInt16:data];
      break;
    default:
      return NO;
  }
  return YES;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"KBKegboardMessageHello with protocolVersion %u", _protocolVersion];
}

@end


@implementation KBKegboardMessageBoardConfiguration
@synthesize boardName=_boardName, baudRate=_baudRate, updateInterval=_updateInterval, watchdogTimeout=_watchdogTimeout;

- (BOOL)parsePayload:(char *)data forTag:(NSUInteger)tag length:(NSUInteger)length {
  switch (tag) {
    case 0x01:
      _boardName = [KBKegboardMessage parseString:data length:length];
      break;
    case 0x02:
      _baudRate = [KBKegboardMessage parseUInt16:data];
      break;
    case 0x03:
      _updateInterval = [KBKegboardMessage parseUInt16:data];
      break;
    case 0x04:
      _watchdogTimeout= [KBKegboardMessage parseUInt16:data];
      break;
    default:
      return NO;
  }
  return YES;
}


- (NSString *)description {
  return [NSString stringWithFormat:@"KBKegboardMessageBoardConfiguration with boardName %@ baudRate %u updateInterval %u watchdogTimeout %u", _boardName, _baudRate, _updateInterval, _watchdogTimeout];
}

@end


@implementation KBKegboardMessageMeterStatus
@synthesize meterName=_meterName, meterReading=_meterReading;

- (BOOL)parsePayload:(char *)data forTag:(NSUInteger)tag length:(NSUInteger)length {
  switch (tag) {
    case 0x01:
      _meterName = [KBKegboardMessage parseString:data length:length];
      break;
    case 0x02:
      _meterReading = [KBKegboardMessage parseUInt32:data];
      break;
    default:
      return NO;
  }
  return YES;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"KBKegboardMessageMeterStatus with meterName %@ _meterReading %u", _meterName, _meterReading];
}

@end


@implementation KBKegboardMessageTemperatureReading
@synthesize sensorName=_sensorName, sensorReading=_sensorReading;

- (BOOL)parsePayload:(char *)data forTag:(NSUInteger)tag length:(NSUInteger)length {
  switch (tag) {
    case 0x01:
      _sensorName = [KBKegboardMessage parseString:data length:length];
      break;
    case 0x02:
      _sensorReading = [KBKegboardMessage parseTemp:data];
      break;
    default:
      return NO;
  }
  return YES;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"KBKegboardMessageTemperatureReading with _sensorName %@ _sensorReading %f", _sensorName, _sensorReading];
}

@end


@implementation KBKegboardMessageOutputStatus
@synthesize outputName=_outputName, outputReading=_outputReading;

- (BOOL)parsePayload:(char *)data forTag:(NSUInteger)tag length:(NSUInteger)length {
  switch (tag) {
    case 0x01:
      _outputName = [KBKegboardMessage parseString:data length:length];
      break;
    case 0x02:
      _outputReading = [KBKegboardMessage parseBool:data];
      break;
    default:
      return NO;
  }
  return YES;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"KBKegboardMessageOutputStatus with _outputName %@ _outputReading %d", _outputName, _outputReading];
}

@end


@implementation KBKegboardMessageAuthToken
@synthesize deviceName=_deviceName, token=_token, status=_status;

- (BOOL)parsePayload:(char *)data forTag:(NSUInteger)tag length:(NSUInteger)length {
  switch (tag) {
    case 0x01:
      _deviceName = [KBKegboardMessage parseString:data length:length];
      break;
    case 0x02:
      _token = [KBKegboardMessage parseString:data length:length];
      break;
    case 0x03:
      _status = [KBKegboardMessage parseBool:data];
      break;
    default:
      return NO;
  }
  return YES;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"KBKegboardMessageAuthToken with _deviceName %@ _token %@ _stats %d", _deviceName, _token, _status];
}

@end