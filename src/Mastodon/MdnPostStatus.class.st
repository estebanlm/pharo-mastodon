"
I'm a post status: a status to create a post. 
This is different to a regular status because data sent is different to data received and responsibilities of each one is different. 

I'm used to post a new status. 
I can have a content text, reply status and medias. 

NOTE: the medias I will add are also special objects, instances of MdnPostMedia.

example: 

MdnPostStatus new
	login: aLogin;
	content: 'some text';
	medias: { MdnPostMedia fileName: 'a name' reference: aFileReference };
	post.
	
"
Class {
	#name : #MdnPostStatus,
	#superclass : #Object,
	#instVars : [
		'login',
		'content',
		'inReplyTo',
		'medias',
		'spoilerText',
		'visibility',
		'sensitive',
		'mediaAttachments'
	],
	#category : #'Mastodon-Core'
}

{ #category : #'instance creation' }
MdnPostStatus class >> content: aString [
	^ self new content: aString
]

{ #category : #accessing }
MdnPostStatus >> addMedia: aPostMedia [
	medias ifNil: [ medias := #() ].
	medias := medias copyWith: aPostMedia
]

{ #category : #private }
MdnPostStatus >> addPostParametersTo: request [
	request 
		authorizationBearer: self login accessToken;
		formAt: 'status' put: self content;
		formAt: 'visibility' put: self visibility name.

	self inReplyTo 
		ifNotNil: [ request formAt: 'in_reply_to_id' put: self inReplyTo id ].
	self isSensitive 
		ifTrue: [ request formAt: 'sensitive' put: 'true' ].
	self mediaAttachments isEmptyOrNil
		ifFalse: [ 
			self mediaAttachments do: [ :each | request formAt: 'media_ids[]' put: each id ] ].	
	self spoilerText 
		ifNotNil: [ request formAt: 'spoiler_text' put: self spoilerText ]
]

{ #category : #converting }
MdnPostStatus >> asMastodonPostStatus [
	^ self
]

{ #category : #'accessing api' }
MdnPostStatus >> content [
	^ content
]

{ #category : #'accessing api' }
MdnPostStatus >> content: anObject [
	content := anObject
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

{ #category : #'accessing api' }
MdnPostStatus >> mediaAttachments [
	^ mediaAttachments
]

{ #category : #private }
MdnPostStatus >> mediaIdsAsArrayString [
	mediaAttachments ifNil: [ ^ '[]' ].
	^ ('[', (mediaAttachments collect: [ :each | each id asString surroundedBy: $" asString]) asCommaString), ']'
]

{ #category : #accessing }
MdnPostStatus >> medias [
	^ medias
]

{ #category : #accessing }
MdnPostStatus >> medias: aCollection [
	"Medias needs to be a collection of MdnPostMedia to actually work."
	medias := aCollection
]

{ #category : #api }
MdnPostStatus >> post [
	"First try to collect post medias" 
	self medias ifNotNil: [ self uploadMedias ].
	"then actually post (and answer a status)"
	^ MdnStatus 
		login: self login
		json: (self login 
			post: self server urlApi / 'statuses'
			with: [ :request | self addPostParametersTo: request ])
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

{ #category : #private }
MdnPostStatus >> uploadMedia: aPostMedia [
	^ aPostMedia
		login: self login;
		upload
]

{ #category : #private }
MdnPostStatus >> uploadMedias [
	mediaAttachments := self medias 
		collect: [ :each | self uploadMedia: each ]
]

{ #category : #'accessing api' }
MdnPostStatus >> visibility [
	^ visibility ifNil: [ visibility := MdnVisibility default ]
]

{ #category : #'accessing api' }
MdnPostStatus >> visibility: anObject [
	visibility := anObject
]
