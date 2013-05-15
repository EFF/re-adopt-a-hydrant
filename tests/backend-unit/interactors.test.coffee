chai = require 'chai'
assert = chai.assert
sinon = require 'sinon'
mongoose = require 'mongoose'

describe 'interactors', () ->
    describe 'UserInteractor', () ->
        beforeEach () ->
            @fakeModel = 
                findById: sinon.stub().yields()
            sinon.stub mongoose, 'model', (model) =>
                return @fakeModel
            @userInteractor = require '../../server/interactors/user_interactor'
        afterEach () ->
            mongoose.model.restore()

        it 'should get a user by id', () ->
            callback = sinon.spy()
            @userInteractor.getById 'qweqwe123qwe132', callback

            assert.isTrue callback.calledOnce
            assert.isTrue @fakeModel.findById.calledOnce
            #assert.isTrue @fakeModel.findById.calledWith
