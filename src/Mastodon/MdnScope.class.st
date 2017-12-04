"
I represent a scope of access to mastodon.
"
Class {
	#name : #MdnScope,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #Mastodon
}

{ #category : #accessing }
MdnScope class >> allScopes [
	^ self subclasses collect: #uniqueInstance
]

{ #category : #accessing }
MdnScope class >> follow [
	^ MdnScopeFollow uniqueInstance
]

{ #category : #'instance creation' }
MdnScope class >> new [
	self error: 'Use #uniqueInstance'
]

{ #category : #accessing }
MdnScope class >> read [
	^ MdnScopeRead uniqueInstance
]

{ #category : #'instance creation' }
MdnScope class >> uniqueInstance [
	self = MdnScope ifTrue: [ 
		self error: 'I''m an abstract class, use one of my children' ].
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ]
]

{ #category : #accessing }
MdnScope class >> write [
	^ MdnScopeWrite uniqueInstance
]

{ #category : #accessing }
MdnScope >> name [
	^ self subclassResponsibility
]

{ #category : #printing }
MdnScope >> printOn: stream [ 
	super printOn: stream.
	stream << '(' << self name << ')'
]
