"
I represent a login into a mastodon instance. 
"
Class {
	#name : #MdnLogin,
	#superclass : #MdnEntity,
	#instVars : [
		'server',
		'account'
	],
	#category : #'Mastodon-Core'
}

{ #category : #'accessing api' }
MdnLogin >> accessToken [
	^ self jsonAt: 'access_token'
]

{ #category : #accessing }
MdnLogin >> account [
	^ account ifNil: [ account := self verifyCredentials ]
]

{ #category : #accessing }
MdnLogin >> application [
	^ self server application
]

{ #category : #'accessing api' }
MdnLogin >> createdAt [
	^ DateAndTime fromUnixTime: (self jsonAt: 'created_at')
]

{ #category : #api }
MdnLogin >> postStatus: aStringOrPostStatus [
	^ aStringOrPostStatus mastodonPostStatus
		login: self;
		post.
	

]

{ #category : #'accessing api' }
MdnLogin >> refreshToken [
	^ self jsonAt: 'refresh_token'
]

{ #category : #'accessing api' }
MdnLogin >> refreshToken: aString [
	^ self jsonAt: 'refresh_token' put: aString
]

{ #category : #'accessing api' }
MdnLogin >> scope [
	^ self jsonAt: 'scope'
]

{ #category : #accessing }
MdnLogin >> server [
	^ server
]

{ #category : #accessing }
MdnLogin >> server: anObject [
	server := anObject
]

{ #category : #'api timelines' }
MdnLogin >> timelineHashtag: aString [
	^ MdnTimelineHashtag login: self hashtag: aString
]

{ #category : #'api timelines' }
MdnLogin >> timelineHome [
	^ MdnTimelineHome login: self
]

{ #category : #'api timelines' }
MdnLogin >> timelinePublic [
	^ MdnTimelinePublic login: self
]

{ #category : #'accessing api' }
MdnLogin >> tokenType [
	^ self jsonAt: 'token_type'
]

{ #category : #api }
MdnLogin >> verifyCredentials [
	^ MdnAccount 
		login: self
		json: (self 
			get: (self server urlApiAccounts / 'verify_credentials')
			with: [ :request | request authorizationBearer: self accessToken ])
]
