chai = require 'chai'
assert = chai.assert
sinon = require 'sinon'
mongoose = require 'mongoose'

describe 'interactors', () ->
    beforeEach () ->
        @fakeModel = 
            findById: sinon.stub().yields()
            find: sinon.stub().yields()
            findOne: sinon.stub().yields()
        sinon.stub mongoose, 'model', () =>
            return @fakeModel

    afterEach () ->
            mongoose.model.restore()

    describe 'UserInteractor', () ->
        beforeEach () ->
            @userInteractor = require '../../server/interactors/user_interactor'

        it 'should get a user by id', () ->
            callback = sinon.spy()
            userId = 'ajkhsdfg2736dakjhsdg28'
            @userInteractor.getById userId, callback

            assert.isTrue callback.calledOnce
            assert.isTrue @fakeModel.findById.calledOnce
            assert.isTrue @fakeModel.findById.calledWith(userId, 'id username displayName name', callback)

    describe 'AdoptionInteractor', () ->
        beforeEach () ->
            @adoptionInteractor = require '../../server/interactors/adoption_interactor'

        it 'should getUserAdoptions'
        it 'should getByHydrantId'
        it 'should adoptHydrant'

    describe 'HydrantInteractor', () ->
        beforeEach () ->
            @hydrantInteractor = require '../../server/interactors/hydrant_interactor'

        it 'should search'
        it 'should _createQuery'
        it 'should do something to refactor'
