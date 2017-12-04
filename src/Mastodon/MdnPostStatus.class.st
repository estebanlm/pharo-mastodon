Class {
	#name : #MdnPostStatus,
	#superclass : #Object,
	#instVars : [
		'login',
		'status',
		'inReplyTo',
		'medias',
		'spoilerText',
		'visibility',
		'sensitive'
	],
	#category : #'Mastodon-Core'
}

{ #category : #accessing }
MdnPostStatus >> inReplyTo [
	^ inReplyTo
]

{ #category : #accessing }
MdnPostStatus >> inReplyTo: anObject [
	inReplyTo := anObject
]

{ #category : #initialization }
MdnPostStatus >> initialize [
	super initialize.
	sensitive := false
]

{ #category : #testing }
MdnPostStatus >> isSensitive [
	^ sensitive
]

{ #category : #accessing }
MdnPostStatus >> login [
	^ login
]

{ #category : #accessing }
MdnPostStatus >> login: anObject [
	login := anObject
]

{ #category : #converting }
MdnPostStatus >> mastodonPostStatus [
	^ self
]

{ #category : #private }
MdnPostStatus >> mediaIdsAsArrayString [
	^ ('[', (self medias collect: #id) asCommaString), ']'
]

{ #category : #accessing }
MdnPostStatus >> medias [
	^ medias
]

{ #category : #accessing }
MdnPostStatus >> medias: anObject [
	medias := anObject
]

{ #category : #api }
MdnPostStatus >> post [ 
	^ MdnStatus 
		login: self 
		json: (self login 
			post: self server urlApi / 'statuses'
			with: [ :request |
				request 
					authorizationBearer: self login accessToken;
					formAt: 'status' put: self status;
					formAt: 'visibility' put: self visibility name.
				self inReplyTo 
					ifNotNil: [ request formAt: 'in_reply_to_id' put: self inReplyTo id ].
				self isSensitive 
					ifTrue: [ request formAt: 'sensitive' put: 'true' ].
				self medias isEmptyOrNil
					ifFalse: [ request formAt: 'media_ids' put: self mediaIdsAsArrayString ].
				self spoilerText 
					ifNotNil: [ request formAt: 'spoiler_text' put: self spoilerText ] ])
]

{ #category : #accessing }
MdnPostStatus >> sensitive: aBoolean [
	sensitive := aBoolean
]

{ #category : #accessing }
MdnPostStatus >> server [
	^ self login server
]

{ #category : #accessing }
MdnPostStatus >> spoilerText [
	^ spoilerText
]

{ #category : #accessing }
MdnPostStatus >> spoilerText: anObject [
	spoilerText := anObject
]

{ #category : #accessing }
MdnPostStatus >> status [
	^ status
]

{ #category : #accessing }
MdnPostStatus >> status: anObject [
	status := anObject
]

{ #category : #accessing }
MdnPostStatus >> visibility [
	^ visibility ifNil: [ visibility := MdnVisibility default ]
]

{ #category : #accessing }
MdnPostStatus >> visibility: anObject [
	visibility := anObject
]
