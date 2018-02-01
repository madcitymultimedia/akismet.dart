# Akismet <small>for Dart</small>
![Runtime](https://img.shields.io/badge/dart-%3E%3D1.24-brightgreen.svg) ![Release](https://img.shields.io/pub/v/akismet.svg) ![License](https://img.shields.io/badge/license-MIT-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/akismet.dart/badge.svg) ![Build](https://travis-ci.org/cedx/akismet.dart.svg)

## Stop spam
![Akismet](img/akismet.png)  

Used by millions of websites, [Akismet](https://akismet.com) filters out hundreds of millions of spam comments from the Web every day.
Add Akismet to your [Dart](https://www.dartlang.org) applications so you don't have to worry about spam again.

## Getting started

### Get a developer key
You first need to [sign up for a developer key](https://akismet.com/signup/?connect=yes&plan=developer).
This will give you access to the API and will allow Akismet to monitor its results to make sure things are running as smoothly as possible.

!!! warning
    All Akismet API calls require a developer key.
    [Join the developer program](https://akismet.com/signup/?connect=yes&plan=developer)

### Building your application

#### Structuring your API calls
There are three different types of calls to Akismet:

1. [Key verification](features/key_verification.md) will verify whether or not a valid API key is being used. This is especially useful if you will have multiple users with their own Akismet subscriptions using your application.
2. [Comment check](features/comment_check.md) is used to ask Akismet whether or not a given post, comment, profile, etc. is spam.
3. [Submit spam](features/submit_spam.md) and [submit ham](features/submit_ham.md) are follow-ups to let Akismet know when it got something wrong (missed spam and false positives). These are very important, and you shouldn't develop using the Akismet API without a facility to include reporting missed spam and false positives.

Akismet works by examining all the available information combined. It is not enough to provide just the content of a message; you need to provide as many independent pieces of information as you can in each call. So before you can test Akismet's accuracy, you need to make sure you're sending complete and correct information.

#### Testing your API calls
To simulate a positive (spam) result, make a [comment check](features/comment_check.md) API call with the `Author#name` set to `"viagra-test-123"` or `Author#email` set to `"akismet-guaranteed-spam@example.com"`. Populate all other required fields with typical values. The Akismet API will always return a `true` response to a valid request with one of those values. If you receive anything else, something is wrong in your client, data, or communications.

To simulate a negative (not spam) result, make a [comment check](features/comment_check.md) API call with the `Author#role` set to `"administrator"` and all other required fields populated with typical values. The Akismet API will always return a `false` response. Any other response indicates a data or communication problem.

For automated testing, enable the `Client#isTest` parameter in your tests. That will tell Akismet not to change its behaviour based on those API calls – they will have no training effect. That means your tests will be somewhat repeatable, in the sense that one test won't influence subsequent calls.

#### Setting your user agent
If possible, your user agent string should always use the following format:

```
Application Name/Version | Plugin Name/Version
```

The default user agent string would look like:

```
Dart/1.24.0 | Akismet/4.0.0
```
