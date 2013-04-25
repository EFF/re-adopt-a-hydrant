FacebookStrategy = require('passport-facebook').Strategy
TwitterStrategy = require('passport-twitter').Strategy
mongoose = require 'mongoose'

class StrategyFactory
    create: (provider) =>
        switch provider
            when 'facebook'
                options = 
                    clientID : process.env.FB_APP_ID
                    clientSecret : process.env.FB_SECRET
                    callbackURL : process.env.FB_CALLBACK_URL

                @strategy = new FacebookStrategy options, @verifyCallback
            when 'twitter'
                options = 
                    consumerKey : process.env.TWITTER_APP_ID
                    consumerSecret : process.env.TWITTER_APP_SECRET
                    callbackURL : process.env.TWITTER_CALLBACK_URL
                @strategy = new TwitterStrategy options, @verifyCallback
        return @strategy

    verifyCallback: (token, tokenSecret, profile, done) =>
        User = mongoose.model 'User'
        User.findOne {id: profile.id}, (err, returningUser) =>
            if err
                done err, null
            else if returningUser
                done null, returningUser
            else
                profile.accessToken = token
                newUser = new User profile
                console.log newUser
                newUser.save done

module.exports = new StrategyFactory()
