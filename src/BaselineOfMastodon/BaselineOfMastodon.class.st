Class {
	#name : #BaselineOfMastodon,
	#superclass : #BaselineOf,
	#category : #BaselineOfMastodon
}

{ #category : #baselines }
BaselineOfMastodon >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec package: 'Mastodon' ]

]
