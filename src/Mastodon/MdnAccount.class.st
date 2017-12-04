"
I represent a mastodon account.

https://github.com/tootsuite/documentation/blob/master/Using-the-API/API.md#account

"
Class {
	#name : #MdnAccount,
	#superclass : #MdnEntity,
	#instVars : [
		'login'
	],
	#category : #Mastodon
}

{ #category : #'accessing api' }
MdnAccount >> acct [
	"Equals username for local users, includes @domain for remote ones"
	^ self jsonAt: 'acct'
]

{ #category : #'accessing api' }
MdnAccount >> avatar [
	"URL to the avatar image"
	^ self jsonAt: 'avatar'
]

{ #category : #'accessing api' }
MdnAccount >> avatarStatic [
	"URL to the avatar static image (gif)"
	^ self jsonAt: 'avatar_static'
]

{ #category : #'accessing api' }
MdnAccount >> createdAt [
	"The time the account was created"
	^ self jsonAt: 'created_at'
]

{ #category : #'accessing api' }
MdnAccount >> displayName [
	"The account's display name"
	^ self jsonAt: 'display_name'
]

{ #category : #'accessing api' }
MdnAccount >> followersCount [
	"The number of followers for the account"
	^ self jsonAt: 'followers_count'
]

{ #category : #'accessing api' }
MdnAccount >> followingCount [
	"The number of accounts the given account is following"
	^ self jsonAt: 'following_count'
]

{ #category : #'accessing api' }
MdnAccount >> header [
	"URL to the header image"
	^ self jsonAt: 'header'
]

{ #category : #'accessing api' }
MdnAccount >> headerStatic [
	"URL to the header static image (gif)"
	^ self jsonAt: 'header_static'
]

{ #category : #'accessing api' }
MdnAccount >> id [	
	"The ID of the account"
	^ self jsonAt: 'id'
]

{ #category : #'accessing api' }
MdnAccount >> locked [
	"Boolean for when the account cannot be followed without waiting for approval first	"
	^ self jsonAt: 'locked'
]

{ #category : #accessing }
MdnAccount >> login [
	^ login
]

{ #category : #accessing }
MdnAccount >> login: anObject [
	login := anObject
]

{ #category : #'accessing api' }
MdnAccount >> note [
	"Biography of user"
	^ self jsonAt: 'note'
]

{ #category : #accessing }
MdnAccount >> server [
	^ self login server
]

{ #category : #api }
MdnAccount >> statuses [
	| statuses |
	statuses := self 
		get: self server urlApiAccounts / self id / 'statuses'
		with: [ :request | request authorizationBearer: self login accessToken ].
	^ statuses 
]

{ #category : #'accessing api' }
MdnAccount >> statusesCount [
	"The number of statuses the account has made"
	^ self jsonAt: 'statuses_count'
]

{ #category : #'accessing api' }
MdnAccount >> url [
	"URL of the user's profile page (can be remote)"
	^ self jsonAt: 'url'
]

{ #category : #'accessing api' }
MdnAccount >> username [
	"The username of the account"
	^ self jsonAt: 'username'
]
