//
//  Copyright (c) 2020 Open Whisper Systems. All rights reserved.
//

#import "TSInvalidIdentityKeySendingErrorMessage.h"
#import "OWSFingerprint.h"
#import "OWSIdentityManager.h"
#import "PreKeyBundle+jsonDict.h"
#import "SSKSessionStore.h"
#import "TSContactThread.h"
#import "TSOutgoingMessage.h"
#import <AxolotlKit/NSData+keyVersionByte.h>
#import <SignalServiceKit/SignalServiceKit-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSInvalidIdentityKeySendingErrorMessage ()

@property (nonatomic, readonly) PreKeyBundle *preKeyBundle;

@end

#pragma mark -

// DEPRECATED - we no longer create new instances of this class (as of  mid-2017); However, existing instances may
// exist, so we should keep this class around to honor their old behavior.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
@implementation TSInvalidIdentityKeySendingErrorMessage
#pragma clang diagnostic pop

- (nullable instancetype)initWithCoder:(NSCoder *)coder
{
    return [super initWithCoder:coder];
}

// --- CODE GENERATION MARKER

// This snippet is generated by /Scripts/sds_codegen/sds_generate.py. Do not manually edit it, instead run `sds_codegen.sh`.

// clang-format off

- (instancetype)initWithGrdbId:(int64_t)grdbId
                      uniqueId:(NSString *)uniqueId
             receivedAtTimestamp:(uint64_t)receivedAtTimestamp
                          sortId:(uint64_t)sortId
                       timestamp:(uint64_t)timestamp
                  uniqueThreadId:(NSString *)uniqueThreadId
                   attachmentIds:(NSArray<NSString *> *)attachmentIds
                            body:(nullable NSString *)body
                      bodyRanges:(nullable MessageBodyRanges *)bodyRanges
                    contactShare:(nullable OWSContact *)contactShare
                 expireStartedAt:(uint64_t)expireStartedAt
                       expiresAt:(uint64_t)expiresAt
                expiresInSeconds:(unsigned int)expiresInSeconds
              isViewOnceComplete:(BOOL)isViewOnceComplete
               isViewOnceMessage:(BOOL)isViewOnceMessage
                     linkPreview:(nullable OWSLinkPreview *)linkPreview
                  messageSticker:(nullable MessageSticker *)messageSticker
                   quotedMessage:(nullable TSQuotedMessage *)quotedMessage
    storedShouldStartExpireTimer:(BOOL)storedShouldStartExpireTimer
              wasRemotelyDeleted:(BOOL)wasRemotelyDeleted
                       errorType:(TSErrorMessageType)errorType
                            read:(BOOL)read
                recipientAddress:(nullable SignalServiceAddress *)recipientAddress
                       messageId:(NSString *)messageId
                    preKeyBundle:(PreKeyBundle *)preKeyBundle
{
    self = [super initWithGrdbId:grdbId
                        uniqueId:uniqueId
               receivedAtTimestamp:receivedAtTimestamp
                            sortId:sortId
                         timestamp:timestamp
                    uniqueThreadId:uniqueThreadId
                     attachmentIds:attachmentIds
                              body:body
                        bodyRanges:bodyRanges
                      contactShare:contactShare
                   expireStartedAt:expireStartedAt
                         expiresAt:expiresAt
                  expiresInSeconds:expiresInSeconds
                isViewOnceComplete:isViewOnceComplete
                 isViewOnceMessage:isViewOnceMessage
                       linkPreview:linkPreview
                    messageSticker:messageSticker
                     quotedMessage:quotedMessage
      storedShouldStartExpireTimer:storedShouldStartExpireTimer
                wasRemotelyDeleted:wasRemotelyDeleted
                         errorType:errorType
                              read:read
                  recipientAddress:recipientAddress];

    if (!self) {
        return self;
    }

    _messageId = messageId;
    _preKeyBundle = preKeyBundle;

    return self;
}

// clang-format on

// --- CODE GENERATION MARKER

- (void)throws_acceptNewIdentityKey
{
    // Shouldn't really get here, since we're no longer creating blocking SN changes.
    // But there may still be some old unaccepted SN errors in the wild that need to be accepted.
    OWSFailDebug(@"accepting new identity key is deprecated.");

    NSData *_Nullable newIdentityKey = [self throws_newIdentityKey];
    if (!newIdentityKey) {
        OWSFailDebug(@"newIdentityKey is unexpectedly nil. Bad Prekey bundle?: %@", self.preKeyBundle);
        return;
    }

    [[OWSIdentityManager shared] saveRemoteIdentity:newIdentityKey address:self.recipientAddress];
}

- (nullable NSData *)throws_newIdentityKey
{
    return [self.preKeyBundle.identityKey throws_removeKeyType];
}

- (SignalServiceAddress *)theirSignalAddress
{
    return self.recipientAddress;
}

@end

NS_ASSUME_NONNULL_END
