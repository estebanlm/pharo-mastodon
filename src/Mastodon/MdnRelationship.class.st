"
I represent an account relationship.

https://github.com/tootsuite/documentation/blob/master/Using-the-API/API.md#relationship
"
Class {
	#name : #MdnRelationship,
	#superclass : #MdnEntity,
	#category : #'Mastodon-Core'
}

{ #category : #'accessing api' }
MdnRelationship >> blocking [
	"Whether the user is currently blocking the account"
	^ self jsonAt: 'blocking'
]

{ #category : #'accessing api' }
MdnRelationship >> domainBlocking [
	"Whether the user is currently blocking the accounts's domain"
	^ self jsonAt: 'domain_blocking'
]

{ #category : #'accessing api' }
MdnRelationship >> followedBy [
	"Whether the user is currently being followed by the account"
	^ self jsonAt: 'followed_by'
]

{ #category : #'accessing api' }
MdnRelationship >> following [
	"Whether the user is currently following the account"
	^ self jsonAt: 'following'
]

{ #category : #'accessing api' }
MdnRelationship >> id [
	"Target account id"
	^ self jsonAt: 'id'
]

{ #category : #'accessing api' }
MdnRelationship >> muting [
	"Whether the user is currently muting the account"
	^ self jsonAt: 'muting'
]

{ #category : #'accessing api' }
MdnRelationship >> requested [
	"Whether the user has requested to follow the account"
	^ self jsonAt: 'requested'
]
