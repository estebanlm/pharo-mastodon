Class {
	#name : #MdnVisibility,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Mastodon-Enum'
}

{ #category : #accessing }
MdnVisibility class >> allVisibilities [
	^ self subclasses collect: #uniqueInstance
]

{ #category : #accessing }
MdnVisibility class >> direct [
	^ MdnVisibilityDirect uniqueInstance
]

{ #category : #'instance creation' }
MdnVisibility class >> fromString: aString [
	^ self allVisibilities 
		detect: [ :each | each name = aString ]
]

{ #category : #'instance creation' }
MdnVisibility class >> new [
	self error: 'Use #uniqueInstance'
]

{ #category : #accessing }
MdnVisibility class >> private [
	^ MdnVisibilityPrivate uniqueInstance
]

{ #category : #accessing }
MdnVisibility class >> public [ 
	^ MdnVisibilityPublic uniqueInstance
]

{ #category : #'instance creation' }
MdnVisibility class >> uniqueInstance [
	self = MdnVisibility 
		ifTrue: [ self error: 'I''m an abstract class, use one of my children.' ].
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ]
]

{ #category : #accessing }
MdnVisibility class >> unlisted [
	^ MdnVisibilityUnlisted uniqueInstance
]

{ #category : #accessing }
MdnVisibility >> name [
	^ self subclassResponsibility
]

{ #category : #printing }
MdnVisibility >> printOn: stream [
	super printOn: stream.
	stream << '(' << self name << ')'
]
