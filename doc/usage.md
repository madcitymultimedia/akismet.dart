# Usage
There are three different types of calls to Akismet:

1. [Key verification](features/key_verification.md) will verify whether or not a valid API key is being used. This is especially useful if you will have multiple users with their own Akismet subscriptions using your application.
2. [Comment check](features/comment_check.md) is used to ask Akismet whether or not a given post, comment, profile, etc. is spam.
3. [Submit spam](features/submit_spam.md) and [submit ham](features/submit_ham.md) are follow-ups to let Akismet know when it got something wrong (missed spam and false positives). These are very important, and you shouldn't develop using the Akismet API without a facility to include reporting missed spam and false positives.

## Setup the client
The `Client` class provides access to the Akismet API.

```dart
```

Akismet works by examining all the available information combined. It is not enough to provide just the content of a message; you need to provide as many independent pieces of information as you can in each call. So before you can test Akismet's accuracy, you need to make sure you're sending complete and correct information.

## Your blog or site

## The message's author

## The message's content



## Testing
To simulate a positive (spam) result, make a [comment check](features/comment_check.md) API call with the `Author#name` set to `"viagra-test-123"` or `Author#email` set to `"akismet-guaranteed-spam@example.com"`. Populate all other required fields with typical values. The Akismet API will always return a `true` response to a valid request with one of those values. If you receive anything else, something is wrong in your client, data, or communications.

To simulate a negative (not spam) result, make a [comment check](features/comment_check.md) API call with the `Author#role` set to `"administrator"` and all other required fields populated with typical values. The Akismet API will always return a `false` response. Any other response indicates a data or communication problem.

For automated testing, enable the `Client#isTest` parameter in your tests. That will tell Akismet not to change its behaviour based on those API calls – they will have no training effect. That means your tests will be somewhat repeatable, in the sense that one test won't influence subsequent calls.

## Setting your user agent
If possible, your user agent string should always use the following format:

```
Application Name/Version | Plugin Name/Version
```

The default user agent string would look like:

```
Dart/2.0.0 | Akismet/4.0.0
```

## The `Client` class
Used to query the Akismet service.

You must create a client with an API key and a blog.

## The `Blog` class
It describes your website ou blog.

You must provide a blog with a URL.

## The `Author` class
It describes the author of a post, comment, profile, etc.

You must create an author....

## The `Comment` class
It describes the content submitted.

You must create a comment....
