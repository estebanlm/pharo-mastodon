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
		'sensitive',
		'mediaAttachments'
	],
	#category : #'Mastodon-Core'
}

{ #category : #converting }
MdnPostStatus >> asMastodonPostStatus [
	^ self
]

{ #category : #'accessing api' }
MdnPostStatus >> inReplyTo [
	^ inReplyTo
]

{ #category : #'accessing api' }
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

{ #category : #private }
MdnPostStatus >> mediaIdsAsArrayString [
	mediaAttachments ifNil: [ ^ '[]' ].
	^ ('[', (mediaAttachments collect: #id) asCommaString), ']'
]

{ #category : #'accessing api' }
MdnPostStatus >> medias [
	^ medias
]

{ #category : #'accessing api' }
MdnPostStatus >> medias: anObject [
	medias := anObject
]

{ #category : #api }
MdnPostStatus >> post [ 
	self medias ifNotNil: [ self postMedias ].
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

{ #category : #api }
MdnPostStatus >> postMedias [
	mediaAttachments := self medias collect: [ :each | 
		each 
			login: self login;
			upload ]
]

{ #category : #'accessing api' }
MdnPostStatus >> sensitive: aBoolean [
	sensitive := aBoolean
]

{ #category : #accessing }
MdnPostStatus >> server [
	^ self login server
]

{ #category : #'accessing api' }
MdnPostStatus >> spoilerText [
	^ spoilerText
]

{ #category : #'accessing api' }
MdnPostStatus >> spoilerText: anObject [
	spoilerText := anObject
]

{ #category : #'accessing api' }
MdnPostStatus >> status [
	^ status
]

{ #category : #'accessing api' }
MdnPostStatus >> status: anObject [
	status := anObject
]

{ #category : #'accessing api' }
MdnPostStatus >> visibility [
	^ visibility ifNil: [ visibility := MdnVisibility default ]
]

{ #category : #'accessing api' }
MdnPostStatus >> visibility: anObject [
	visibility := anObject
]
