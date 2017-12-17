"
I'm an abstract front-end to query timelines. 
my children bring the concrete timelines taking the right address. 

at start, a timeline is empty. It can be filled using #next (who will bring next statuses 20 to 20) or by #restart, which will reload from zero (performing a refresh of status, bringing new ones if there are).
"
Class {
	#name : #MdnTimeline,
	#superclass : #Object,
	#instVars : [
		'login',
		'statuses'
	],
	#category : #'Mastodon-Core'
}

{ #category : #'instance creation' }
MdnTimeline class >> login: aLogin [
	^ self new
		login: aLogin;
		yourself
]

{ #category : #accessing }
MdnTimeline class >> readLimit [
	^ 40
]

{ #category : #api }
MdnTimeline >> allSinceId: anId [
	| readedStatus id |
	id := anId.
	[ readedStatus := self retrieveStatusesSince: id.
	 readedStatus isEmpty or: [ statuses size > 200 ] ]
	whileFalse: [ 
		statuses := statuses, readedStatus.
		id :=  readedStatus first id ].
	^ statuses
]

{ #category : #initialization }
MdnTimeline >> initialize [
	super initialize.
	statuses := #()
]

{ #category : #api }
MdnTimeline >> last: aNumber [
	| readedStatus id |
	id := nil.
	[ readedStatus := self retrieveStatusesFrom: id.
	 readedStatus isEmpty or: [ statuses size >= aNumber ] ]
	whileFalse: [
		statuses := statuses, readedStatus.
		id := readedStatus last id ].
	^ statuses first: aNumber
]

{ #category : #accessing }
MdnTimeline >> login [
	^ login
]

{ #category : #accessing }
MdnTimeline >> login: anObject [
	login := anObject
]

{ #category : #api }
MdnTimeline >> next [
	^ self nextSinceId: (statuses 
		ifNotEmpty: [ statuses last id ]
		ifEmpty: [ nil ])
]

{ #category : #api }
MdnTimeline >> nextSinceId: anId [
	^ statuses := statuses, (self retrieveStatusesSince: anId)
]

{ #category : #api }
MdnTimeline >> restart [
	statuses := #().
	^ self next
]

{ #category : #private }
MdnTimeline >> retrieveStatusesFrom: anId [
	^ self retrieveStatusesWith: [ :request |
		anId ifNotNil: [ 
			request 
				queryAt: 'max_id' 
				put: anId ] ]
]

{ #category : #private }
MdnTimeline >> retrieveStatusesSince: anId [
	^ self retrieveStatusesWith: [ :request |
			anId ifNotNil: [ 
				request 
					queryAt: 'since_id' 
					put: anId ] ]
]

{ #category : #private }
MdnTimeline >> retrieveStatusesWith: aBlock [
	^ (self login 
		get: self url
		with: [ :request | 
			request authorizationBearer: self login accessToken.
			request queryAt: 'limit' put: self class readLimit.
			aBlock value: request ])
		collect: [ :each | 
			MdnStatus login: self login json: each ]
]

{ #category : #accessing }
MdnTimeline >> server [
	^ self login server
]

{ #category : #private }
MdnTimeline >> url [
	^ self subclassResponsibility
]
