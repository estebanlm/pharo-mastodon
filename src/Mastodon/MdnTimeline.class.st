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

{ #category : #initialization }
MdnTimeline >> initialize [
	super initialize.
	statuses := #()
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
	^ statuses := statuses, (self retrieveStatusesSince: (statuses 
		ifNotEmpty: [ statuses last id ]
		ifEmpty: [ nil ]))
]

{ #category : #api }
MdnTimeline >> restart [
	statuses := #().
	^ self next
]

{ #category : #private }
MdnTimeline >> retrieveStatusesSince: anId [
	^ (self login 
		get: self url
		with: [ :request | 
			request authorizationBearer: self login accessToken.
			anId ifNotNil: [ 
				request queryAt: 'since_id' put: anId ] ])
		collect: [ :each | MdnStatus login: self login json: each ]
]

{ #category : #accessing }
MdnTimeline >> server [
	^ self login server
]

{ #category : #private }
MdnTimeline >> url [
	^ self subclassResponsibility
]
